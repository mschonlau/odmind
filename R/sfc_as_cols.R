#' @title sfc_as_cols
#'
#' @description Binds x-y-coordinates as cols to sf
#'
#' @param x A sf or sfc_POINT object
#' @param names A character vector of length two to define names for the new
#' x and y coordinate columns
#'
#' @return sf object including coordinates as new columns
#'
#' @export

sfc_as_cols <- function(x, names = c("x", "y")) {
  stopifnot(inherits(x, "sf") && inherits(sf::st_geometry(x), "sfc_POINT"))
  coords <- sf::st_coordinates(x)
  coords <- tibble::as_tibble(coords)
  stopifnot(length(names) == ncol(coords))
  x <- x[, !names(x) %in% names]
  coords <- setNames(coords, names)
  dplyr::bind_cols(x, coords)
}
