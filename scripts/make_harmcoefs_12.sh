#!/bin/bash

ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_eos_2_amsua.dat rtcoef_eos_2_amsua.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_metop_1_amsua.dat rtcoef_metop_1_amsua.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_metop_2_amsua.dat rtcoef_metop_2_amsua.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_metop_3_amsua.dat rtcoef_metop_3_amsua.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_15_amsua.dat rtcoef_noaa_15_amsua.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_16_amsua.dat rtcoef_noaa_16_amsua.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_17_amsua.dat rtcoef_noaa_17_amsua.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_18_amsua.dat rtcoef_noaa_18_amsua.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_19_amsua.dat rtcoef_noaa_19_amsua.dat
# AMSU-B
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_15_amsub.dat rtcoef_noaa_15_amsub.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_16_amsub.dat rtcoef_noaa_16_amsub.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_17_amsub.dat rtcoef_noaa_17_amsub.dat
# MHS
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_metop_1_mhs.dat rtcoef_metop_1_mhs.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_metop_2_mhs.dat rtcoef_metop_2_mhs.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_metop_3_mhs.dat rtcoef_metop_3_mhs.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_18_mhs.dat rtcoef_noaa_18_mhs.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_19_mhs.dat rtcoef_noaa_19_mhs.dat
# ATMS / MWHS2 -- TBC
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_jpss_0_atms.dat rtcoef_jpss_0_atms.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_20_atms.dat rtcoef_noaa_20_atms.dat
# MWHS2
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_fy3_3_mwhs2.dat rtcoef_fy3_3_mwhs2.dat
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_fy3_4_mwhs2.dat rtcoef_fy3_4_mwhs2.dat
# IASI
ln -s ../rtcoef_rttov12/rttov9pred101L/rtcoef_metop_2_iasi.H5 rtcoef_metop_2_iasi.H5
# CrIS
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_jpss_0_cris.H5 rtcoef_jpss_0_cris.H5

/home/ewhelan/rttov_recipes/install/rttov/12.3/bin/rttov_conv_coef.exe --format-in HDF5 --format-out FORMATTED --coef-in rtcoef_metop_2_iasi.H5 --coef-out rtcoef_metop_2_iasi.dat
sed -e '1s/metop-2/metop-1/'     -e '7,8s/10   2/10   1/'     -e '8s/metop-2/metop-1/'     -e '17s/metop-2/metop-1/'     rtcoef_metop_2_iasi.dat > rtcoef_metop_1_iasi.dat
sed -e '1s/metop-2/metop-3/'     -e '7,8s/10   2/10   3/'     -e '8s/metop-2/metop-3/'     -e '17s/metop-2/metop-3/'     rtcoef_metop_2_iasi.dat > rtcoef_metop_3_iasi.dat
/home/ewhelan/rttov_recipes/install/rttov/12.3/bin/rttov_conv_coef.exe --format-out HDF5 --format-in FORMATTED --coef-out rtcoef_metop_1_iasi.H5 --coef-in rtcoef_metop_1_iasi.dat
/home/ewhelan/rttov_recipes/install/rttov/12.3/bin/rttov_conv_coef.exe --format-out HDF5 --format-in FORMATTED --coef-out rtcoef_metop_3_iasi.H5 --coef-in rtcoef_metop_3_iasi.dat
rm rtcoef_metop_1_iasi.dat rtcoef_metop_2_iasi.dat rtcoef_metop_3_iasi.dat
/home/ewhelan/rttov_recipes/install/rttov/12.3/bin/rttov_conv_coef.exe --format-in HDF5 --format-out FORMATTED --coef-in rtcoef_jpss_0_cris.H5 --coef-out rtcoef_jpss_0_cris.dat
sed -e '1s/jpss-0/noaa-20/'     -e '7s/17   0/ 1  20/'     -e '8s/jpss-0 /noaa-20/'     -e '17s/jpss-0/noaa-20/'     rtcoef_jpss_0_cris.dat > rtcoef_noaa_20_cris.dat
sed -e '1s/jpss-0/noaa-21/'     -e '7s/17   0/ 1  21/'     -e '8s/jpss-0 /noaa-21/'     -e '17s/jpss-0/noaa-21/'     rtcoef_jpss_0_cris.dat > rtcoef_noaa_21_cris.dat
/home/ewhelan/rttov_recipes/install/rttov/12.3/bin/rttov_conv_coef.exe --format-out HDF5 --format-in FORMATTED --coef-out rtcoef_noaa_20_cris.H5 --coef-in rtcoef_noaa_20_cris.dat
/home/ewhelan/rttov_recipes/install/rttov/12.3/bin/rttov_conv_coef.exe --format-out HDF5 --format-in FORMATTED --coef-out rtcoef_noaa_21_cris.H5 --coef-in rtcoef_noaa_21_cris.dat
rm rtcoef_jpss_0_cris.dat rtcoef_noaa_20_cris.dat rtcoef_noaa_21_cris.dat

