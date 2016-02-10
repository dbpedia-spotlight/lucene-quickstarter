#!/bin/bash

readonly DBPEDIA_VERSION=$1
readonly LANG_i18n=$2
readonly DBPEDIA_DOWNLOADS="http://downloads.dbpedia.org"/$DBPEDIA_VERSION
readonly DBPEDIA_ROOT=/mnt/dbpedia
readonly DBPEDIA_DATA=$DBPEDIA_ROOT/dbpedia_data/$DBPEDIA_VERSION
readonly ALL_FILES=(labels disambiguations redirects short_abstracts short-abstracts instance_types instance-types article_categories article-categories)

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

#-----------------------------------------------------------------------------------------------------------------------------+
create_dir $DBPEDIA_DATA

for i in ${ALL_FILES[@]}
do
 download_file $DBPEDIA_DOWNLOADS/$LANG_i18n ${i}_$LANG_i18n.nt.bz2 $DBPEDIA_DATA/$LANG_i18n    
done

for i in ${ALL_FILES[@]}
do
  bunzip2 -fk $DBPEDIA_DATA/$LANG_i18n/${i}_$LANG_i18n.nt.bz2 >  $DBPEDIA_DATA/$LANG_i18n/${i}_$LANG_i18n.nt
done
