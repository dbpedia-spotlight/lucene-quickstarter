
## Scripts
-----------

####  download_dbpedia.sh;

Script that download all DBpedia files that Spotlight uses for build a index by language and version

###### Usage: 

download_dbpedia.sh <version> <language code>

###### Eg:

`./download_dbpedia.sh 3.9 en`

#### download_wikipedia.sh;

Script that download the latest Wikipedia dump

###### Usage:

download_dbpedia.sh <language code>

###### Eg:

`./download_dbpedia.sh en`


#### index_config_file.sh;

Script that build properties file used by DBpedia Spotlight Lucene extractor

###### Usage:

index_config_file.sh 3.9 <language code> <language name>  <lucene analyzer class>

###### Eg:
`./index_config_file.sh 3.9 en english org.apache.lucene.analysis.en.EnglishAnalyzer`


#### index_server_file;

Script that build properties file used by DBpedia Spotlight Server

###### Usage:
index_server_file.sh 3.9 <language code> <language name>  <lucene analyzer class>

###### Eg:
`./index_server_file.sh 3.9 en english org.apache.lucene.analysis.en.EnglishAnalyzer`

#### package;

Script that build a pack index and configuration files.

###### Usage:
package 3.9 <language code>

###### Eg:
`./package.sh 3.9 en `


#### publish_sf;

Script that publish the package file on Source Forge

###### Usage:
publish_sf 3.9 <language code>

###### Eg:
`./publish_sf 3.9 en`


#### build_index

Script that performs index building operation

###### Usage:
build_index <version> <language code>

###### Eg:
`./build_index 3.9 en `






