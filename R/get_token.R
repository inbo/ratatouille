#' Request an access token from the GIS API services
#'
#' The credentials are stored in your .Renviron file under `RATO_USER` and
#' `RATO_PWD`. If you haven't stored them there already the function will prompt
#' you for them and store them in these environmental variables. To reset any
#' stored values,  pass emtpy strings `""` to either the `username` or
#' `password` arguments.
#'
#' By default tokens expire every 5 minutes, and are cached until they expire.
#' You can set a different expiry duration by changing the
#' `ratatouille.rato_expires_minutes` option with `options()`
#'
#' @param username ArcGIS Enterprise username
#' @param password ArcGIS Enterprise password
#'
#' @return Character. An access token for future API calls.
#'
#' @export
get_token <- function(username = Sys.getenv("RATO_USER"),
                      password = Sys.getenv("RATO_PWD")) {
  # Check that username and password are strings if provided
  assertthat::assert_that(assertthat::is.string(username))
  assertthat::assert_that(assertthat::is.string(password))

  # If the pwd variable isn't set, prompt for password when session interactive
  if (password == "" || username == "") {
    rlang::abort(
      message =
        c("No username or password provided",
          paste("i Please provide username/password as arguments or set the as",
                "environemental variables or via `.Renviron` as `RATO_USER`",
                "and `RATO_PWD`.")
          ),
      class = "rato_no_pwd_provided"
    )
  }

  # Build request for the API
  token_request <-
    httr2::request("https://gis.oost-vlaanderen.be") %>%
    httr2::req_url_path("portal", "sharing", "rest", "generateToken") %>%
    httr2::req_body_form(
      username = username,
      password = password,
      # NOTE MUST USE CLIENT `referer`, otherwise you'll get a token but it will
      # not work!
      client = "referer",
      referer = "https://gis.oost-vlaanderen.be",
      expiration = getOption("ratatouille.rato_expires_minutes"),
      f = "json"
    )

  # Parse the API response
  token_response <-
    token_request %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  # If unable to login, reset the password so one is requested next time.
  if (
    purrr::pluck(token_response, "error", "code", .default = FALSE)
  ) {
    Sys.setenv(ratopwd = "")
    stop(
      glue::glue(purrr::chuck(token_response, "error", "message"),
                 purrr::map_chr(
                   purrr::chuck(token_response, "error", "details"),
                   ~.x)))
  } else {
    ## If there was no error, return the token
    return(token_response$token)
  }
}
