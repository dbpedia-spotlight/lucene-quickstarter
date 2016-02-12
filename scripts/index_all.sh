#!/bin/bash
readonly DBPEDIA_VERSION=$1
./index_config_file.sh ${DBPEDIA_VERSION} ar arabic org.apache.lucene.analysis.ar.ArabicAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} cz czech  org.apache.lucene.analysis.cz.CzechAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} de german  org.apache.lucene.analysis.de.GermanAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} el greek  org.apache.lucene.analysis.el.GreekAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} en english  org.apache.lucene.analysis.en.EnglishAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} es spanish  org.apache.lucene.analysis.es.SpanishAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} fr french  org.apache.lucene.analysis.fr.FrenchAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} it italian  org.apache.lucene.analysis.it.ItalianAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} ko korean  org.apache.lucene.analysis.cz.CzechAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} nl dutch  org.apache.lucene.analysis.nl.DutchAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} pl polish  org.apache.lucene.analysis.pl.PolishAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} pt portuguese  org.apache.lucene.analysis.pt.PortugueseAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} hu hungarian  org.apache.lucene.analysis.hu.HungarianAnalyzer
./index_config_file.sh ${DBPEDIA_VERSION} ru russian org.apache.lucene.analysis.ru.RussianAnalyzer


./index_server_file.sh ${DBPEDIA_VERSION} ar arabic org.apache.lucene.analysis.ar.ArabicAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} cz czech  org.apache.lucene.analysis.cz.CzechAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} de german  org.apache.lucene.analysis.de.GermanAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} el greek  org.apache.lucene.analysis.el.GreekAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} en english  org.apache.lucene.analysis.en.EnglishAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} es spanish  org.apache.lucene.analysis.es.SpanishAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} fr french  org.apache.lucene.analysis.fr.FrenchAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} it italian  org.apache.lucene.analysis.it.ItalianAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} ko korean  org.apache.lucene.analysis.cz.CzechAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} nl dutch  org.apache.lucene.analysis.nl.DutchAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} pl polish  org.apache.lucene.analysis.pl.PolishAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} pt portuguese  org.apache.lucene.analysis.pt.PortugueseAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} hu hungarian  org.apache.lucene.analysis.hu.HungarianAnalyzer
./index_server_file.sh ${DBPEDIA_VERSION} ru russian org.apache.lucene.analysis.ru.RussianAnalyzer
