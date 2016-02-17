package org.dbpedia.spotlight.io

/**
 * Copyright 2011 Pablo Mendes, Max Jakob
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import org.dbpedia.extraction.wikiparser.impl.simple.SimpleWikiParser
import org.dbpedia.spotlight.string.WikiMarkupStripper
import org.dbpedia.spotlight.model._
import org.dbpedia.extraction.wikiparser._
import org.dbpedia.extraction.sources.{Source, XMLSource}
import org.dbpedia.spotlight.log.SpotlightLog
import java.io.{File}
import org.dbpedia.spotlight.util.FileUtils

import scala.util.matching.Regex
import xml.{XML, Elem}
import org.dbpedia.extraction.util.Language

/**
 * Loads Occurrences from a wiki dump.
 */

class AllOccurrenceSource( blacklistedURIPatterns : Set[Regex])
{
    val MULTIPLY_DISAMBIGUATION_CONTEXT = 10

    val splitParagraphsRegex = """(\n|(<br\s?/?>))(</?\w+?\s?/?>)?(\n|(<br\s?/?>))+"""
    val splitDisambiguationsRegex = """\n"""

    //TODO Add fromInputStream requires that XMLSource from the DEF supports that. Currently only supports fromFile and fromXML

    /**
     * Creates an DBpediaResourceOccurrence Source from a dump file.
     */
    def fromXMLDumpFile(dumpFile : File, language: Language) : OccurrenceSource =
    {
        new AllOccurrenceSource(XMLSource.fromFile(dumpFile, language, _.namespace == Namespace.Main))
    }

    /**
     * DBpediaResourceOccurrence Source which reads from a wiki pages source.
     */
    private class AllOccurrenceSource(wikiPages : Source, multiplyDisambigs : Int=MULTIPLY_DISAMBIGUATION_CONTEXT) extends OccurrenceSource
    {
        val wikiParser = new SimpleWikiParser()


        def replacePattern(content :String) : String = {
            var result = content

            blacklistedURIPatterns.foreach( b=> {
                result = result.replace(b.pattern.pattern(), "")
            })

            result
        }

        override def foreach[U](f : DBpediaResourceOccurrence => U) : Unit =
        {
            var pageCount = 0
            var occCount = 0

            for (wikiPage <- wikiPages)
            {
                var pageNode = wikiParser( wikiPage )

                // disambiguations
                if (!None.canEqual(pageNode) && pageNode.isDisambiguation) {
                    // clean the wiki markup from everything but links
                    val cleanSource = WikiMarkupStripper.stripEverythingButBulletPoints(wikiPage.source)

                    // parse the (clean) wiki page
                    pageNode = wikiParser( WikiPageUtil.copyWikiPage(wikiPage, cleanSource) )

                    if (!None.canEqual(pageNode) ) {
                        val surfaceForm = new SurfaceForm(replacePattern(wikiPage.title.decoded))


                        // split the page node into list items
                        val listItems = NodeUtil.splitNodes(pageNode.children, splitDisambiguationsRegex)
                        var itemsCount = 0
                        for (listItem <- listItems) {
                            itemsCount += 1
                            val id = pageNode.title.encoded + "-pl" + itemsCount
                            DisambiguationContextSource.getOccurrence(listItem, surfaceForm, id) match {
                                case Some(occ) => {
                                    (1 to multiplyDisambigs).foreach { i => f(occ) }
                                    occCount += 1
                                }
                                case None =>
                            }
                        }
                    }
                }

                // definitions and occurrences
                else if (!None.canEqual(pageNode) && !pageNode.isRedirect) {   // and not a disambiguation
                    // Occurrences

                    // clean the wiki markup from everything but links
                    val cleanSource = WikiMarkupStripper.stripEverything(wikiPage.source)

                    // parse the (clean) wiki page
                    pageNode = wikiParser( WikiPageUtil.copyWikiPage(wikiPage, cleanSource) )
    
                    // split the page node into paragraphs
                    val paragraphs = NodeUtil.splitNodes(pageNode.children, splitParagraphsRegex)
                    var paragraphCount = 0
                    for (paragraph <- paragraphs) {
                        paragraphCount += 1
                        val idBase = pageNode.title.encoded+"-p"+paragraphCount
                        WikiOccurrenceSource.getOccurrences(paragraph, idBase).foreach{occ =>
                            occCount += 1
                            f(occ)
                        }
                    }

                    // Definition a.k.a. WikiPageContext
                    val resource = new DBpediaResource(pageNode.title.encoded)
                    val surfaceForm = new SurfaceForm(pageNode.title.decoded.replaceAll(""" \(.+?\)$""", ""))
                    val pageContext = new Text( WikiPageContextSource.getPageText(pageNode) )
                    val offset = pageContext.text.indexOf(surfaceForm.name)
                    f( new DBpediaResourceOccurrence(pageNode.title.encoded+"-", resource, surfaceForm, pageContext, offset, Provenance.Wikipedia) )

                }

                pageCount += 1
                if (pageCount %100000 == 0) {
                    SpotlightLog.info(this.getClass, "Processed %d Wikipedia definition pages (average %.2f links per page)", pageCount, occCount/pageCount.toDouble)
                }
            }
        }
    }
}