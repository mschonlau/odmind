#' @title call_ors_matrix
#'
#' @description Chunk-wise calls to ors_matrix
#'
#' @param x_y_coordinates List of longitude, latitude coordinate pairs
#' @param ors_profile Route profile
#' @param sources_chunk_size integer value to identify the sources
#' @param destination_chunk_size integer value to identify the targets
#'
#' @return Duration and distance matrix for multiple sources and targets
#' @export
#'
call_ors_matrix <- function(x_y_coordinates, ors_profile, sources_chunk_size,
                            destination_chunk_size) {
  source_max <- sources_chunk_size - 1
  destinations_min <- sources_chunk_size
  destinations_max <- sources_chunk_size + destination_chunk_size - 1
  ors_matrix(
    locations = x_y_coordinates,
    profile = ors_profile,
    sources = seq(0, source_max),
    destinations = seq(destinations_min, destinations_max),
    metrics = c("duration", "distance"),
    units = "m"
  )
}
