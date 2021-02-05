#' read_inputs
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#' @param id_col name of the id column used for grouping operations
#' @param crs epsg code
#'
#' @return A list object
#' @noRd
#'
read_inputs <- function(aoi_sf, pnt_sf, id_col, crs = 4647) {
  crs <- crs
  aoi <- aoi_sf %>%
    sf::st_transform(crs) %>%
    sf::st_zm(drop = TRUE, what = "ZM") %>%
    dplyr::select(id_col)
  pnt <- pnt_sf %>%
    sf::st_transform(crs) %>%
    return(list(aoi, pnt))
}
