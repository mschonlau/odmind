#' @title create_time_distance_sf
#'
#' @description Create sf object of geometry type point with minimum distance
#' and duration values for each source to target combination
#'
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param source_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#'
#' @return sf object of geometry type point
#' @export
#' @importFrom dplyr "%>%"

create_time_distance_sf <- function(odm_object, source_sf, target_df) {
  nearest_target_dist <- identify_nearest_target(odm_object, "distance")
  nearest_target_time <- identify_nearest_target(odm_object, "duration")
  res_sf <- build_sf(source_sf, nearest_target_dist, nearest_target_time, target_df)
}
