#' @title create_potential_sf
#'
#' @description Creates sf object of geometry type point with a weighted value
#' of sources for each target id for all features matching the applied filters
#'
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param source_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param filter_value_type A string, "time" or "distance"
#' @param accessibility_filter_value A numeric value of minutes or meters
#' @param search_direction A string, "to_targets" or "from_targets"
#' @param ors_profile Route profile
#'
#' @return sf object of geometry type point
#' @export
#' @importFrom dplyr "%>%"
create_potential_sf <- function(odm_object, source_sf, target_df, filter_value_type, accessibility_filter_value, search_direction = "toTarget", ors_profile) {
  if (filter_value_type == "time") {
    target_pot_df <- filter_by_time_pot(odm_object, accessibility_filter_value, search_direction, ors_profile)
    res_sf <- format_pot_out_to_target_sf(source_sf, target_pot_df)
  }
  else {
    target_pot_df <- filter_by_distance_pot(odm_object, accessibility_filter_value, search_direction, ors_profile)
    res_sf <- format_pot_out_from_target_sf(target_df, target_pot_df)
  }
}
