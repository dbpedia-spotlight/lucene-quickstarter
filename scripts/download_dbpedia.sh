#!/bin/bash

readonly DBPEDIA_VERSION=$1
readonly LANG_i18n=$2
readonly DBPEDIA_ROOT=/mnt/dbpedia
readonly DBPEDIA_DATA=$DBPEDIA_ROOT/dbpedia_data/$DBPEDIA_VERSION

# DBpedia versions with i18n support (before 2015) 
readonly SUPPORTED_VERSIONS_BEFORE_2015="3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.5.1, 3.6, 3.7, 3.8, 3.9, 2014"
readonly DBPEDIA_DOWNLOADS="http://downloads.dbpedia.org"/$DBPEDIA_VERSION
readonly ALL_FILES=(labels disambiguations redirects short_abstracts instance_types article_categories)

# DBpedia with i18n (after 2015) 
readonly SUPPORTED_VERSIONS_AFTER_2015="2015-04, 2015-10, 2016-04"
readonly DBPEDIA_DOWNLOADS_2015="http://downloads.dbpedia.org"/$DBPEDIA_VERSION/core-i18n
readonly ALL_FILES_2015=(labels disambiguations redirects short-abstracts instance-types article-categories)

#+------------------------------------------------------------------------------------------------------------------------------+
#| Functions                                                                                                                    |
#+------------------------------------------------------------------------------------------------------------------------------+


# Error_exit function by William Shotts. http://stackoverflow.com/questions/64786/error-handling-in-bash
function error_exit
{
    echo -e "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
}

# The function used to create all the directories needed
function create_dir()
{
    if [ -e $1 ]; then
        echo -e $1" already exists. Skipping creating this directory!"
    else
        mkdir -p $1
    fi
}

# A helper function to download files from a given path. The first parameter is the path from where to download the file
# without the file name, the second states the file name, and the third is where to save that file
function download_file()
{
    # Only downloads if there is no current file or there is a newer version
    echo "$#"
    case "$#" in
        "3")
            wget -q --spider $1/$2
            if [ $? -eq 0 ] ; then
                wget -N $1/$2 --directory-prefix=$3
            else
                # The file can't be found. We can extract a substring with the file name and show it to the user
                error_exit "ERROR: The file '"$2"' cannot be found for download.\n"
            fi
            ;;
        "4")
            wget -q --spider $1 $2/$3
            if [ $? -eq 0 ] ; then
                wget -N $1 $2/$3 --directory-prefix=$4
            else
                # The file can't be found. We can extract a substring with the file name and show it to the user
                error_exit "ERROR: The file '"$3"' cannot be found for download.\n"
            fi
            ;;
        *)
            error_exit "ERROR: Incorrect number of parameters!";
    esac
    echo -e "done!\n"
}



function unpackAll()
{
	for i in ${ALL_FILES[@]}
	do
	  bunzip2 -fk $DBPEDIA_DATA/$LANG_i18n/${i}_$LANG_i18n.nt.bz2 >  $DBPEDIA_DATA/$LANG_i18n/${i}_$LANG_i18n.nt
	done	
	
}

#-----------------------------------------------------------------------------------------------------------------------------+
create_dir $DBPEDIA_DATA

if [[ $SUPPORTED_VERSIONS_BEFORE_2015 == *"$DBPEDIA_VERSION"* ]]; then
	echo "DBpedia version before 2015" ...
	
	for i in ${ALL_FILES[@]}
	do
	 download_file $DBPEDIA_DOWNLOADS/$LANG_i18n ${i}_$LANG_i18n.nt.bz2 $DBPEDIA_DATA/$LANG_i18n    
	done
	
	unpackAll
fi


if [[ $SUPPORTED_VERSIONS_AFTER_2015 == *"$DBPEDIA_VERSION"* ]]; then
    echo "DBpedia version after 2015" ...
	
	for i in ${ALL_FILES_2015[@]}
	do
	 download_file $DBPEDIA_DOWNLOADS_2015/$LANG_i18n ${i}_$LANG_i18n.nt.bz2 $DBPEDIA_DATA/$LANG_i18n    
	 mv $DBPEDIA_DATA/$LANG_i18n/${i}_$LANG_i18n.nt.bz2  $DBPEDIA_DATA/$LANG_i18n/${i/-/_}_$LANG_i18n.nt.bz2  
	done
	
    unpackAll
fi


