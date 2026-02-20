#' Fetch raw invasive species data
#'
#' This function fetches the raw invasive species data from the specified
#' source. It supports fetching data from RATO and other sources
#' as they become available. All records from a source are returned, to fetch
#' specific records see [get_objects()].
#'
#' @param source (Required) Character string indicating the source of the data
#'   to fetch. Currently supported data sources: `rato` will fetch RATO data and
#'   `wfl` will fetch data from the province of West Flanders.
#' @inheritParams get_objects
#' @inheritDotParams get_objects batch_size
#'
#' @return A data.frame containing the raw invasive species data from the
#'   selected source.
#' @export
#'
#' @examplesIf interactive()
#' ratatouille(source = "rato")
ratatouille <- function(source, ...) {
  check_source(source)

  # ratatouille() always returns all objects.
  object_ids <- list_object_ids(source = source)

  # Internally batch requests per 1000 records, these are processed in
  # parallel. If too many requests are batched, the token may expire before
  # the requests finish. NOTE: get_objects() uses further batching.
  internal_batch_size <- 1000
  batched_ids <-
    split(object_ids, ceiling(seq_along(object_ids) / internal_batch_size))

  batched_query_results <-
    batched_ids |>
    purrr::map(
      \(object_ids) {
        get_objects(object_ids,
          source = source,
          ...
        )
      },
      .progress = TRUE
    )

  # Return raw data
  purrr::list_rbind(batched_query_results)
}
