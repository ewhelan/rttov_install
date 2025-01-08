
# rttov_install
Keep track of local RTTOV installation

## Get this code
```bash
git clone https://github.com/ewhelan/rttov_install.git
```

## Download RTTOV software
```bash
cd rttov_install
mkdir downloads
cd downloads
# Copy code here
```

```bash
$ cd downloads
$ md5sum rttov*
cf58cb4243a196d5958c6782066f956a  rttov113.tar.gz
da5e4f7c75dcb028fd997fed96ad4710  rttov123.tar.gz
98263a31aa389aefb2adf953de584e0b  rttov132.tar.xz
```

## Compile RTTOV software
```bash
cd rttov_install
scripts/compile_all.sh -C
scripts/compile_all.sh -c RL8
```

## Download data
```bash
cd rttov_install
cd builds/rttov11.3/rtcoef_rttov11
./rttov_coef_download.sh
```

```bash
cd rttov_install
cd builds/rttov12.3/rtcoef_rttov12
./rttov_coef_download.sh
```

```bash
cd rttov_install
cd builds/rttov13.2/rtcoef_rttov13
./rttov_coef_download.sh
```

## Gather coefficient files
### RTTOV 11 (Cycle 43)
```bash
cd rttov_install
scripts/make_harmcoefs_11.sh -i builds/rttov11.3/rtcoef_rttov11
```

### RTTOV 12 (Cycle 46)
```bash
cd rttov_install
scripts/make_harmcoefs_12.sh -i builds/rttov12.3/rtcoef_rttov12
```

### RTTOV 13 (Cycle 46)
```bash
cd rttov_install
scripts/make_harmcoefs_13.sh -i builds/rttov13.2/rtcoef_rttov13
```

## Atlas data
Get atlas data from [https://nwp-saf.eumetsat.int/site/software/rttov/download/](https://nwp-saf.eumetsat.int/site/software/rttov/download/)

## For Harmonie
### Suggested directory structure
```
harmonie_sat_const
├── assharm_coef
├── cnrm_mwemis
├── rtcoef_rttov11
│   ├── harm_coef
├── rtcoef_rttov12
│   ├── harm_coef
├── rtcoef_rttov13
│   ├── harm_coef
└── uw_ir_emis_atlas_hdf5
```


# Some links
| Note                           | Link                                                                                                        |
|--------------------------------|-------------------------------------------------------------------------------------------------------------|
| Update history                 |  https://nwp-saf.eumetsat.int/site/software/rttov/download/coefficients/update-history/                     |
| coefficient file history log   |  https://nwp-saf.eumetsat.int/site/software/rttov/download/coefficients/detailed-file-history/              |
| RTTOV 11 coefficient download  |  https://nwp-saf.eumetsat.int/site/software/rttov/download/coefficients/rttov-v11-coefficient-download/     |
| MW coefficient file download   |  wget https://nwp-saf.eumetsat.int/downloads/rtcoef_rttov11/rttov7pred54L/rtcoef_mw_rttov7pred54L.tar.bz2   |
