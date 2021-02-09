#' @title create_cumulative_sf
#'
#' @description Creates sf of geometry type point with a count of features
#'     that match the applied time or distance filter
#'
#' @param odm_object  of type list encompassing a duration and a distance
#'     matrix, the source and target locations. Created by using either
#'     \code{calc_odm} or \code{calc_odm_multicore}
#' @param filter_value_type A string, "time" or "distance"
#' @param accessibility_filter_value A numeric value of minutes or meters
#' @param search_direction A string, "to_target" or "from_target"
#'
#' @return sf object of geometry type point
#' @examples
#' data(testdata)
#' od_result <- testdata$od_result
#' output_sf <- create_cumulative_sf(odm_object = od_result,
#'                                   filter_value_type = "distance",
#'                                   accessibility_filter_value = 750,
#'                                   search_direction = "to_target")
#' @seealso \code{calc_odm()} or \code{calc_odm_multicore()} for odm_object
#'     creation and \code{create_cumulative_by_cat_sf} to count features of a
#'     specific category up to a threshold distance or time
#' @export
#' @importFrom dplyr "%>%"

create_cumulative_sf <- function(odm_object, filter_value_type,
                                 accessibility_filter_value,
                                 search_direction) {
  source_sf <- odm_object$sources
  target_df <- odm_object$targets
  if (filter_value_type == "time") {
    target_cnt_df <- filter_by_time_cum(
      odm_object,
      accessibility_filter_value,
      search_direction
    )
  }
  else {
    target_cnt_df <- filter_by_distance_cum(
      odm_object,
      accessibility_filter_value,
      search_direction
    )
  }
  if (search_direction == "to_target") {
    format_cum_out_to_target_sf(source_sf, target_cnt_df)
  }
  else {
    format_cum_out_from_target_sf(target_df, target_cnt_df)
  }
}
