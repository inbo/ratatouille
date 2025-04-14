<!-- badges: start -->
[![funding](https://img.shields.io/static/v1?label=published+through&message=LIFE+RIPARIAS&labelColor=00a58d&color=ffffff)](https://www.riparias.be/)
[![fetch-data](https://github.com/riparias/rato-occurrences/actions/workflows/fetch-data.yaml/badge.svg)](https://github.com/riparias/rato-occurrences/actions/workflows/fetch-data.yaml)
[![mapping and testing](https://github.com/riparias/rato-occurrences/actions/workflows/mapping_and_testing.yaml/badge.svg)](https://github.com/riparias/rato-occurrences/actions/workflows/mapping_and_testing.yaml)
[![R-CMD-check](https://github.com/riparias/rato-occurrences/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/riparias/rato-occurrences/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Rationale

This repository contains the functionality to access the unprocessed data of 
[RATO vzw](https://oost-vlaanderen.be/wonen-en-leven/natuur-en-milieu/overlastsoorten/rattenbestrijding-.html) 
via an API call to an [ESRI ArcGIS instance](https://developers.arcgis.com/documentation/).
Credentials are required to access this data. These credentials are stored as a github secrets under the `RATO_USER` and `RATO_PWD` environmental parameters, and can be set locally by editing the `.Renviron` file.

## Set Up your RATO credentials locally

The easiest way to store the required username and password necessary to access the RATO database is by storing them in your `.Renviron` file. An easy way to edit this file is by using a function from [the usethis package](https://usethis.r-lib.org/). 

```r
install.packages("usethis")
usethis::edit_r_environ()
```

The contents of the file may contain other secrets or settings used by other scripts or packages, but can be edited to have lines like:

```
RATO_USER = "RATO_INBO"
RATO_PWD = "a super fake password that should be replaced by your real one"
```

After restarting your R instance you should be able to fetch data from the RATO database without being prompted for your credentials.


## Installation

```r
pak::pkg_install("inbo/rato-data")

```
## License

[MIT License](LICENSE) for the code and documentation in this repository. The fetched data is released under another license.
