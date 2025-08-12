
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
#> Fetching ■                                  1% | ETA:  1m
#> Fetching ■■■                                7% | ETA: 36s
#> Fetching ■■■■■■                            16% | ETA: 30s
#> Fetching ■■■■■■■■■                         25% | ETA: 26s
#> Fetching ■■■■■■■■■■                        32% | ETA: 26s
#> Fetching ■■■■■■■■■■■                       33% | ETA: 30s
#> Fetching ■■■■■■■■■■■                       34% | ETA: 34s
#> Fetching ■■■■■■■■■■■■                      36% | ETA: 39s
#> Fetching ■■■■■■■■■■■■                      37% | ETA: 41s
#> Fetching ■■■■■■■■■■■■                      38% | ETA: 43s
#> Fetching ■■■■■■■■■■■■■                     39% | ETA: 46s
#> Fetching ■■■■■■■■■■■■■                     41% | ETA: 48s
#> Fetching ■■■■■■■■■■■■■■                    42% | ETA: 49s
#> Fetching ■■■■■■■■■■■■■■                    43% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■                    45% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■                   46% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■                   47% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■                  49% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■                  50% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■                  51% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■■                 53% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■■                 54% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■■■                55% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■■■                57% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■■■                58% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■■■■               59% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■■■■               61% | ETA:  1m
#> Fetching ■■■■■■■■■■■■■■■■■■■■              62% | ETA: 50s
#> Fetching ■■■■■■■■■■■■■■■■■■■■              63% | ETA: 49s
#> Fetching ■■■■■■■■■■■■■■■■■■■■              65% | ETA: 48s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■             66% | ETA: 46s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■             67% | ETA: 46s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■            69% | ETA: 44s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■            70% | ETA: 43s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■            71% | ETA: 41s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■           73% | ETA: 40s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■           74% | ETA: 38s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■          75% | ETA: 37s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■          76% | ETA: 36s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■          78% | ETA: 33s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■         79% | ETA: 32s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■         80% | ETA: 30s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■        82% | ETA: 28s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■        83% | ETA: 27s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■        84% | ETA: 24s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■       85% | ETA: 23s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■       87% | ETA: 21s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■       88% | ETA: 19s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■■      89% | ETA: 17s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■■      91% | ETA: 15s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■     92% | ETA: 13s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■     93% | ETA: 11s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■     95% | ETA:  9s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■    96% | ETA:  6s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■    98% | ETA:  4s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■   99% | ETA:  2s
#> Fetching ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100% | ETA:  0s
dplyr::slice_sample(rato_data, n = 5) |>
  dplyr::select(dplyr::all_of(c("Soort", "Materiaal_Vast", "Materiaal_Consumptie", "Laatst_Bewerkt_Datum")))
#>                  Soort Materiaal_Vast          Materiaal_Consumptie
#>                 <char>         <char>                        <char>
#> 1: Bruine rat bak/buis           <NA>     Broma blok (aantal) = 1; 
#> 2: Bruine rat bak/buis           <NA> Geen gif bijgevuld (ok) = 1; 
#> 3: Bruine rat bak/buis           <NA>     Broma blok (aantal) = 1; 
#> 4: Bruine rat bak/buis           <NA>     Broma blok (aantal) = 1; 
#> 5: Bruine rat bak/buis           <NA>      Difa blok (aantal) = 2; 
#>    Laatst_Bewerkt_Datum
#>                  <POSc>
#> 1:  2023-05-16 11:24:17
#> 2:  2024-07-30 07:53:51
#> 3:  2022-09-07 10:46:58
#> 4:  2023-11-30 08:40:04
#> 5:  2022-10-14 09:27:46
```

For this example a subset of fields that should not contain sensitive
information were selected.

## Species in the dataset

This is raw data, some cleaning will be required. Dutch names and GBIF
taxon ids are provided, but these last are often unchecked and may
contain errors.

``` r
dplyr::count(rato_data, Soort, sort = TRUE)
#>                                  Soort      n
#>                                 <char>  <int>
#>  1:                Bruine rat bak/buis 113325
#>  2:                         Bruine rat  28627
#>  3:                          Muskusrat  19768
#>  4:                Aziatische hoornaar   6895
#>  5:                        Zwerfkatten   4811
#>  6:                   Roosters/kleppen   4429
#>  7:                             Duiven   4371
#>  8:                             Muizen   1308
#>  9:                   Reuzenberenklauw   1027
#> 10:                           Meetpunt    965
#> 11:                Lettersierschildpad    877
#> 12:                              Bever    440
#> 13:                       Voederplaats    390
#> 14:                             Mollen    344
#> 15:                        Steenmarter    302
#> 16:                             Kippen    245
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
#> 28:                    Parelvederkruid     50
#> 29:               gedomesticeerde gans     47
#> 30:                           Konijnen     46
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
