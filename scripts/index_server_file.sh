#!/bin/bash
readonly ROOT_DIRECTORY=/mnt/dbpedia
readonly DBPEDIA_VERSION=$1
readonly LANG_i18n=$2
readonly LANG_DESC=$3
readonly LUCENE_CLASS=$4


echo "# Server hostname and port to be used by DBpedia Spotlight REST API> " > ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.web.rest.uri=http://localhost:2222/rest" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# Internationalization (i18n) support" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.default_namespace=http://${LANG_i18n}.dbpedia.org/resource/" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.default_ontology= http://dbpedia.org/ontology/" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# Defines the languages the system should support." >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.language=${LANG_DESC}" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.language_i18n_code=${LANG_i18n}" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# Stop word list" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.stopWords.${LANG_i18n}=${ROOT_DIRECTORY}/lucene-quickstarter/i18n/${LANG_i18n}" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "#----- SPOTTING -------" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.spot.spotters=LingPipeSpotter" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# Path to serialized LingPipe dictionary used by LingPipeSpotter" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.spot.dictionary=${ROOT_DIRECTORY}/spotlight/${LANG_i18n}/surfaceForms-fromOccs.tsv.spotterDictionary" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.spot.allowOverlap=false" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.spot.caseSensitive=false" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# Path to serialized HMM model for LingPipe-based POS tagging. Required by AtLeastOneNounSelector and CoOccurrenceBasedSelector" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.tagging.hmm=${ROOT_DIRECTORY}/conf/pos-en-general-brown.HiddenMarkovModel" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "#----- DISAMBIGUATION -------" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# List of disambiguators to load: Document,Occurrences,CuttingEdge,Default" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.disambiguate.disambiguators=Document,Default" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# Path to a directory containing Lucene index files. These can be downloaded from the website or created by org.dbpedia.spotlight.lucene.index.IndexMergedOccurrences" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.index.dir=${ROOT_DIRECTORY}/spotlight/${LANG_i18n}/index-withSF-withTypes" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# Will attempt to load into RAM (the potentially huge) index from "org.dbpedia.spotlight.index.dir"" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.index.loadToMemory=false" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# Class used to process context around DBpedia mentions (tokenize, stem, etc.)" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.lucene.analyzer=${LUCENE_CLASS}" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.lucene.version=LUCENE_36" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# How large can the cache be for ICFDisambiguator." >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "jcs.default.cacheattributes.MaxObjects=5000" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "#----- LINKING / FILTERING  -------" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "# Configuration for SparqlFilter" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.sparql.endpoint=http://dbpedia.org/sparql" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.sparql.graph=http://dbpedia.org" >> ../i18n/${LANG_i18n}/server_${DBPEDIA_VERSION}.properties
