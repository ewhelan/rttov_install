#!/bin/bash

TOPDIR=$(pwd)

bold=$(tput bold)
normal=$(tput sgr0)
unline=$(tput smul)

PROGNAME=`basename $0`

# Define a usage function
usage() {

cat << USAGE

${bold}NAME${normal}
        ${PROGNAME} - Compile RTTOV 11/12/13

${bold}USAGE${normal}
        ${PROGNAME} -c <config> [-C] [ -h ]

${bold}DESCRIPTION${normal}
        Script to start new LBC processing suite

${bold}OPTIONS${normal}
        -c ${unline}config${normal}
           configuration that defines Makefile.local deviations

        -C List configurations

        -h Help! Print usage information.

USAGE
}

CONFIG=DUMMY

while getopts c:Ch option
do
  case $option in
    c)
       CONFIG=$OPTARG
       ;;
    C)
       echo "List of configs:"
       ls -1 share/makefiles/ | sed 's/Makefile.local_1[1-3][0-9]_//g' | uniq
       echo
       exit 0
       ;;
    h)
       usage
       exit 0
       ;;
    *)
       echo
       echo "Try '${PROGNAME} -h' for more information"
       exit 1
       ;;
  esac
done

if [ ${CONFIG} == "DUMMY" ]; then
  echo "Please define config using -c"
  echo "Try '${PROGNAME} -h' for more information"
  exit 1
fi

if [ ! -f share/makefiles/Makefile.local_113_${CONFIG} ]; then
  echo "config=${CONFIG} not found. Try a valid config"
  exit 1
else
  echo "Found config=${CONFIG}"
fi

if [ ! -d downloads ] ; then
  echo "Error : downloads directory does not exist. Exiting."
  exit 1
else
  echo "Found downloads directory. Let's start ..."
fi
if [ ! -f downloads/rttov113.tar.gz ]; then
  echo "Error : downloads/rttov113.tar.gz not found. Please check your downloads"
  exit 1
fi
if [ ! -f downloads/rttov123.tar.gz ]; then
  echo "Error : downloads/rttov123.tar.gz not found. Please check your downloads"
  exit 1
fi
if [ ! -f downloads/rttov132.tar.xz ]; then
  echo "Error : downloads/rttov132.tar.xz not found. Please check your downloads"
  exit 1
fi

###############################################################################
## RTTOV 11.3
###############################################################################
echo "$0: Compiling RTTOV 11.3"
install_dir="install/rttov/11.3"
cd $TOPDIR
rm -rf ${install_dir}
rm -rf builds/rttov11.3
mkdir -p builds/rttov11.3
tar xvfz downloads/rttov113.tar.gz -C builds/rttov11.3
cp ${TOPDIR}/share/makefiles/Makefile.local_113_RL8 ${TOPDIR}/builds/rttov11.3/build/Makefile.local
cd ${TOPDIR}/builds/rttov11.3/build/

### Compile using RTTOV compile script
./rttov_compile.sh <<EOF
gfortran
../../${install_dir}
y
y
n
-j 2
y
EOF

### Test using RTTOV test script
cd ../rttov_test/
pwd
./rttov_test.pl ARCH=gfortran BIN=../../${install_dir}/bin > ${TOPDIR}/testing113.log 2>&1

###############################################################################
## RTTOV 12.3
###############################################################################
echo "$0: Compiling RTTOV 12.3"
install_dir="install/rttov/12.3"
cd $TOPDIR
rm -rf ${install_dir}
rm -rf builds/rttov12.3
mkdir -p builds/rttov12.3
tar xvfz downloads/rttov123.tar.gz -C builds/rttov12.3
cp ${TOPDIR}/share/makefiles/Makefile.local_123_RL8 ${TOPDIR}/builds/rttov12.3/build/Makefile.local
cd builds/rttov12.3/build/

./rttov_compile.sh <<EOF
gfortran
../../${install_dir}
n
-j 2
y
EOF
cd ../rttov_test
pwd
./test_rttov12.sh ARCH=gfortran BIN=../../${install_dir}/bin > ${TOPDIR}/testing123.log 2>&1

###############################################################################
## RTTOV 13.2
###############################################################################
echo "$0: Compiling RTTOV 13.2"
install_dir="install/rttov/13.2"
cd $TOPDIR
rm -rf ${install_dir}
rm -rf builds/rttov13.2
mkdir -p builds/rttov13.2
tar xvfJ downloads/rttov132.tar.xz -C builds/rttov13.2
cp ${TOPDIR}/share/makefiles/Makefile.local_132_RL8 ${TOPDIR}/builds/rttov13.2/build/Makefile.local
cd ${TOPDIR}/builds/rttov13.2/build/

### Compile using RTTOV compile script
./rttov_compile.sh <<EOF
gfortran
../../${install_dir}
n
-j 2
y
EOF

### Test using RTTOV test script
cd ../rttov_test/
pwd
./test_rttov13.sh ARCH=gfortran BIN=../../${install_dir}/bin > ${TOPDIR}/testing132.log 2>&1

###############################################################################
## END
###############################################################################
exit 0
