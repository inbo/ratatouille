# Get objects from an ArcGIS Enterprise environment via the REST API

This function retrieves objects from an ArcGIS environment based on the
object_id. It is capable of retrieving a large amount of objects in a
single function call. As to minimize errors it will fetch `batch size`
number of objects per request, and will operate in parallel: for a
maximum of 5000 requests per 60 seconds, having at most 10 requests open
at a time.

## Usage

``` r
get_objects(
  object_ids,
  source,
  resource = get_default_resource(source),
  batch_size = 100
)
```

## Arguments

- object_ids:

  Vector of object_ids for a specific resource, these allow you to fetch
  a specific database record.

- source:

  (Required) Character string indicating the source of the data to
  fetch. Currently supported data sources: `rato` will fetch RATO data
  and `wfl` will fetch data from the province of West Flanders.

- resource:

  The resource to query. Defaults to the default resource for the given
  source.

- batch_size:

  Number of objects to request per API call, default is 100. Setting
  this to a lower number will result in more API calls, but will also
  reduce the risk of timeouts or errors when requesting large datasets.
  When set to a higher number, the API may timeout or return an error if
  the dataset is too large.

## Value

tibble of requested objects.

## Details

To query an ArcGIS REST API you need credentials. Without credentials
accessing the raw data is not possible.
