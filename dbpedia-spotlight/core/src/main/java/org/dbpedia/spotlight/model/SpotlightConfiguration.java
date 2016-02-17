/*
 * Copyright 2012 DBpedia Spotlight Development Team
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 *  Check our project website for information on how to acknowledge the authors and how to contribute to the project: http://spotlight.dbpedia.org
 */

package org.dbpedia.spotlight.model;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.search.BooleanQuery;
import org.dbpedia.spotlight.exceptions.ConfigurationException;

import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.*;

/**
 * Holds all configuration parameters needed to run the DBpedia Spotlight Server
 * Reads values from a config file
 * <p>
 * (TODO) and should validate if the inputs are acceptable, failing gracefully and early.
 * (TODO) break down configuration into smaller pieces
 *
 * @author pablomendes
 */
public class SpotlightConfiguration {

    public static String DEFAULT_NAMESPACE = "http://dbpedia.org/resource/";
    public static String DEFAULT_ONTOLOGY_PREFIX = "http://dbpedia.org/ontology/";
    public static String DEFAULT_LANGUAGE_I18N_CODE = "en";
    private static Log LOG = LogFactory.getLog(SpotlightConfiguration.class);
    protected String contextIndexDirectory = "";
    protected String candidateMapDirectory = "";
    protected boolean candidateMapInMemory = true;
    protected List<Double> similarityThresholds;
    protected String similarityThresholdsFile = "similarity-thresholds.txt";
    protected String taggerFile = "";
    protected String stopWordsFile = "";
    protected Set<String> stopWords = null;
    protected String serverURI = "http://localhost:2222/rest/";
    protected String sparqlMainGraph = "http://dbpedia.org/sparql";
    protected String sparqlEndpoint = "http://dbpedia.org";
    protected long maxCacheSize = Long.MAX_VALUE;
    protected DisambiguatorConfiguration disambiguatorConfiguration;
    DBpediaResourceFactory dbpediaResourceFactory = null;
    Analyzer analyzer = null;
    private String dbpediaResource = "http://dbpedia.org/resource/";
    private String dbpediaOntology = "http://dbpedia.org/ontology/";
    private String language;
    private String i18nLanguageCode = "en";
    public SpotlightConfiguration(String fileName) throws ConfigurationException {

        //read config properties
        Properties config = new Properties();
        try {
            config.load(new FileInputStream(new File(fileName)));
        } catch (IOException e) {
            throw new ConfigurationException("Cannot find configuration file " + fileName, e);
        }

        DEFAULT_NAMESPACE = config.getProperty("org.dbpedia.spotlight.default_namespace", DEFAULT_NAMESPACE);
        dbpediaResource = config.getProperty("org.dbpedia.spotlight.default_namespace", dbpediaResource);

        DEFAULT_ONTOLOGY_PREFIX = config.getProperty("org.dbpedia.spotlight.default_ontology", DEFAULT_ONTOLOGY_PREFIX);
        dbpediaOntology = config.getProperty("org.dbpedia.spotlight.default_ontology", dbpediaOntology);

        DEFAULT_LANGUAGE_I18N_CODE = config.getProperty("org.dbpedia.spotlight.language_i18n_code", DEFAULT_LANGUAGE_I18N_CODE);
        i18nLanguageCode = config.getProperty("org.dbpedia.spotlight.language_i18n_code", "en");


        disambiguatorConfiguration = new DisambiguatorConfiguration(fileName);

        //set spotterFile, indexDir...
        contextIndexDirectory = disambiguatorConfiguration.contextIndexDirectory;


        //optionally use separate candidate map
        candidateMapDirectory = config.getProperty("org.dbpedia.spotlight.candidateMap.dir", "").trim();
        if (candidateMapDirectory == null || !new File(candidateMapDirectory).isDirectory()) {
            LOG.warn("Could not use the candidateMap.dir provided. Will use index.dir both for context and candidate searching.");
            candidateMapDirectory = contextIndexDirectory;
        }
        candidateMapInMemory = config.getProperty("org.dbpedia.spotlight.candidateMap.loadToMemory", "false").trim().equals("true");

        try {
            BufferedReader r = new BufferedReader(new FileReader(new File(contextIndexDirectory, similarityThresholdsFile)));
            String line;
            similarityThresholds = new ArrayList<Double>();
            while ((line = r.readLine()) != null) {
                similarityThresholds.add(Double.parseDouble(line));
            }
        } catch (FileNotFoundException e) {
            throw new ConfigurationException("Similarity threshold file '" + similarityThresholdsFile + "' not found in index directory " + contextIndexDirectory, e);
        } catch (NumberFormatException e) {
            throw new ConfigurationException("Error parsing similarity value in '" + contextIndexDirectory + "/" + similarityThresholdsFile, e);
        } catch (IOException e) {
            throw new ConfigurationException("Error reading '" + contextIndexDirectory + "/" + similarityThresholdsFile, e);
        }

        taggerFile = config.getProperty("org.dbpedia.spotlight.tagging.hmm", "").trim();
        if (taggerFile == null || !new File(taggerFile).isFile()) {
            throw new ConfigurationException("Cannot find POS tagger model file " + taggerFile);
        }

        language = config.getProperty("org.dbpedia.spotlight.language", "English");


        stopWordsFile = config.getProperty("org.dbpedia.spotlight.data.stopWords." + language.toLowerCase(), "").trim();
        if ((stopWordsFile == null) || !new File(stopWordsFile.trim()).isFile()) {
            LOG.warn("Cannot find stopwords file '" + stopWordsFile + "'. Using default Lucene Analyzer StopWords.");
        } else {
            try {
                BufferedReader bufferedReader = new BufferedReader(new FileReader(stopWordsFile.trim()));
                String line = null;
                stopWords = new HashSet<String>();
                while ((line = bufferedReader.readLine()) != null) {
                    stopWords.add(line.trim());
                }
                bufferedReader.close();
            } catch (Exception e1) {
                LOG.error("Could not read stopwords file. Using default Lucene Analyzer StopWords");
            }
        }

        analyzer = Factory.analyzer().from(
                config.getProperty("org.dbpedia.spotlight.lucene.analyzer", "org.apache.lucene.analysis.standard.StandardAnalyzer"),
                config.getProperty("org.dbpedia.spotlight.lucene.version", "LUCENE_36"), stopWords);

        serverURI = config.getProperty("org.dbpedia.spotlight.web.rest.uri", "").trim();
        if (serverURI != null && !serverURI.endsWith("/")) {
            serverURI = serverURI.concat("/");
        }
        try {
            new URI(serverURI);
        } catch (URISyntaxException e) {
            throw new ConfigurationException("Server URI not valid.", e);
        }

        // Configure lucene to accept a larger number of or queries
        BooleanQuery.setMaxClauseCount(3072);

        sparqlEndpoint = config.getProperty("org.dbpedia.spotlight.sparql.endpoint", "http://dbpedia.org/sparql").trim();
        sparqlMainGraph = config.getProperty("org.dbpedia.spotlight.sparql.graph", "http://dbpedia.org").trim();


        String maxCacheSizeString = config.getProperty("jcs.default.cacheattributes.MaxObjects", "").trim();
        try {
            maxCacheSize = new Long(maxCacheSizeString.trim());
        } catch (Exception ignored) {
            LOG.error(ignored);
        }

    }

    public String getLanguage() {
        return language;
    }

    public String getDbpediaResource() {
        return dbpediaResource;
    }

    public String getDbpediaOntology() {
        return dbpediaOntology;
    }

    public String getI18nLanguageCode() {
        return i18nLanguageCode;
    }

    public boolean isContextIndexInMemory() {
        return disambiguatorConfiguration.isContextIndexInMemory();
    }

    public boolean isCandidateMapInMemory() {
        return candidateMapInMemory;
    }

    public String getServerURI() {
        return serverURI;
    }

    public String getContextIndexDirectory() {
        return disambiguatorConfiguration.getContextIndexDirectory();
    }

    public String getCandidateIndexDirectory() {
        return candidateMapDirectory;
    }

    public List<Double> getSimilarityThresholds() {
        return similarityThresholds;
    }

    public String getSparqlMainGraph() {
        return sparqlMainGraph;
    }

    public String getSparqlEndpoint() {
        return sparqlEndpoint;
    }

    public String getTaggerFile() {
        return taggerFile;
    }

    public Set<String> getStopWords() {
        return stopWords;
    }

    public long getMaxCacheSize() {
        return maxCacheSize;
    }

    public DBpediaResourceFactory getDBpediaResourceFactory() {
        return dbpediaResourceFactory;
    }

    public void createDBpediaResourceFactory(String driver, String connector, String user, String password) {
        dbpediaResourceFactory = new DBpediaResourceFactorySQL(driver, connector, user, password);
    }

    public DisambiguatorConfiguration getDisambiguatorConfiguration() {
        return disambiguatorConfiguration;
    }

    public Analyzer getAnalyzer() {
        return analyzer;
    }

    public enum DisambiguationPolicy {Document, Occurrences, CuttingEdge, Default}


}
