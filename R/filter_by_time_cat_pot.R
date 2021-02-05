#' filter_by_time_cat_pot
#'
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_value A numeric value of minutes
#' @param search_direction A character string, "to_target" or "from_target"
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#' @param ors_profile Route profile
#'
#' @return A tibble with a weighted value of sources for each target id for all
#' features matching the applied filters
#' @noRd
#'
filter_by_time_cat_pot <- function(odm_object, time_value, search_direction,
                                   target_df, filter_attribute, filter_value,
                                   ors_profile) {
  if (search_direction == "to_target") {
    x <- odm_object[["duration"]] %>%
      to_target_by_cat_time_weighted(
        .data, odm_object, time_value, target_df,
        filter_attribute, filter_value,
        ors_profile
      )
  }
  else {
    x <- odm_object[["duration"]] %>%
      from_target_by_cat_time_weighted(
        .data, odm_object, time_value, target_df,
        filter_attribute, filter_value,
        ors_profile
      )
  }
}
