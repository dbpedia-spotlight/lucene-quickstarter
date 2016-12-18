#!/bin/bash

set -e

VERSION=$1
LANGUAGE=$2

scp ${LANGUAGE}_${VERSION}.tar.gz sandrocoelho@frs.sourceforge.net:/home/frs/project/dbpedia-spotlight/${VERSION} 

