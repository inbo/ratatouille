#' Request an access token from the GIS API services
#'
#' The credentials are stored in your .Renviron file under `RATO_USER` and
#' `RATO_PWD` and/or `WFL_USER` and `WFL_PWD`. To get credentials please contact
#' the data sources directly.
#'
#' By default tokens expire every 5 minutes, and are cached until they expire.
#' You can set a different expiry duration by changing the
#' `ratatouille.rato_expires_minutes` option with `options()`
#'
#' @inheritParams ratatouille
#'
#' @return Character. An access token for future API calls.
#'
#' @export
get_token <- function(source = c("rato", "wfl")) {
  
  check_source(source)

  # Check if credentials are set as environemental variables
  check_credentials(source)
  # Build request for the API
  token_request <-
    get_api_domain(source) |>
    httr2::request() |>
    httr2::req_url_path(get_api_basepath(source, "portal"),
                        "sharing",
                        "rest",
                        "generateToken") |>
    httr2::req_body_form(
      username = Sys.getenv(toupper(paste0(source,"_USER"))),
      password = Sys.getenv(toupper(paste0(source,"_PWD"))),
      # NOTE MUST USE CLIENT `referer`, otherwise you'll get a token but it will
      # not work!
      client = "referer",
      referer = get_api_domain(source),
      expiration = getOption("ratatouille.rato_expires_minutes"),
      f = "json"
    ) |> 
    httr2::req_retry(max_tries = 3)

  # Parse the API response
  token_response <-
    token_request |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  # If unable to login, forward the API error.
  if (
    purrr::pluck(token_response, "error", "code", .default = FALSE)
  ) {
    # If the API returns an error, forward it.
    rlang::abort(
      glue::glue(purrr::chuck(token_response, "error", "message"),
                 purrr::map_chr(
                   purrr::chuck(token_response, "error", "details"),
                   ~.x)),
      class = "rata_auth_error")
  } else {
    ## If there was no error, return the token
    return(token_response$token)
  }
}
