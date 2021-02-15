#' call_ors_matrix_multicore
#'
#' @param x_y_coordinates List of longitude, latitude coordinate pairs
#' @param ors_profile Route profile
#' @param sources_chunk_size integer value to identify the sources
#' @param destination_chunk_size integer value to identify the targets
#' @param ors_url url of the openrouteservice server to be used for processing
#'
#' @return Duration and distance matrix for multiple sources and targets
#' @noRd
#'
call_ors_matrix_multicore <- function(x_y_coordinates, ors_profile,
                                      sources_chunk_size,
                                      destination_chunk_size, ors_url) {
  options(openrouteservice.url = ors_url)
  source_max <- sources_chunk_size - 1
  destinations_min <- sources_chunk_size
  destinations_max <- sources_chunk_size + destination_chunk_size - 1
  openrouteservice::ors_matrix(x_y_coordinates,
                               profile = ors_profile,
                               sources = seq(0, source_max),
                               destinations = seq(destinations_min,
                                                  destinations_max),
                               metrics = c("duration", "distance"),
                               units = "m")
}
