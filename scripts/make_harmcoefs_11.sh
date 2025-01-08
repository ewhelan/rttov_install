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
        ${PROGNAME} -i <rttov-coef-dir> [ -h ]

${bold}DESCRIPTION${normal}
        Script to gather coefficient files for Harmonie/IAL

${bold}OPTIONS${normal}

        -i ${unline}rttov-coef-dir${normal}
           rttov-coef-dir

        -h Help! Print usage information.

USAGE
}

RTTOV_COEF_DIR=DUMMY
#
# Where am I?
#
this_script_loc="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
appdir=$(dirname ${this_script_loc})
#bindir=${appdir}/bin
#libdir=${appdir}/lib
#exedir=${appdir}/libexec

if [ ${#} -eq 0 ]; then
  echo "No command line arguments provided"
  echo "Try '${PROGNAME} -h' for more information"
  exit 1
fi

while getopts i:h option
do
  case $option in
    i)
       RTTOV_COEF_DIR=$OPTARG
       ;;
    h)
       usage
       exit 0
       ;;
    *)
       echo
       echo "Try '${PROGNAME} -h' for more information"
       ;;
  esac
done

if [ ${RTTOV_COEF_DIR} == "DUMMY" ]; then
  echo "Please define  rttov-coef-dir using -i"
  echo "Try '${PROGNAME} -h' for more information"
  exit 1
fi

if [ ! -d ${RTTOV_COEF_DIR} ]; then
  echo "rttov-coef-dir, ${RTTOV_COEF_DIR}, not found"
  echo "Try '${PROGNAME} -h' for more information"
  exit 1
fi

ABS_PATH=$(readlink -f "${RTTOV_COEF_DIR}")

set -e

rm -rf harm_coef
mkdir harm_coef
cd harm_coef

# SEVIRI: METEOSAT-10/METEOSAT-11
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_msg_2_seviri.dat rtcoef_meteosat_9_seviri.dat
cp -p ${ABS_PATH}/rttov9pred54L/rtcoef_msg_3_seviri.dat rtcoef_meteosat_10_seviri.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_msg_4_seviri.dat rtcoef_meteosat_11_seviri.dat

# AMSU-A : EOS-2/Metop-1/Metop-2/Metop-3/NOAA-15/NOAA-16/NOAA-17/NOAA-18/NOAA-19
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_eos_2_amsua.dat rtcoef_eos_2_amsua.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_metop_1_amsua.dat rtcoef_metop_1_amsua.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_metop_2_amsua.dat rtcoef_metop_2_amsua.dat
ln -s rtcoef_metop_2_amsua.dat rtcoef_metop_3_amsua.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_15_amsua.dat rtcoef_noaa_15_amsua.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_16_amsua.dat rtcoef_noaa_16_amsua.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_17_amsua.dat rtcoef_noaa_17_amsua.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_18_amsua.dat rtcoef_noaa_18_amsua.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_19_amsua.dat rtcoef_noaa_19_amsua.dat

# AMSU-B : NOAA-15/NOAA-16/NOAA-17
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_15_amsub.dat rtcoef_noaa_15_amsub.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_16_amsub.dat rtcoef_noaa_16_amsub.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_17_amsub.dat rtcoef_noaa_17_amsub.dat

# MHS : Metop-1/Metop-2/Metop-3/NOAA-18/NOAA-19
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_metop_1_mhs.dat rtcoef_metop_1_mhs.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_metop_2_mhs.dat rtcoef_metop_2_mhs.dat
ln -s rtcoef_metop_2_mhs.dat rtcoef_metop_3_mhs.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_18_mhs.dat rtcoef_noaa_18_mhs.dat
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_noaa_19_mhs.dat rtcoef_noaa_19_mhs.dat

# ATMS : JPSS-0/NOAA-20
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_jpss_0_atms.dat rtcoef_jpss_0_atms.dat
#ln -s rtcoef_jpss_0_atms.dat rtcoef_noaa_20_atms.dat
#ln -s rtcoef_jpss_0_atms.dat rtcoef_noaa_21_atms.dat
sed -e '1s/jpss-0/noaa-20/'     -e '7s/17  0 19/1   20  19/'     -e '8s/jpss-0/noaa-20/'     -e '17s/jpss-0/noaa-20/'     rtcoef_jpss_0_atms.dat > rtcoef_noaa_20_atms.dat
sed -e '1s/jpss-0/noaa-21/'     -e '7s/17  0 19/1   21  19/'     -e '8s/jpss-0/noaa-21/'     -e '17s/jpss-0/noaa-21/'     rtcoef_jpss_0_atms.dat > rtcoef_noaa_21_atms.dat

# MWHS2 : FY-3C
cp -p ${ABS_PATH}/rttov7pred54L/rtcoef_fy3_3_mwhs2.dat rtcoef_fy3_3_mwhs2.dat
sed -e '1s/fy3-3/fy3-4/'     -e '7s/3 73/4 73/'     -e '8s/fy3-3/fy3-4/'     -e '17s/fy3-3/fy3-4/'     rtcoef_fy3_3_mwhs2.dat > rtcoef_fy3_4_mwhs2.dat
cp ${ABS_PATH}/../../rttov13.2/rtcoef_rttov13/rttov7pred54L/rtcoef_fy3_5_mwhs2e_srf.dat .
/home/ewhelan/rttov_install/install/rttov/13.2/bin/rttov11_conv_coef_12to11.exe --coef-in rtcoef_fy3_5_mwhs2e_srf.dat --coef-out rtcoef_fy3_5_mwhs2.dat
rm -f rtcoef_fy3_5_mwhs2e_srf.dat

# IASI : Metop-2/Metop-1/Metop-3
cp -p ${ABS_PATH}/../../rttov12.3/rtcoef_rttov12/rttov8pred101L/rtcoef_metop_2_iasi.H5 .
/home/ewhelan/rttov_install/install/rttov/12.3/bin/rttov_conv_coef.exe --format-in HDF5 --format-out FORMATTED --coef-in rtcoef_metop_2_iasi.H5 --coef-out rtcoef12_metop_2_iasi.dat
/home/ewhelan/rttov_install/install/rttov/12.3/bin/rttov11_conv_coef_12to11.exe --coef-in rtcoef12_metop_2_iasi.dat --coef-out rtcoef_metop_2_iasi.dat
rm -f rtcoef12_metop_2_iasi.dat rtcoef_metop_2_iasi.H5
ln -s rtcoef_metop_2_iasi.dat rtcoef_metop_1_iasi.dat
ln -s rtcoef_metop_2_iasi.dat rtcoef_metop_3_iasi.dat
#sed -e '1s/metop-2/metop-1/'     -e '7,8s/10   2/10   1/'     -e '8s/metop-2/metop-1/'     -e '17s/metop-2/metop-1/'     rtcoef_metop_2_iasi.dat > rtcoef_metop_1_iasi.dat
#sed -e '1s/metop-2/metop-3/'     -e '7,8s/10   2/10   3/'     -e '8s/metop-2/metop-3/'     -e '17s/metop-2/metop-3/'     rtcoef_metop_2_iasi.dat > rtcoef_metop_3_iasi.dat

# ATMS : NOAA-21
#sed -e '1s/noaa-20/noaa-21/'     -e '7,8s/20  19/21  19/'     -e '8s/noaa-20/noaa-21/'     -e '17s/noaa-20/noaa-21/'     rtcoef_noaa_20_atms.dat > rtcoef_noaa_21_atms.dat

# CrIS : JPSS-0/NOAA-20/NOAA-21
cp ${ABS_PATH}/../../rttov13.2/rtcoef_rttov13/rttov7pred54L/rtcoef_jpss_0_cris-fsr.H5 .
/home/ewhelan/rttov_install/install/rttov/13.2/bin/rttov_conv_coef.exe --format-in HDF5 --format-out FORMATTED --coef-in rtcoef_jpss_0_cris-fsr.H5
/home/ewhelan/rttov_install/install/rttov/13.2/bin/rttov11_conv_coef_12to11.exe --coef-in rtcoef_jpss_0_cris-fsr.H5.bin --coef-out rtcoef_jpss_0_cris.dat
ln -s rtcoef_jpss_0_cris.dat rtcoef_noaa_20_cris.dat
ln -s rtcoef_jpss_0_cris.dat rtcoef_noaa_21_cris.dat
#sed -e '1s/jpss-0/noaa-20/'     -e '7s/17   0/ 1  20/'     -e '8s/jpss-0 /noaa-20/'     -e '17s/jpss-0/noaa-20/'     rtcoef_jpss_0_cris.dat > rtcoef_noaa_20_cris.dat
#sed -e '1s/jpss-0/noaa-21/'     -e '7s/17   0/ 1  21/'     -e '8s/jpss-0 /noaa-21/'     -e '17s/jpss-0/noaa-21/'     rtcoef_jpss_0_cris.dat > rtcoef_noaa_21_cris.dat
#/home/ewhelan/rttov_install/install/rttov/11.3/bin/rttov_conv_coef.exe --format-out HDF5 --format-in FORMATTED --coef-out rtcoef_noaa_20_cris.H5 --coef-in rtcoef_noaa_20_cris.dat
#/home/ewhelan/rttov_install/install/rttov/11.3/bin/rttov_conv_coef.exe --format-out HDF5 --format-in FORMATTED --coef-out rtcoef_noaa_21_cris.H5 --coef-in rtcoef_noaa_21_cris.dat
rm -f rtcoef_jpss_0_cris-fsr.H5 rtcoef_jpss_0_cris-fsr.H5.bin

# AWS : AWS-1
cp ${ABS_PATH}/../../rttov12.3/rtcoef_rttov12/rttov7pred54L/rtcoef_aws_1_aws.dat rtcoef12_aws_1_aws.dat
/home/ewhelan/rttov_install/install/rttov/12.3/bin/rttov11_conv_coef_12to11.exe --coef-in rtcoef12_aws_1_aws.dat --coef-out rtcoef_aws_1_aws.dat
rm -f rtcoef12_aws_1_aws.dat
