#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
unline=$(tput smul)

PROGNAME=`basename $0`

# Define a usage function
usage() {

cat << USAGE

${bold}NAME${normal}
        ${PROGNAME} - Gather coefficient files for IAL

${bold}USAGE${normal}
        ${PROGNAME} [options] <dir1> <dir2>

${bold}DESCRIPTION${normal}
        Script to compare coefficient (*.dat/*.H5) files for Harmonie/IAL

${bold}OPTIONS${normal}

        -h Help! Print usage information.

USAGE
}

if [ ${#} -eq 0 ]; then
  echo "No command line arguments provided"
  echo "Try '${PROGNAME} -h' for more information"
  exit 1
fi

# Parse options
while getopts "h" opt; do
    case $opt in
        h)
            usage
	    exit 0
            ;;
        *)
            usage
	    exit 1
            ;;
    esac
done

# Shift parsed options to get positional arguments
shift $((OPTIND - 1))

# Check if there are exactly two arguments
if [ $# -ne 2 ]; then
    echo "Error: You must provide exactly two arguments."
    usage
    exit 1
fi

# Loop over all files and report

REFDIR=$1
NEWDIR=$2

if  [[ ! -d "${REFDIR}" ]] ; then
  echo "Error: $REFDIR is not a valid directory"
  exit 1
fi

if  [[ ! -d "${NEWDIR}" ]] ; then
  echo "Error: $NEWDIR is not a valid directory"
  exit 1
fi

for FILE in $(ls $REFDIR/*.dat); do

  BASENAME=$(basename $FILE)
  if  [[ ! -f "${NEWDIR}/${BASENAME}" ]] ; then
    echo -e "\e[33mFiles missing: ${BASENAME}\e[0m"
  else
    if cmp -s "${NEWDIR}/${BASENAME}" "${REFDIR}/${BASENAME}"; then
      echo -e "\e[32mFiles are identical: ${BASENAME}\e[0m"
    else
#      echo -e "\e[31mFiles differ: ${BASENAME}\e[0m"
      echo -e "\e[31mdiff ${NEWDIR}/${BASENAME} ${REFDIR}/${BASENAME}\e[0m"
      diff ${NEWDIR}/${BASENAME} ${REFDIR}/${BASENAME} | head -30
#      exit 1
    fi
  fi

done

for FILE in $(ls $REFDIR/*.H5); do

  BASENAME=$(basename $FILE)
  echo -e " ${bold}${BASENAME}:${normal}"
  if  [[ ! -f "${NEWDIR}/${BASENAME}" ]] ; then
    echo -e "\e[33mFiles missing: ${BASENAME}\e[0m"
  else
    echo -e "\e[33mh5diff ${NEWDIR}/${BASENAME} ${REFDIR}/${BASENAME}\e[0m"
    h5diff "${NEWDIR}/${BASENAME}" "${REFDIR}/${BASENAME}"
  fi

done
