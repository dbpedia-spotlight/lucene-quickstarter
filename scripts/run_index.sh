#!/bin/bash

VERSION=$1
LANGUAGE=$2

echo ${LANGUAGE} ${VERSION}

readonly JAVA_XMX=14G
readonly ROOT_DIR=/mnt/dbpedia/
readonly SPOTLIGHT_INDEX=${ROOT_DIR}lucene-quickstarter/dbpedia-spotlight/index
readonly SPOTLIGHT_OUTPUT_FILES=${ROOT_DIR}spotlight/${LANGUAGE}/
readonly INDEX_CONFIG_FILE=${ROOT_DIR}lucene-quickstarter/i18n/${LANGUAGE}/indexing_${VERSION}.properties

mkdir -p $SPOTLIGHT_OUTPUT_FILES

cd $SPOTLIGHT_INDEX

# first step is to extract valid URIs, synonyms and surface forms from DBpedia#
mvn scala:run -Dlauncher=ExtractCandidateMap "-DjavaOpts.Xmx=$JAVA_XMX" "-DaddArgs=${INDEX_CONFIG_FILE}"

# now we collect parts of Wikipedia dump where DBpedia resources occur and output those occurrences as Tab-Separated-Values
echo -e "Parsing Wikipedia dump to extract occurrences...\n"
mvn scala:run -Dlauncher=ExtractOccsFromWikipedia "-DjavaOpts.Xmx=$JAVA_XMX" "-DaddArgs=${INDEX_CONFIG_FILE}|${SPOTLIGHT_OUTPUT_FILES}occs.tsv"

# (recommended) sorting the occurrences by URI will speed up context merging during indexing
echo -e "Sorting occurrences to speed up indexing...\n"
sort -t$'\t' -k2 ${SPOTLIGHT_OUTPUT_FILES}occs.tsv >${SPOTLIGHT_OUTPUT_FILES}occs.uriSorted.tsv

echo -e "Extracting Surface Forms...\n"
cat ${SPOTLIGHT_OUTPUT_FILES}occs.uriSorted.tsv | cut -d$'\t' -f 2,3 |  perl -F/\\t/ -lane 'print "$F[1]\t$F[0]";' > ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.tsv
sort ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.tsv | uniq -c > ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.count
grep -Pv "      [123] " ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.count | sed -r "s|\s+[0-9]+\s(.+)|\1|" > ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs-thresh3.tsv


cp ${SPOTLIGHT_OUTPUT_FILES}surfaceForms.tsv ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromTitRedDis.tsv
cat ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromTitRedDis.tsv ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.tsv > ${SPOTLIGHT_OUTPUT_FILES}surfaceForms.tsv

set -e
# create a lucene index out of the occurrences
echo -e "Creating a context index from occs.tsv...\n"
mvn scala:run -Dlauncher=IndexMergedOccurrences "-DjavaOpts.Xmx=$JAVA_XMX" "-DaddArgs=${INDEX_CONFIG_FILE}|${SPOTLIGHT_OUTPUT_FILES}occs.uriSorted.tsv"

# add surface forms to index
echo -e "Adding Surface Forms to index...\n"
mvn scala:run -Dlauncher=AddSurfaceFormsToIndex "-DjavaOpts.Xmx=$JAVA_XMX" "-DaddArgs=${INDEX_CONFIG_FILE}|${SPOTLIGHT_OUTPUT_FILES}/index"

# add entity types to index
mvn scala:run -Dlauncher=AddTypesToIndex "-DjavaOpts.Xmx=$JAVA_XMX" "-DaddArgs=${INDEX_CONFIG_FILE}|${SPOTLIGHT_OUTPUT_FILES}/index-withSF"

mvn scala:run -Dlauncher=IndexLingPipeSpotter "-DjavaOpts.Xmx=$JAVA_XMX" "-DaddArgs=${INDEX_CONFIG_FILE}|false|index"
