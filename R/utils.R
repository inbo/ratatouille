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

#' Create .onLoad function to set Package options and memoisation behavior on
#' load
#'
#' - ratatouille.rato_expires_minutes controls both how long a RATO ArcGIS REST
#'  API access token should stay valid, and how long it should be cached for 
#'  (the same duration).
#' @noRd
.onLoad <- function(libname, pkgname) {
  # Package options
  op <- options()
  op.ratatouille <- list(
    ratatouille.rato_expires_minutes = 5
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
    memoise::memoise(list_object_ids)
}
