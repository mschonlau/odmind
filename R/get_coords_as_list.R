#' get_coords_as_list
#'
#' @param data A data.frame with coordinates in x and y columns
#'
#' @return List of longitude, latitude coordinate pairs
#' @export
#'
get_coords_as_list <- function(data) {
  x <- c(rbind(c(data$x), c(data$y)))
  split(x, ceiling(seq_along(x) / 2))
}
