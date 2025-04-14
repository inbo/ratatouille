#' Request an access token from the GIS API services
#'
#' The credentials are stored in your .Renviron file under `RATO_USER` and
#' `RATO_PWD`. If you haven't stored them there already the function will prompt
#' you for them and store them in these environmental variables. To reset any
#' stored values,  pass emtpy strings `""` to either the `username` or
#' `password` arguments.
#'
#' @param username ArcGIS Enterprise username
#' @param password ArcGIS Enterprise password
#' @param expires In minutes, how long should the token remain valid?
#'
#' @return Character. An access token for future API calls.
#'
#' @export
get_token <- function(username = Sys.getenv("RATO_USER"),
                      password = Sys.getenv("RATO_PWD"),
                      expires = 5) {
  # Check that username and password are strings if provided
  assertthat::assert_that(assertthat::is.string(username))
  assertthat::assert_that(assertthat::is.string(password))

  # If the pwd variable isn't set, prompt for password when session interactive
  if (password == "" | username == "") {
    Sys.setenv(RATO_USER = readline(prompt = "Please enter your RATO username: "))
    Sys.setenv(RATO_PWD = askpass::askpass())
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
      expiration = expires,
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
