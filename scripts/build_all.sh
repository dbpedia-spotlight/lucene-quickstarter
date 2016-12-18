#!/bin/bash
set -e
readonly DBPEDIA_VERSION=$1
readonly all_languages=(es  it nl pl pt ru ca el fr de en)

for lang in ${all_languages[@]}
do
./download_dbpedia.sh ${DBPEDIA_VERSION} ${lang}
./download_wikipedia.sh ${lang}
./index_all.sh ${DBPEDIA_VERSION}
./build_lucene_index.sh ${DBPEDIA_VERSION} ${lang}
./package.sh ${DBPEDIA_VERSION} ${lang}
./publish_sf.sh ${DBPEDIA_VERSION} ${lang} &
done

