#' List all object ids for a resource on a ArcGIS Enterprise MapServer
#'
#' This function lists all object ids for a given resource on a ArcGIS
#' Enterprise.
#'
#' @section Fetching all objects
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
#'
#' @return Integer vector of (all) object ids.
#' @export
list_object_ids <- function(source = c("rato", "wfl")) {
  
  source <- rlang::arg_match(source)
  
  # Build the request by querying all objects, but only return ids.
  object_ids_request <-
    httr2::request(get_api_domain(source)) |>
    # Components of the API endpoint
    httr2::req_url_path_append(get_api_basepath(source, "server"),
                               "rest",
                               "services") |>
    # Components of the table to query
    httr2::req_url_path_append(
      get_default_resource(source),
      "MapServer",
      "0",
      "query") |>
    httr2::req_url_query(
      # Query all objects, WHERE true
      where = "1=1",
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
  return(object_ids)
}
