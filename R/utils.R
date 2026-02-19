#' Convert milliseconds since 1970-01-01 to datetime
#'
#' The RATO database returns datetimes as miliseconds since 1970-01-01. This
#' function converts these to POSIXct datetimes.
#'
#' By default the timezone is set to UTC.
#'
#' @param miliseconds Integer vector of miliseconds since 1970-01-01.
#' @param origin Character. The origin date to use for the conversion. Default
#'   is "1970-01-01".
#' @param ... further arguments to be passed to or from other methods of
#'   `as.POSIXct()`.
#'
#' @return POSIXct vector of datetimes with timezone UTC.
#'
#' @examples
#' as_datetime(1.673858e+12)
#' @family utils
#' @noRd
as_datetime <- function(miliseconds, origin = "1970-01-01", ...) {
  as.POSIXct(miliseconds / 1000, origin = origin, tz = "UTC", ...)
}

#' Get API base url for a given source
#'
#' This function takes a source enum and returns the corresponding API base url.
#' This allows other functions to use this function to determine which API url
#' to send requests to based on the source specified.
#'
#' @param source Character string of the source enum to look up the API url for.
#'
#' @returns Character string of the API base url corresponding to the specified
#'   source.
#'
#' @examples
#' get_api_domain("rato")
#' @family utils
#' @noRd
get_api_domain <- function(source = c("rato", "wfl")){
  source <- rlang::arg_match(source)
  dplyr::recode_values(
    source,
    "rato" ~ "https://gis.oost-vlaanderen.be",
    "wfl" ~ "https://gwadmin.west-vlaanderen.be",
    unmatched = "error"
  )
}

#' Create .onLoad function to set Package options and memoisation behavior on
#' load
#'
#' - ratatouille.rato_expires_minutes controls both how long a RATO ArcGIS REST
#'  API access token should stay valid, and how long it should be cached for 
#'  (the same duration).
#' - ratatouille.cache_max_age_secs controls the number of seconds a value 
#'  stays in the cache. Setting this too high might result in changes in the 
#'  source data not being fetched.
#' @noRd
.onLoad <- function(libname, pkgname) {
  # Package options
  op <- options()
  op.ratatouille <- list(
    ratatouille.rato_expires_minutes = 5,
    ratatouille.cache_max_age_secs = 150,
    ratatouille.RATO_API_CAPACITY = 750
  )
  toset <- !(names(op.ratatouille) %in% names(op))
  if (any(toset)) options(op.ratatouille[toset])


  # Memoisation
  get_token <<- memoise::memoise(get_token,
    # token expires every 5 minutes
    cache = cachem::cache_mem(
      max_age = 60 * getOption("ratatouille.rato_expires_minutes")
    )
  )

  list_object_ids <<-
    memoise::memoise(list_object_ids,
                     cache =
                       cachem::cache_mem(
                         max_age = getOption("ratatouille.cache_max_age_secs")
                         )
                     )
}
