#' List all object ids for a resource on a ArcGIS Enterprise MapServer
#'
#' This function lists all object ids for a given resource on a ArcGIS
#' Enterprise.
#'
#' @section Fetching all objects:
#'
#'   Downloading all data for a resource consists of a two step process. First
#'   all object ids for a resource are queried. Then the objects are fetched
#'   from that resource by their id.
#'
#' @section Caching:
#'
#'   The returned id's are cached by default, but this can be overwritten by
#'   calling `memoise::forget(list_object_ids)` which will remove the cache and
#'   ensure the next call queries the database (but will reinstate the cache for
#'   any follow up calls).
#'
#' @inheritParams ratatouille
#' @inheritParams get_objects
#'
#' @return Integer vector of (all) object ids.
#' @export
list_object_ids <- function(source,
                            resource = get_default_resource(source)) {
  # Query all objects, WHERE true
  query_object_ids(source, resource, "1=1")
}
