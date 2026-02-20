
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ratatouille

<!-- badges: start -->

[![R-CMD-check](https://github.com/inbo/ratatouille/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/inbo/ratatouille/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/inbo/ratatouille/graph/badge.svg)](https://app.codecov.io/gh/inbo/ratatouille)

<!-- badges: end -->

## Rationale

This repository contains the functionality to access the unprocessed
management data of [RATO
vzw](https://oost-vlaanderen.be/wonen-en-leven/natuur-en-milieu/overlastsoorten/rattenbestrijding-.html)
and the province of West Flanders via an API call to an [ESRI ArcGIS
instance](https://developers.arcgis.com/documentation/). Credentials are
required to access this data. These credentials are stored as a github
secrets under the `RATO_USER`, `RATO_PWD` and `WFL_USER`,
`WFL_PWD`environmental parameters respectively, and can be set locally
by editing the `.Renviron` file.

## Set Up your credentials locally

The easiest way to store the required username and password necessary to
access a data source is by storing them in your `.Renviron` file. An
easy way to edit this file is by using a function from [the usethis
package](https://usethis.r-lib.org/).

``` r
# install.packages("usethis")
usethis::edit_r_environ()
```

The contents of the file may contain other secrets or settings used by
other scripts or packages, but can be edited to have lines like:

``` bash
RATO_USER = "your username"
RATO_PWD = "your password"
```

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
rato_data <- ratatouille(source = "rato")
```

The resulting object looks like this (but has many more columns):

| Soort | Materiaal_Vast | Materiaal_Consumptie | Laatst_Bewerkt_Datum |
|:---|:---|:---|:---|
| Duiven | Actieve kooi (aantal) = 2; | NA | 2024-12-23 08:19:56 |
| Bruine rat bak/buis | NA | Broma blok (aantal) = 1; | 2022-12-14 11:29:18 |
| Bruine rat bak/buis | NA | Difa blok (aantal) = 1; | 2023-07-07 14:00:29 |
| Bruine rat bak/buis | NA | Difa blok (aantal) = 1; | 2024-01-02 13:52:28 |
| Bruine rat bak/buis | NA | Difa blok (aantal) = 2; | 2024-01-25 09:04:54 |

For this example only a few fields are shown because there is the
possibility of personal data in other fields.

### Available columns

These are all columns available for the `rato` data source:

    #> Rows: 0
    #> Columns: 28
    #> $ Dossier_ID           <int> 
    #> $ OBJECTID             <int> 
    #> $ Dossier_Status       <chr> 
    #> $ Domein               <chr> 
    #> $ Soort                <chr> 
    #> $ Waarneming           <chr> 
    #> $ Actie                <chr> 
    #> $ Materiaal_Vast       <chr> 
    #> $ Materiaal_Consumptie <chr> 
    #> $ Opmerkingen_admin    <chr> 
    #> $ Opmerkingen          <chr> 
    #> $ Melder_Naam          <chr> 
    #> $ Melder_Klant         <chr> 
    #> $ Planning_Datum       <dttm> 
    #> $ X                    <dbl> 
    #> $ Y                    <dbl> 
    #> $ Gemeente             <chr> 
    #> $ Aard_Locatie         <chr> 
    #> $ NIS_Code             <int> 
    #> $ GBIF_Code            <int> 
    #> $ Dossier_Link         <lgl> 
    #> $ Dossier_Link_ID      <lgl> 
    #> $ Hoofddossier_ID      <int> 
    #> $ Aangemaakt_Datum     <dttm> 
    #> $ Laatst_Bewerkt_Datum <dttm> 
    #> $ Datum_Van            <dttm> 
    #> $ Geometrie_Type       <chr> 
    #> $ GlobalID             <chr>

## Species in the dataset

This is raw data, some cleaning will be required. Dutch names and GBIF
taxon ids are provided, but these last are often unchecked and may
contain errors. Note that you can only download data for one source at a
time.

``` r
 purrr::map(c("wfl", "rato"), ~ratatouille(source = .x)) |>
  purrr::list_rbind() |>
  dplyr::count(Soort, sort = TRUE)
#>                                  Soort      n
#>                                 <char>  <int>
#>  1:                Bruine rat bak/buis 124743
#>  2:                         Bruine rat  33459
#>  3:                          Muskusrat  27444
#>  4:                Aziatische hoornaar  21290
#>  5:                             Duiven   5848
#>  6:                        Zwerfkatten   5624
#>  7:                   Roosters/kleppen   5043
#>  8:                             Muizen   1715
#>  9:                   Reuzenberenklauw   1116
#> 10:                           Meetpunt   1031
#> 11:                Lettersierschildpad    904
#> 12:                              Bever    759
#> 13:                             Mollen    530
#> 14:                       Voederplaats    520
#> 15:                        Steenmarter    360
#> 16:                             Kippen    298
#> 17:                         Vistrappen    241
#> 18:                    Halsbandparkiet    165
#> 19:                      Canadese Gans    153
#> 20:               Japanse Duizendknoop    147
#> 21:                   Waterteunisbloem     90
#> 22:               Obstructie waterloop     87
#> 23:        Andere (soort vermelden):       83
#> 24:                    Neerhofdier(en)     79
#> 25:                        Ganzenactie     76
#> 26:                           Nijlgans     72
#> 27:                    Reuzenbalsemien     58
#> 28:                           Konijnen     55
#> 29:                    Parelvederkruid     51
#> 30:               gedomesticeerde gans     48
#> 31:                   Grote Waternavel     44
#> 32:           Mantsjoerese wilde rijst     26
#> 33:                     Sluikstorting      20
#> 34:         Aziatische hoornaar actie      17
#> 35:                        Grauwe Gans     16
#> 36:                  Amerikaanse Nerts     14
#> 37:            Amerikaanse Stierkikker     12
#> 38:                       Rivierkreeft     12
#> 39:                         Zwarte rat      9
#> 40:                          Kippen:        8
#> 41:                      Watercrassula      8
#> 42:        structuurprobleem waterloop      8
#> 43:                       Leidse Plant      7
#> 44:             Aziatische hoornaar:        6
#> 45:                 Exotische Eekhoorn      5
#> 46:                 Neerhofdier(en):        5
#> 47:                           Watersla      5
#> 48:                          Brandgans      4
#> 49:                   slecht onderhoud      4
#> 50:                           Beverrat      2
#> 51:                         Boerengans      2
#> 52:                      Bruine rat:        2
#> 53:           Andere (soort vermelden)      1
#> 54:    Andere (soort vermelden):  Eend      1
#> 55: Andere (soort vermelden):  Kraaien      1
#> 56:                    Moerasaronskelk      1
#> 57:                               <NA>      1
#>                                  Soort      n
#>                                 <char>  <int>
```
