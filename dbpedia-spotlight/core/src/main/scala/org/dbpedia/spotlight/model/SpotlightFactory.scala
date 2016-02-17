/*
 * Copyright 2011 DBpedia Spotlight Development Team
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 *  Check our project website for information on how to acknowledge the authors and how to contribute to the project: http://spotlight.dbpedia.org
 */

package org.dbpedia.spotlight.model

import java.io.File

import org.dbpedia.spotlight.lucene.LuceneManager
import org.dbpedia.spotlight.lucene.search.MergedOccurrencesContextSearcher

/**
  * This class contains many of the "defaults" for DBpedia Spotlight.
  * Maybe consider renaming to DefaultFactory or DBpediaSpotlightController
  *
  * @author pablomendes
  */
class SpotlightFactory(val configuration: SpotlightConfiguration) {
  val analyzer = configuration.analyzer
  assert(analyzer != null)

  val contextIndexDir = LuceneManager.pickDirectory(new File(configuration.getContextIndexDirectory))
  val contextLuceneManager = new LuceneManager.CaseInsensitiveSurfaceForms(contextIndexDir)
  // use this if all surface forms in the index are lower-cased
  val similarity = Factory.Similarity.fromConfig(configuration, contextLuceneManager)
  contextLuceneManager.setContextSimilarity(similarity) // set most successful Similarity
  contextLuceneManager.setDBpediaResourceFactory(configuration.getDBpediaResourceFactory)
  contextLuceneManager.setDefaultAnalyzer(configuration.getAnalyzer)
  val contextSearcher: MergedOccurrencesContextSearcher = new MergedOccurrencesContextSearcher(contextLuceneManager, configuration.getDisambiguatorConfiguration.isContextIndexInMemory)


}
