
# rttov_install
Keep track of local RTTOV installation

## RTTOV 13.2
```bash
mkdir rttov13.2 && tar xvfJ downloads/rttov132.tar.xz -C rttov13.2
```
then
```bash
cd rttov13.2/build
sed ....
./rttov_compile.sh
 < gfortran
 < ../../../metapp/rttov/13.2/gnu
 < -j 4
```


## RTTOV 12.3
```bash
mkdir rttov12.3 && tar xvfz downloads/rttov123.tar.gz -C rttov12.3
```
then
```bash
cd rttov12.3/build
sed ....
./rttov_compile.sh
 < gfortran
 < ../../../metapp/rttov/12.3/gnu
 < -j 4
```

## RTTOV 11.3
```bash
mkdir rttov11.3 && tar xvfz downloads/rttov113.tar.gz -C rttov11.3
```
then
```bash
cd rttov11.3/build
sed ....
./rttov_compile.sh
 < gfortran
 < ../../../metapp/rttov/12.3/gnu
 < -j 4
```

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

### harm_coef creation
Script that provide all the necessary coefficient files for Harmonie NWP

```bash
mkdir harm_coef

cd  ...
```



# Some links
| Note                           | Link                                                                                                        |
|--------------------------------|-------------------------------------------------------------------------------------------------------------|
| Update history                 |  https://nwp-saf.eumetsat.int/site/software/rttov/download/coefficients/update-history/                     |
| coefficient file history log   |  https://nwp-saf.eumetsat.int/site/software/rttov/download/coefficients/detailed-file-history/              |
| RTTOV 11 coefficient download  |  https://nwp-saf.eumetsat.int/site/software/rttov/download/coefficients/rttov-v11-coefficient-download/     |
| MW coefficient file download   |  wget https://nwp-saf.eumetsat.int/downloads/rtcoef_rttov11/rttov7pred54L/rtcoef_mw_rttov7pred54L.tar.bz2   |
