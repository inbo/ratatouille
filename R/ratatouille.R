#' Fetch raw invasive species data
#'
#'
#' @param source Character string indicating the source of the data to fetch. By
#'   default RATO data is fetched.
#' @param ... Passed on to internal helpers.
#'
#' @return A data.frame containing the raw invasive species data from the
#'   selected source.
#' @export
#'
#' @examplesIf interactive()
#' ratatouille()
ratatouille <- function(source = c("rato"), ...) {
  raw_data <-
    switch(rlang::arg_match(source),
      rato = get_objects(...)
    )

  return(raw_data)
}