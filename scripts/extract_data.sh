#!/bin/bash
set -e

VERSION=$1
LANGUAGE=$2

echo ${LANGUAGE} ${VERSION}

readonly JAVA_XMX=12G
readonly ROOT_DIR=/mnt/dbpedia/
readonly ROOT_DIR_TEMP=/mnt/dbpedia/tmp
readonly SPOTLIGHT_INDEX=${ROOT_DIR}lucene-quickstarter/dbpedia-spotlight/index
readonly SPOTLIGHT_OUTPUT_FILES=${ROOT_DIR}spotlight/${LANGUAGE}/
readonly INDEX_CONFIG_FILE=${ROOT_DIR}lucene-quickstarter/i18n/${LANGUAGE}/indexing_${VERSION}.properties

mkdir -p $SPOTLIGHT_OUTPUT_FILES
mkdir -p $ROOT_DIR_TEMP

cd $SPOTLIGHT_INDEX

echo ${INDEX_CONFIG_FILE} 

# first step is to extract valid URIs, synonyms and surface forms from DBpedia#
mvn scala:run -Dlauncher=ExtractCandidateMap "-DjavaOpts.Xmx=$JAVA_XMX -DtotalEntitySizeLimit=0 -Djdk.xml.totalEntitySizeLimit=0" "-DaddArgs=${INDEX_CONFIG_FILE}"

# now we collect parts of Wikipedia dump where DBpedia resources occur and output those occurrences as Tab-Separated-Values
echo -e "Parsing Wikipedia dump to extract occurrences...\n"
mvn scala:run -Dlauncher=ExtractOccsFromWikipedia "-DjavaOpts.Xmx=$JAVA_XMX" "-DaddArgs=${INDEX_CONFIG_FILE}|${SPOTLIGHT_OUTPUT_FILES}occs.tsv"

# (recommended) sorting the occurrences by URI will speed up context merging during indexing
echo -e "Sorting occurrences to speed up indexing...\n"
sort --temporary-directory=${ROOT_DIR_TEMP} -t$'\t' -k2 ${SPOTLIGHT_OUTPUT_FILES}occs.tsv >${SPOTLIGHT_OUTPUT_FILES}occs.uriSorted.tsv

echo -e "Extracting Surface Forms...\n"
cat ${SPOTLIGHT_OUTPUT_FILES}occs.uriSorted.tsv | cut -d$'\t' -f 2,3 |  perl -F/\\t/ -lane 'print "$F[1]\t$F[0]";' > ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.tsv
sort --temporary-directory=${ROOT_DIR_TEMP} ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.tsv | uniq -c > ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.count
grep -Pv "      [123] " ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.count | sed -r "s|\s+[0-9]+\s(.+)|\1|" > ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs-thresh3.tsv


cp ${SPOTLIGHT_OUTPUT_FILES}surfaceForms.tsv ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromTitRedDis.tsv
cat ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromTitRedDis.tsv ${SPOTLIGHT_OUTPUT_FILES}surfaceForms-fromOccs.tsv > ${SPOTLIGHT_OUTPUT_FILES}surfaceForms.tsv