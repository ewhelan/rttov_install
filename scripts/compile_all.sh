#!/bin/bash

set -xe

TOPDIR=$(pwd)

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

