Quickstarter for DBpedia Spotlight Lucene
===================

[![Join the chat at https://gitter.im/dbpedia-spotlight/lucene-quickstarter](https://badges.gitter.im/dbpedia-spotlight/lucene-quickstarter.svg)](https://gitter.im/dbpedia-spotlight/lucene-quickstarter?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

You can use this repository for creating lucene backend index of DBpedia Spotlight in your language.

The repo is ready to use for the follow languages: catalan, german , greek , english, spanish, french , italian, dutch, polish, portuguese, hungarian and russian.

## I don't want to build the index. Where I can get it ready to use?


![Dropbox](http://www.iconsdb.com/icons/download/blue/dropbox-24.png) [HERE](https://www.dropbox.com/sh/q3vd67yr02w78mv/AAAc8K8_PkAAYO8a0scYsQ5Xa?dl=0) you can download it.


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

## How to cite: Lucene version

Pablo N. Mendes, Max Jakob, Andrés García-Silva and Christian Bizer. [DBpedia Spotlight: Shedding Light on the Web of Documents](http://wifo5-03.informatik.uni-mannheim.de/bizer/pub/Mendes-Jakob-GarciaSilva-Bizer-DBpediaSpotlight-ISEM2011.pdf). *Proceedings of the 7th International Conference on Semantic Systems (I-Semantics)*. Graz, Austria, 7–9 September 2011. 

```bibtex
@inproceedings{isem2011mendesetal,
  title = {DBpedia Spotlight: Shedding Light on the Web of Documents},
  author = {Pablo N. Mendes and Max Jakob and Andres Garcia-Silva and Christian Bizer},
  year = {2011},
  booktitle = {Proceedings of the 7th International Conference on Semantic Systems (I-Semantics)},
  abstract = {Interlinking text documents with Linked Open Data enables the Web of Data to be used as background knowledge within document-oriented applications such as search and faceted browsing. As a step towards interconnecting the Web of Documents with the Web of Data, we developed DBpedia Spotlight, a system for automatically annotating text documents with DBpedia URIs. DBpedia Spotlight allows users to configure the annotations to their specific needs through the DBpedia Ontology and quality measures such as prominence, topical pertinence, contextual ambiguity and disambiguation confidence. We compare our approach with the state of the art in disambiguation, and evaluate our results in light of three baselines and six publicly available annotation systems, demonstrating the competitiveness of our system. DBpedia Spotlight is shared as open source and deployed as a Web Service freely available for public use.}
}

## About

This repo is an original work from  Pablo Mender ([@pablomendes](https://github.com/pablomendes)), Max Jakob ([@maxjakob](https://github.com/maxjakob)), Joachim Daiber ([@jodaiber](https://github.com/jodaiber)) and DBpedia Spotlight community.







