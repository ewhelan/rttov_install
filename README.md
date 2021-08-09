# rttov_install
Keep track of local RTTOV installation

## build/Makefile.local for CentOS 8
```
HDF5_PREFIX  = /usr
FFLAGS_HDF5  = -D_RTTOV_HDF $(FFLAG_MOD)$(HDF5_PREFIX)/include $(FFLAG_MOD)$(HDF5_PREFIX)/lib64/gfortran/modules
LDFLAGS_HDF5 = -L$(HDF5_PREFIX)/lib -lhdf5hl_fortran -lhdf5_hl -lhdf5_fortran -lhdf5 -lsz -lz -ldl -lm
```
then
```
./rttov_compile.sh
 < gfortran
 < ../../../metapp/rttov/12.3/gnu
 < -j 4
```
## Download data
```
cd rtcoef_rttov12
./rtcoef_coef_download.sh
````

Get atlas data from [https://nwp-saf.eumetsat.int/site/software/rttov/download/](https://nwp-saf.eumetsat.int/site/software/rttov/download/)

## Create rtcoef files for Metop-1/Metop-3 IASI
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
