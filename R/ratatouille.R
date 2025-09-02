#' Fetch raw invasive species data
#'
#' This function fetches the raw invasive species data from the specified
#' source. It supports fetching data from RATO (the default) and other sources
#' as they become available. All records from a source are returned, to fetch
#' specific records see [get_objects()].
#'
#' @param source Character string indicating the source of the data to fetch. By
#'   default RATO data is fetched.
#' @inheritParams get_objects
#' @inheritDotParams get_objects batch_size
#'
#' @return A data.frame containing the raw invasive species data from the
#'   selected source.
#' @export
#'
#' @examplesIf interactive()
#' ratatouille()
ratatouille <- function(source = c("rato"),
                        ...) {
  source <- rlang::arg_match(source)

  if (source %in% c("rato", "west-vlaanderen")) {
    
    # ratatouille() always returns all objects.
    object_ids <- list_object_ids()
    
    # Internally batch requests per 1000 records, these are processed in
    # parallel. If too many requests are batched, the token may expire before
    # the requests finish. NOTE: get_objects() uses further batching.
    internal_batch_size <- 1000
    batched_ids <-
      split(object_ids, ceiling(seq_along(object_ids) / internal_batch_size))

    batched_query_results <-
      batched_ids %>%
      purrr::map(\(object_ids) get_objects(object_ids,
                                           token = get_token(),
                                           ...),
                 .progress = TRUE)

    raw_data <- purrr::list_rbind(batched_query_results)
  }

  return(raw_data)
}