#' @title create_time_distance_n_by_cat_sf
#'
#' @description Creates sf of geometry type point for each source feature with
#'     the minimum distance and duration values to n nearest target features
#'     which match the applied category filter
#'
#' @param odm_object  of type list encompassing a duration and a distance
#'     matrix, the source and target locations. Created by using either
#'     \code{calc_odm} or \code{calc_odm_multicore}
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#' @param n An integer defining the number of minimum values to be
#' incorporated
#'
#' @return sf object of geometry type point
#' @examples
#' data(testdata)
#' od_result <- testdata$od_result
#' output_sf <- create_time_distance_n_by_cat_sf(
#'   odm_object = od_result,
#'   filter_attribute = "category", filter_value = "A", n = 3
#' )
#' @seealso \code{calc_odm()} or \code{calc_odm_multicore()} for odm_object
#'     creation and \code{create_time_distance_by_cat_sf} to calculate only
#'     the nearest target location for a specific category
#' @export
#'
create_time_distance_n_by_cat_sf <- function(odm_object, filter_attribute,
                                             filter_value, n) {
  source_sf <- odm_object$sources
  target_df <- odm_object$targets
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
  build_n_sf(source_sf, nearest_target_dist, nearest_target_time, target_df, n)
}
