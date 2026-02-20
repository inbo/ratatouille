#' Get default resource path for a given source
#'
#' ArcGIS Enterprise allows queries based on the layerOrTableId, this function
#' returns a default resource to query.
#'
#' @param source Character string of the source to look up the default
#'   resource for.
#'
#' @returns Character string of the default resource path corresponding to the
#'   specified source.
#' @export
#' @examples
#' get_default_resource("rato")
get_default_resource <- function(source = c("rato", "wfl")) {
  source <- rlang::arg_match(source)
  
  dplyr::recode_values(
    source,
    "rato" ~ paste("RATO2", "RATO2_Dossiers_Publiek", sep = "/"),
    "wfl" ~ paste("Ecosystem2", "AGS_ES2_Dossiers_Publiek", sep = "/"),
    unmatched = "error"
  )
}