#' filter_by_distance_cat_cum
#'
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param distance_value A numeric value of meters
#' @param search_direction A character string, "to_target" or "from_target"
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#'
#' @return A tibble with a count of sources for each target id for all features
#' matching the applied filters
#' @noRd
#'
filter_by_distance_cat_cum <- function(odm_object, distance_value,
                                       search_direction, target_df,
                                       filter_attribute, filter_value) {
  if (search_direction == "to_target") {
    x <- odm_object[["distance"]] %>%
      to_target_by_cat(
        odm_object, distance_value, target_df,
        filter_attribute, filter_value
      )
  }
  else {
    x <- odm_object[["distance"]] %>%
      from_target_by_cat(
        odm_object, distance_value, target_df,
        filter_attribute, filter_value
      )
  }
}
