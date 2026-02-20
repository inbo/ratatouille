#' Query object ids for a resource on a ArcGIS Enterprise MapServer
#'
#' This function returns all object ids that pass a query for a given resource
#' on a ArcGIS Enterprise.
#'
#' @inheritParams ratatouille
#' @param resource The resource to query. Defaults to the default resource for
#'   the given source.
#' @param query A SQL where clause to filter the objects to query. Defaults to
#'   "1=1" which queries all objects, but can be used to filter the objects to
#'   query by any field in the table. For example, if you only want to query
#'   objects with a specific value in a field, you can use a query like
#'   "field_name = 'value'".
#'
#' @return Integer vector of (filtered) object ids.
#' @export
#' @examples
#' query_object_ids("wfl",
#'   query = "Gemeente='Koekelare'"
#' )
#'
query_object_ids <- function(source,
                             resource = get_default_resource(source),
                             query = "1=1") {
  # Validate input arguments
  check_source(source)
  assertthat::assert_that(assertthat::is.string(query))

  # Build the request by querying all objects, but only return ids.
  object_ids_request <-
    httr2::request(get_api_domain(source)) |>
    # Components of the API endpoint
    httr2::req_url_path_append(
      get_api_basepath(source, "server"),
      "rest",
      "services"
    ) |>
    # Components of the table to query
    httr2::req_url_path_append(
      get_default_resource(source),
      "MapServer",
      "0",
      "query"
    ) |>
    httr2::req_url_query(
      where = query,
      returnIdsOnly = "true",
      f = "pjson",
      token = get_token(source)
    ) |>
    httr2::req_retry(max_tries = 3)

  # Perform request
  object_ids_response <-
    object_ids_request |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE)

  object_ids <- object_ids_response |>
    purrr::chuck("objectIds") |>
    unlist()

  object_ids
}
