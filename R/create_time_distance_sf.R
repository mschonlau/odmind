#' @title Calculate closest distance and duration
#'
#' @description Creates sf of geometry type point for each source feature with
#'     the minimum distance and duration values to the nearest target feature.
#'
#' @param odm_object of type list encompassing a duration and a distance
#'     matrix, the source and target locations. Created by using either
#'     \code{calc_odm} or \code{calc_odm_multicore}
#'
#' @return sf object of geometry type point
#' @examples
#' data(testdata)
#' od_result <- testdata$od_result
#' output_sf <- create_time_distance_sf(odm_object = od_result)
#' @seealso \code{calc_odm()} or \code{calc_odm_multicore()} for odm_object
#'     creation and \code{create_time_distance_n_sf} to calculate the n nearest
#'     target locations
#' @export
#' @importFrom dplyr "%>%"

create_time_distance_sf <- function(odm_object) {
  nearest_target_dist <- identify_nearest_target(odm_object, "distance")
  nearest_target_time <- identify_nearest_target(odm_object, "duration")
  source_sf <- odm_object$sources
  target_df <- odm_object$targets
  build_sf(source_sf, nearest_target_dist, nearest_target_time, target_df)
}
