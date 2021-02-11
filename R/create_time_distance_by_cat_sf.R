#' @title  Calculate closest distance and duration by category
#'
#' @description Creates sf of geometry type point for each source feature with
#'     the minimum distance and duration values to the nearest target feature
#'     which matches the applied category filter
#'
#' @param odm_object  of type list encompassing a duration and a distance
#'     matrix, the source and target locations. Created by using either
#'     \code{calc_odm} or \code{calc_odm_multicore}
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#'
#' @return sf object of geometry type point
#' @examples
#' data(testdata)
#' od_result <- testdata$od_result
#' output_sf <- create_time_distance_by_cat_sf(
#'   odm_object = od_result,
#'   filter_attribute = "category", filter_value = "A"
#' )
#' @seealso \code{calc_odm()} or \code{calc_odm_multicore()} for odm_object
#'     creation and \code{create_time_distance_n_by_ca_sf} to calculate the n
#'     nearest target locations for a specific category
#' @export
#'
create_time_distance_by_cat_sf <- function(odm_object,
                                           filter_attribute,
                                           filter_value) {
  source_sf <- odm_object$sources
  target_df <- odm_object$targets
  nearest_target_dist <-
    identify_nearest_target_by_cat(
      odm_object, "distance", target_df,
      filter_attribute, filter_value
    )
  nearest_target_time <-
    identify_nearest_target_by_cat(
      odm_object, "duration", target_df,
      filter_attribute, filter_value
    )
  build_sf(source_sf, nearest_target_dist, nearest_target_time, target_df)
}
