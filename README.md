Quickstarter for DBpedia Spotlight Lucene
===================

[![Join the chat at https://gitter.im/dbpedia-spotlight/lucene-quickstarter](https://badges.gitter.im/dbpedia-spotlight/lucene-quickstarter.svg)](https://gitter.im/dbpedia-spotlight/lucene-quickstarter?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

You can use this repository for creating lucene backend index of DBpedia Spotlight in your language.

The repo is ready to use for the follow languages: catalan, german , greek , english, spanish, french , italian, dutch, polish, portuguese, hungarian and russian.

## Why my language is not supported yet?

We are working on i18n support and you can help us on it. You just need update or create the stop words list and a black listed URI pattern (a small regex for disambiguation pages) for your target language. You can follow a lot of examples at /i18n folder.

## Requirements

To create a new  index you will require

* Linux;
* A good computer with enough memory (16 gb or more);
* Maven;
* Java 1.7;
 

## How to run

 * Create or mount a new folder in /mnt called dbpedia. It is our workspace
 * Clone this repo locally inside /mnt/dbpedia;
 * Download the latest dump of Wikipedia. You can use the command line
 
  `./lucene-quickstarter/scripts/download_wikipedia.sh LANGUAGE_CODE`
  
   E.g: `./lucene-quickstarter/scripts/download_wikipedia.sh en`  for english

 * Download the DBpedia dumps, just typing 
 
 `./lucene-quickstarter/scripts/download_dbpedia.sh.sh VERSION LANGUAGE_CODE`
 
   E.g: `./lucene-quickstarter/scripts/download_dbpedia.sh 3.9 en `for english

  Check if all files were successfully downloaded. From DBpedia, we must have all files (labels, disambiguations, redirects, short_abstracts, article_categories and instance_types). If some file is not available, ask for help in DBpedia mail list.
  
  Finally
  
  * Run the indexer script
  
  `.lucene-quickstarter/scripts/run_index.sh VERSION LANGUAGE_CODE`

If you are here, seems that you have a new index ready for use. If not, tell us opening an issue.

## Supported Extraction Framework versions

* 2016-04

* 2015-10

* 2015-04

* 2015-04

* 3.9

* 3.8

* 3.7


## Supported Docker versions
This image is officially supported on Docker version 1.9.1.

Please see the [Docker installation documentation] (https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.


## About

This repo is an original work from  Pablo Mender ([@pablomendes](https://github.com/pablomendes)), Max Jakob ([@maxjakob](https://github.com/maxjakob)), Joachim Daiber ([@jodaiber](https://github.com/jodaiber)) and DBpedia Spotlight community. I'm just trying to turn index building with Lucene more easy.






