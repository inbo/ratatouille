# Query object ids for a resource on a ArcGIS Enterprise MapServer

This function returns all object ids that pass a query for a given
resource on a ArcGIS Enterprise.

## Usage

``` r
query_object_ids(
  source,
  resource = get_default_resource(source),
  query = "1=1"
)
```

## Arguments

- source:

  (Required) Character string indicating the source of the data to
  fetch. Currently supported data sources: `rato` will fetch RATO data
  and `wfl` will fetch data from the province of West Flanders.

- resource:

  The resource to query. Defaults to the default resource for the given
  source.

- query:

  A SQL where clause to filter the objects to query. Defaults to "1=1"
  which queries all objects, but can be used to filter the objects to
  query by any field in the table. For example, if you only want to
  query objects with a specific value in a field, you can use a query
  like "field_name = 'value'".

## Value

Integer vector of (filtered) object ids.

## Examples

``` r
query_object_ids("wfl",
  query = "Gemeente='Koekelare'"
)
#> Error in check_credentials(source): No username or password provided
#> • i Please provide username/password via  environmental variables or via `.Renviron` as `RATO_USER` ,`RATO_PWD` and/or `WFL_USER`,`WFL_PWD`.
```
