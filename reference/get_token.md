# Request an access token from the GIS API services

The credentials are stored in your .Renviron file under `RATO_USER` and
`RATO_PWD` and/or `WFL_USER` and `WFL_PWD`. To get credentials please
contact the data sources directly.

## Usage

``` r
get_token(source)
```

## Arguments

- source:

  (Required) Character string indicating the source of the data to
  fetch. Currently supported data sources: `rato` will fetch RATO data
  and `wfl` will fetch data from the province of West Flanders.

## Value

Character. An access token for future API calls.

## Details

By default tokens expire every 5 minutes, and are cached until they
expire. You can set a different expiry duration by changing the
`ratatouille.token_expires_minutes` option with
[`options()`](https://rdrr.io/r/base/options.html)
