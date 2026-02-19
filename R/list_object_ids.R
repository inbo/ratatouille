#' List all object ids in the RATO ArcGIS Enterprise MapServer
#'
#' The returned id's are cached by default, but this can be overwritten by
#' calling `memoise::forget(list_object_ids)` which will remove the cache and
#' ensure the next call queries the database (but will reinstate the cache for
#' any follow up calls).
#'
#' @inheritParams ratatouille
#'
#' @return Integer vector of (all) object ids.
#' @export
list_object_ids <- function(source = c("rato", "wfl")) {
  
  source <- rlang::arg_match(source)
  # Get an access token for the API
  token <- get_token(source)
  
  # Build the request by querying all objects, but only return ids.
  object_ids_request <-
    httr2::request("https://gis.oost-vlaanderen.be/server/rest/services/") |>
    httr2::req_url_path_append(
      "RATO2",
      "RATO2_Dossiers_Publiek",
      "MapServer",
      "0",
      "query") |>
    httr2::req_url_query(
      where = "1=1",
      returnIdsOnly = "true",
      f = "pjson",
      token = token
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
