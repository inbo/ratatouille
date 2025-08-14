
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ratatouille

<!-- badges: start -->

[![R-CMD-check](https://github.com/inbo/ratatouille/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/inbo/ratatouille/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/inbo/ratatouille/graph/badge.svg)](https://app.codecov.io/gh/inbo/ratatouille)
<!-- badges: end -->

## Rationale

This repository contains the functionality to access the unprocessed
data of [RATO
vzw](https://oost-vlaanderen.be/wonen-en-leven/natuur-en-milieu/overlastsoorten/rattenbestrijding-.html)
via an API call to an [ESRI ArcGIS
instance](https://developers.arcgis.com/documentation/). Credentials are
required to access this data. These credentials are stored as a github
secrets under the `RATO_USER` and `RATO_PWD` environmental parameters,
and can be set locally by editing the `.Renviron` file.

## Set Up your RATO credentials locally

The easiest way to store the required username and password necessary to
access the RATO database is by storing them in your `.Renviron` file. An
easy way to edit this file is by using a function from [the usethis
package](https://usethis.r-lib.org/).

``` r
install.packages("usethis")
usethis::edit_r_environ()
```

The contents of the file may contain other secrets or settings used by
other scripts or packages, but can be edited to have lines like:

    RATO_USER = "RATO_INBO"
    RATO_PWD = "a super fake password that should be replaced by your real one"

After restarting your R instance you should be able to fetch data from
the RATO database without being prompted for your credentials.

## Installation

You can install the development version of ratatouille from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("inbo/ratatouille")
```

## Example

Once you have your credentials stored, getting raw data from RATO is as
easy as:

``` r
library(ratatouille)
rato_data <- ratatouille()
```

The resulting object looks like this (but has many more columns):

``` r
dplyr::slice_sample(rato_data, n = 5) |>
  dplyr::select(dplyr::all_of(c("Soort", "Materiaal_Vast", "Materiaal_Consumptie", "Laatst_Bewerkt_Datum"))) |> knitr::kable()
```

| Soort | Materiaal_Vast | Materiaal_Consumptie | Laatst_Bewerkt_Datum |
|:---|:---|:---|:---|
| Bruine rat bak/buis | NA | Broma blok (aantal) = 1; | 2022-02-04 09:27:43 |
| Roosters/kleppen | NA | NA | 2023-01-25 11:53:31 |
| Bruine rat bak/buis | NA | Difa blok Groot (aantal) = 1; | 2025-01-03 10:27:46 |
| Bruine rat bak/buis | NA | Broma blok (aantal) = 1; | 2023-08-17 12:47:00 |
| Bruine rat bak/buis | NA | Geen gif bijgevuld (ok) = 1; | 2024-07-05 07:42:22 |

For this example only a few fields are shown because there is the
possibility of personal data in other fields.

## Species in the dataset

This is raw data, some cleaning will be required. Dutch names and GBIF
taxon ids are provided, but these last are often unchecked and may
contain errors.

``` r
dplyr::count(rato_data, Soort, sort = TRUE)
#>                                  Soort      n
#>                                 <char>  <int>
#>  1:                Bruine rat bak/buis 113511
#>  2:                         Bruine rat  28686
#>  3:                          Muskusrat  19774
#>  4:                Aziatische hoornaar   7113
#>  5:                        Zwerfkatten   4834
#>  6:                   Roosters/kleppen   4434
#>  7:                             Duiven   4374
#>  8:                             Muizen   1320
#>  9:                   Reuzenberenklauw   1030
#> 10:                           Meetpunt    967
#> 11:                Lettersierschildpad    879
#> 12:                              Bever    440
#> 13:                       Voederplaats    390
#> 14:                             Mollen    345
#> 15:                        Steenmarter    302
#> 16:                             Kippen    246
#> 17:                         Vistrappen    227
#> 18:                      Canadese Gans    153
#> 19:                    Halsbandparkiet    126
#> 20:               Japanse Duizendknoop    115
#> 21:        Andere (soort vermelden):       77
#> 22:                        Ganzenactie     76
#> 23:                   Waterteunisbloem     75
#> 24:                           Nijlgans     66
#> 25:                    Neerhofdier(en)     64
#> 26:                    Reuzenbalsemien     56
#> 27:               Obstructie waterloop     52
#> 28:                    Parelvederkruid     51
#> 29:                           Konijnen     47
#> 30:               gedomesticeerde gans     47
#> 31:                   Grote Waternavel     32
#> 32:           Mantsjoerese wilde rijst     19
#> 33:         Aziatische hoornaar actie      17
#> 34:                        Grauwe Gans     16
#> 35:                     Sluikstorting      16
#> 36:                  Amerikaanse Nerts     14
#> 37:                       Rivierkreeft     12
#> 38:                          Kippen:        8
#> 39:        structuurprobleem waterloop      8
#> 40:                         Zwarte rat      7
#> 41:            Amerikaanse Stierkikker      6
#> 42:             Aziatische hoornaar:        6
#> 43:                      Watercrassula      6
#> 44:                 Exotische Eekhoorn      5
#> 45:                 Neerhofdier(en):        5
#> 46:                          Brandgans      4
#> 47:                   slecht onderhoud      4
#> 48:                       Leidse Plant      3
#> 49:                           Watersla      3
#> 50:                           Beverrat      2
#> 51:                         Boerengans      2
#> 52:                      Bruine rat:        2
#> 53:           Andere (soort vermelden)      1
#> 54:    Andere (soort vermelden):  Eend      1
#> 55: Andere (soort vermelden):  Kraaien      1
#>                                  Soort      n
```
