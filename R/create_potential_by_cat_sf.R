#' @title Calculate distance or time weighted potential by category
#'
#' @description Creates sf of geometry type point with a weighted value
#'     of features belonging to a specific category that match the applied time
#'     or distance filter
#'
#' @param odm_object of type list encompassing a duration and a distance
#'     matrix, the source and target locations. Created by using either
#'     \code{calc_odm} or \code{calc_odm_multicore}
#' @param filter_value_type A string, "time" or "distance"
#' @param accessibility_filter_value A numeric value of minutes or meters
#' @param search_direction A string, "to_targets" or "from_targets"
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#' @param ors_profile Route profile, e.g. \code{"foot-walking"} or
#'     \code{"driving-car"}
#'
#' @return sf object of geometry type point
#' @examples
#' data(testdata)
#' od_result <- testdata$od_result
#' output_sf <- create_potential_by_cat_sf(
#'   odm_object = od_result,
#'   filter_value_type = "distance",
#'   accessibility_filter_value = 750,
#'   search_direction = "to_target",
#'   filter_attribute = "category",
#'   filter_value = "A",
#'   ors_profile = "foot-walking"
#' )
#' @seealso \code{calc_odm()} or \code{calc_odm_multicore()} for odm_object
#'     creation and \code{create_potential_sf()} to create a weighted value
#'     for all features up to a threshold distance or time value
#' @export
#'
create_potential_by_cat_sf <- function(odm_object,
                                       filter_value_type,
                                       accessibility_filter_value,
                                       search_direction,
                                       filter_attribute,
                                       filter_value,
                                       ors_profile) {
  source_sf <- odm_object$sources
  target_df <- odm_object$targets
  if (filter_value_type == "time") {
    target_pot_df <-
      filter_by_time_cat_pot(
        odm_object, accessibility_filter_value,
        search_direction, target_df, filter_attribute,
        filter_value, ors_profile
      )
  }
  else {
    target_pot_df <-
      filter_by_distance_cat_pot(
        odm_object, accessibility_filter_value,
        search_direction, target_df, filter_attribute,
        filter_value, ors_profile
      )
  }
  if (search_direction == "to_target") {
    format_pot_out_to_target_sf(source_sf, target_pot_df)
  }
  else {
    format_pot_out_from_target_sf(target_df, target_pot_df)
  }
}
