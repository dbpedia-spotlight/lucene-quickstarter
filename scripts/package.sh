#!/bin/bash

VERSION=$1
LANGUAGE=$2


readonly ROOT_DIR=/mnt/dbpedia/

cp ${ROOT_DIR}/lucene-quickstarter/conf/similarity-thresholds.txt ${ROOT_DIR}/spotlight/${LANGUAGE}/index-withSF-withTypes
tar -zcvf ${LANGUAGE}_${VERSION} ${ROOT_DIR}/spotlight/${LANGUAGE}/index-withSF-withTypes ${ROOT_DIR}/lucene-quickstarter/conf ${ROOT_DIR}/lucene-quickstarter/i18n/${LANGUAGE}.tar.gz
