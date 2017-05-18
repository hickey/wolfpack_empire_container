#!/bin/bash
# ----------------------------------------------------------------------------
# Docker entrypoint script for wolfpack_empire
# ----------------------------------------------------------------------------
set -e
declare -rx SCRIPT=${0##*/}

##
## Set configuration defaults
##
#    Magic values:
#         *require* or *required*: Environment must supply a value
#         *integer*:               Variable must validate as an integer
#         *string*:                Variable must validate as a non-integer
#         *ip*:                    Variable must contain an IP

# Consumer
default_ZK_CONNECT=''

  
# Logging
default_LOG_LEVEL=WARN


# Command line parameters

##
##  Files to do environmental var searches on
##
template_files=()
delimiter='%'

########################################################################
###
###  Ideally there should be no need to change any thing beyond here
###
########################################################################

##
## generate_config() function will search for environmental variable names
## (uppercase word groups surrounded by delimiters) and replace the patterns
## with the environmental var value or above defined default values if not set
## to a value. Valid characters for environmental vars are a-z, A-Z, 0-9 and _.
##
## generate_config() will take 2 values: path to the config file to process
## and the delimiter (default '%') used to identify the environmental vars. 
##
function generate_config {
  conf_file=$1
  delimiter=${2:-%}
  contents=()
  # pattern match the values that should be substituted
  kw_regex="(.*)${delimiter}([A-Za-z0-9_]+)${delimiter}(.*)"
  
  while read line ; do 
    if [[ $line =~ $kw_regex ]]; then 
      # Line has a keyword on it that needs to be replaced
      pre="${BASH_REMATCH[1]}"
      kw="${BASH_REMATCH[2]}"
      post="${BASH_REMATCH[3]}"
      
      # Find a default value if there is one available
      eval def_val=\$"default_$kw"

      # Find value in the environment
      eval env_val=\$$kw
      
      # Check for magic default values
      case "$def_val" in
        \*require\*|\*required\*)
          if [[ -z "$env_val" ]]; then
            echo "*ERROR* ${kw} is required to be an exported environmental variable"
            exit 1
          fi
          ;;
        \*integer\*)
          if [[ ! "$env_val" =~ "^-?[0-9]+$" ]]; then
            echo "*ERROR* ${kw} needs to be an integer, not '${env_val}'"
            exit 1
          fi
          ;;
        \*string\*)
          if [[ "$env_val" =~ "^-?[0-9]+$" ]]; then
            echo "*ERROR* ${kw} needs to be a non-integer, not '${env_val}'"
            exit 1
          fi
          ;;
        \*ip\*)
          if [[ ! "$env_val" =~ "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$" ]]; then
            echo "*ERROR* ${kw} is required to be an IP address"
            exit 1
          fi
          ;;
      esac
      
      # do the actual substition
      if [[ -n "$env_val" ]]; then
        contents+=("${pre}${env_val}${post}")
      else
        contents+=("${pre}${def_val}${post}")
      fi
    else
      # Line with no keyword
      contents+=("$line")
    fi
  done < "$conf_file"
  
  # Write the config file back out
  > "$conf_file"
  for line in "${contents[@]}"; do
    echo "${line}" >> $conf_file
  done
}



# Default application if nothing is specified
if [ -z "${1:0:1}" ]; then
	set -- "empserver"
fi

case $1 in
  empserver)
    set -- /empire/sbin/emp_server
    ;;
  help|info|readme)
    set -- cat README.md
    ;;
  version|ver)
    set -- /empire/sbin/emp_server -v
esac

# Process any config files. This should really only happen when the 
# container is first created. Aftwards all the keywords should have
# already been replaced and the files are re-written, but should not
# change. 
for conf in "${files_to_process[@]}"; do
  echo "+ Processing $conf"
  generate_config "$conf" "$delimiter"
done


#echo "Executing: $@"
exec "$@"
