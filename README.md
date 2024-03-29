
# rttov_install
Keep track of local RTTOV installation

## build/Makefile.local for CentOS 8
```
HDF5_PREFIX  = /usr
FFLAGS_HDF5  = -D_RTTOV_HDF $(FFLAG_MOD)$(HDF5_PREFIX)/include $(FFLAG_MOD)$(HDF5_PREFIX)/lib64/gfortran/modules
LDFLAGS_HDF5 = -L$(HDF5_PREFIX)/lib -lhdf5hl_fortran -lhdf5_hl -lhdf5_fortran -lhdf5 -lsz -lz -ldl -lm
```
then
```bash
./rttov_compile.sh
 < gfortran
 < ../../../metapp/rttov/12.3/gnu
 < -j 4
```
then
```
cd ../rttov_test
./test_rttov12.sh ARCH=gfortran BIN=../../metapp/rttov/12.3/gnu/bin
```

## Download data
```bash
cd rtcoef_rttov12
./rtcoef_coef_download.sh
````

Get atlas data from [https://nwp-saf.eumetsat.int/site/software/rttov/download/](https://nwp-saf.eumetsat.int/site/software/rttov/download/)



## For Harmonie
### Suggested directory structure
```
harmonie_sat_const
├── assharm_coef
├── cnrm_mwemis
├── rtcoef_rttov12
│   ├── cldaer_ir
│   ├── cldaer_visir
│   ├── htfrtc
│   ├── mfasis_lut
│   ├── mietable
│   ├── pc
│   ├── rttov7pred101L
│   ├── rttov7pred54L
│   ├── rttov8pred101L
│   ├── rttov8pred51L
│   ├── rttov8pred54L
│   ├── rttov9pred101L
│   └── rttov9pred54L
└── uw_ir_emis_atlas_hdf5
```

### In assharm_coef make some soft links
```bash
mkdir -p assharm_coef
cd assharm_coef
# AMSUA-A
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
ln -s ../rtcoef_rttov12/rttov7pred54L/rtcoef_noaa_20_cris.H5 rtcoef_noaa_20_cris.H5
```

### Create rtcoef files for Metop-1/Metop-3 IASI
```
rttov_conv_coef.exe --format-in HDF5 --format-out FORMATTED --coef-in rtcoef_metop_2_iasi.H5 --coef-out rtcoef_metop_2_iasi.dat
cp rtcoef_metop_2_iasi.dat rtcoef_metop_1_iasi.dat
cp rtcoef_metop_2_iasi.dat rtcoef_metop_3_iasi.dat
vi rtcoef_metop_1_iasi.dat
rttov_conv_coef.exe --format-out HDF5 --format-in FORMATTED --coef-out rtcoef_metop_1_iasi.H5 --coef-in rtcoef_metop_1_iasi.dat
vi rtcoef_metop_3_iasi.dat
rttov_conv_coef.exe --format-out HDF5 --format-in FORMATTED --coef-out rtcoef_metop_3_iasi.H5 --coef-in rtcoef_metop_3_iasi.dat
rm rtcoef_metop_2_iasi.dat rtcoef_metop_1_iasi.dat rtcoef_metop_3_iasi.dat
```

### Create rtcoef files for NOAA-20 CrIS
```
 rttov_conv_coef.exe --format-in HDF5 --format-out FORMATTED --coef-in rtcoef_jpss_0_cris.H5 --coef-out rtcoef_jpss_0_cris.dat
 mv rtcoef_jpss_0_cris.dat rtcoef_noaa_20_cris.dat
 vi rtcoef_noaa_20_cris.dat
 rttov_conv_coef.exe --format-out HDF5 --format-in FORMATTED --coef-out rtcoef_noaa_20_cris.H5 --coef-in rtcoef_noaa_20_cris.dat
```
