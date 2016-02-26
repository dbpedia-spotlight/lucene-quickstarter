#!/bin/bash
readonly ROOT_DIRECTORY=/mnt/dbpedia
readonly DBPEDIA_VERSION=$1
readonly LANG_i18n=$2
readonly LANG_DESC=$3
readonly LUCENE_CLASS=$4

echo "# Wikipedia Dump" > ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# --------------" >> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.wikipediaDump=${ROOT_DIRECTORY}/wikipedia/${LANG_i18n}/${LANG_i18n}wiki-latest-pages-articles.xml">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# Location for DBpedia resources index (output)">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.index.dir=${ROOT_DIRECTORY}/spotlight/${LANG_i18n}/index">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.index.minDocsBeforeFlush=40000">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# DBpedia Datasets">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# ----------------">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.labels=${ROOT_DIRECTORY}/dbpedia_data/${DBPEDIA_VERSION}/${LANG_i18n}/labels_${LANG_i18n}.nt.bz2">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.redirects=${ROOT_DIRECTORY}/dbpedia_data/${DBPEDIA_VERSION}/${LANG_i18n}/redirects_${LANG_i18n}.nt.bz2">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.disambiguations=${ROOT_DIRECTORY}/dbpedia_data/${DBPEDIA_VERSION}/${LANG_i18n}/disambiguations_${LANG_i18n}.nt.bz2">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.instanceTypes=${ROOT_DIRECTORY}/dbpedia_data/${DBPEDIA_VERSION}/${LANG_i18n}/instance_types_${LANG_i18n}.nt.bz2">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# Files created from DBpedia Datasets">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# -----------------------">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.conceptURIs=${ROOT_DIRECTORY}/spotlight/${LANG_i18n}/conceptURIs.list">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.redirectsTC=${ROOT_DIRECTORY}/spotlight/${LANG_i18n}/redirects_tc.tsv">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.surfaceForms=${ROOT_DIRECTORY}/spotlight/${LANG_i18n}/surfaceForms-fromOccs.tsv">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# Language-specific config">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# --------------">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.language=${LANG_DESC}">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.language_i18n_code=${LANG_i18n}">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.lucene.analyzer=${LUCENE_CLASS}">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.lucene.version=LUCENE_36">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# Internationalization (i18n) support">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
if [ "${LANG_i18n}" == "en" ]; then
	echo "org.dbpedia.spotlight.default_namespace=http://dbpedia.org/resource/">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
else
	echo "org.dbpedia.spotlight.default_namespace=http://${LANG_i18n}.dbpedia.org/resource/">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
fi	
echo "org.dbpedia.spotlight.default_ontology=http://dbpedia.org/ontology/">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# Stop word list">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.stopWords.${LANG_DESC}=${ROOT_DIRECTORY}/lucene-quickstarter/i18n/${LANG_i18n}/stopwords.list">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# URI patterns that should not be indexed. e.g. List_of_*">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.badURIs.${LANG_DESC}=${ROOT_DIRECTORY}/lucene-quickstarter/i18n/${LANG_i18n}/blacklistedURIPatterns.${LANG_i18n}.list">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# Will discard surface forms that are too long (reduces complexity of spotting and generally size in disk/memory)">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.maxSurfaceFormLength=50">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "# Will index only words closest to resource occurrence">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.maxContextWindowSize=200">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
echo "org.dbpedia.spotlight.data.minContextWindowSize=0">> ../i18n/${LANG_i18n}/indexing_${DBPEDIA_VERSION}.properties
