# Fetch raw invasive species data

This function fetches the raw invasive species data from the specified
source. It supports fetching data from RATO and other sources as they
become available. All records from a source are returned, to fetch
specific records see [`get_objects()`](get_objects.md).

## Usage

``` r
ratatouille(source, ...)
```

## Arguments

- source:

  (Required) Character string indicating the source of the data to
  fetch. Currently supported data sources: `rato` will fetch RATO data
  and `wfl` will fetch data from the province of West Flanders.

- ...:

  Arguments passed on to [`get_objects`](get_objects.md)

  `batch_size`

  :   Number of objects to request per API call, default is 100. Setting
      this to a lower number will result in more API calls, but will
      also reduce the risk of timeouts or errors when requesting large
      datasets. When set to a higher number, the API may timeout or
      return an error if the dataset is too large.

## Value

A data.frame containing the raw invasive species data from the selected
source.

## Examples

``` r
if (FALSE) { # interactive()
ratatouille(source = "rato")
}
```
