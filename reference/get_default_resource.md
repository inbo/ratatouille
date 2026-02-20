# Get default resource path for a given source

ArcGIS Enterprise allows queries based on the layerOrTableId, this
function returns a default resource to query.

## Usage

``` r
get_default_resource(source = NULL)
```

## Arguments

- source:

  Character string of the source to look up the default resource for.
  Either "rato" or "wfl".

## Value

Character string of the default resource path corresponding to the
specified source.

## Examples

``` r
get_default_resource("rato")
#> [1] "RATO2/RATO2_Dossiers_Publiek"
```
