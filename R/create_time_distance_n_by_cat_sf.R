#' @title create_time_distance_n_by_cat_sf
#'
#' @description Create sf object of geometry type point with n minimum distance
#' and duration values for each source to target combination that matches the
#' applied category filter
#'
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param source_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#' @param n An integer defining the number of minimum values to be
#' incorporated
#'
#' @return sf object of geometry type point
#' @export
#'
create_time_distance_n_by_cat_sf <- function(odm_object, source_sf, target_df,
                                             filter_attribute, filter_value,
                                             n) {
  nearest_target_dist <-
    identify_n_nearest_targets_by_cat(
      odm_object, "distance", target_df,
      filter_attribute, filter_value, n
    )
  nearest_target_time <-
    identify_n_nearest_targets_by_cat(
      odm_object, "duration", target_df,
      filter_attribute, filter_value, n
    )
  build_n_sf(source_sf, nearest_target_dist, nearest_target_time,target_df, n)
}
