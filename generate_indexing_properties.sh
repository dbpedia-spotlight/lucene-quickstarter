#!/bin/bash
current_directory=`pwd`"/$lang_i18n"


# Wikipedia Dump
# --------------
#org.dbpedia.spotlight.data.wikipediaDump = /usr/local/spotlight/dbpedia_data/original/wikipedia/enwiki-latest-pages-articles.xml.bz2
echo "org.dbpedia.spotlight.data.wikipediaDump=$current_directory/dbpedia_data/original/wikipedia/$lang_i18n/$lang_i18n""wiki-latest-pages-articles.xml.bz2"

# Location for DBpedia resources index (output
#org.dbpedia.spotlight.index.dir =/usr/local/spotlight/dbpedia_data/data/output/index
echo "org.dbpedia.spotlight.index.dir=$current_directory/dbpedia_data/data/output/index"
#org.dbpedia.spotlight.index.minDocsBeforeFlush = 40000
echo "org.dbpedia.spotlight.index.minDocsBeforeFlush = 40000"

# DBpedia Datasets
# ----------------
#org.dbpedia.spotlight.data.labels=/usr/local/spotlight/dbpedia_data/original/dbpedia/en/labels_en.nt.bz2
echo "org.dbpedia.spotlight.data.labels=$current_directory/dbpedia_data/original/dbpedia/$lang_i18n/labels_$lang_i18n.nt.bz2"
#org.dbpedia.spotlight.data.redirects=$current_directory/dbpedia_data/original/dbpedia/en/redirects_en.nt.bz2
echo "org.dbpedia.spotlight.data.redirects=$current_directory/dbpedia_data/original/dbpedia/$lang_i18n/redirects_$lang_i18n.nt.bz2"
#org.dbpedia.spotlight.data.disambiguations=/usr/local/spotlight/dbpedia_data/original/dbpedia/en/disambiguations_en.nt.bz2
echo "org.dbpedia.spotlight.data.disambiguations=$current_directory/dbpedia_data/original/dbpedia/$lang_i18n/disambiguations_$lang_i18n.nt.bz2"
#org.dbpedia.spotlight.data.instanceTypes = /usr/local/spotlight/dbpedia_data/original/dbpedia/en/instance_types_en.nt.bz2
echo "org.dbpedia.spotlight.data.instanceTypes=$current_directory/dbpedia_data/original/dbpedia/$lang_i18n/instance_types_$lang_i18n.nt.bz2"

# Files created from DBpedia Datasets
# -----------------------
#org.dbpedia.spotlight.data.conceptURIs = /usr/local/spotlight/dbpedia_data/data/output/conceptURIs.list
echo "org.dbpedia.spotlight.data.conceptURIs=$current_directory/dbpedia_data/data/output/conceptURIs.list"
#org.dbpedia.spotlight.data.redirectsTC = /usr/local/spotlight/dbpedia_data/data/output/redirects_tc.tsv
echo "org.dbpedia.spotlight.data.redirectsTC=$current_directory/dbpedia_data/data/output/redirects_tc.tsv"
#org.dbpedia.spotlight.data.surfaceForms = /usr/local/spotlight/dbpedia_data/data/output/surfaceForms.tsv
echo "org.dbpedia.spotlight.data.surfaceForms=$current_directory/dbpedia_data/data/output/surfaceForms.tsv"

# Language-specific config
# --------------
#org.dbpedia.spotlight.language = English
echo "org.dbpedia.spotlight.language=$language"
#org.dbpedia.spotlight.language_i18n_code = tr
echo "org.dbpedia.spotlight.language_i18n_code=$lang_i18n"
#org.dbpedia.spotlight.lucene.analyzer = org.apache.lucene.analysis.snowball.SnowballAnalyzer
echo "org.dbpedia.spotlight.lucene.analyzer=org.apache.lucene.analysis.snowball.SnowballAnalyzer"
#org.dbpedia.spotlight.lucene.version = LUCENE_36
echo "org.dbpedia.spotlight.lucene.version=LUCENE_36"

# Internationalization (i18n) support
#org.dbpedia.spotlight.default_namespace = http://dbpedia.org/resource/
echo "org.dbpedia.spotlight.default_namespace=http://$lang_i18n.dbpedia.org/resource/"
#org.dbpedia.spotlight.default_ontology= http://dbpedia.org/ontology/
echo "org.dbpedia.spotlight.default_ontology=http://dbpedia.org/ontology/"

# Stop word list
#org.dbpedia.spotlight.data.stopWords.turkish = stopwords.list
echo "org.dbpedia.spotlight.data.stopWords.$language=$current_directory/stopwords.list"

# URI patterns that should not be indexed. e.g. List_of_*
#org.dbpedia.spotlight.data.badURIs.english = /data/spotlight/blacklistedURIPatterns.en.list
echo "org.dbpedia.spotlight.data.badURIs.$language=$current_directory/blacklistedURIPatterns.$lang_i18n.list"

# Will discard surface forms that are too long (reduces complexity of spotting and generally size in disk/memory)
#org.dbpedia.spotlight.data.maxSurfaceFormLength = 50
echo "org.dbpedia.spotlight.data.maxSurfaceFormLength=50"
# Will index only words closest to resource occurrence
#org.dbpedia.spotlight.data.maxContextWindowSize = 200
echo "org.dbpedia.spotlight.data.maxContextWindowSize=200"
#org.dbpedia.spotlight.data.minContextWindowSize = 0
echo "org.dbpedia.spotlight.data.minContextWindowSize=0"
