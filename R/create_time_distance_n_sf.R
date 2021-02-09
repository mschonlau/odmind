#' @title create_time_distance_n_sf
#'
#' @description Creates sf of geometry type point for each source feature with
#'     the minimum distance and duration values to n nearest target features.
#'
#' @param odm_object  of type list encompassing a duration and a distance
#'     matrix, the source and target locations. Created by using either
#'     \code{calc_odm} or \code{calc_odm_multicore}
#' @param n An integer defining the number of minimum values to be
#'     incorporated
#'
#' @return sf object of geometry type point
#' @examples
#' data(testdata)
#' od_result <- testdata$od_result
#' # Use e.g. n = 3
#' output_sf <- create_time_distance_n_sf(odm_object = od_result, n = 3)
#' @seealso \code{calc_odm()} or \code{calc_odm_multicore()} for odm_object
#'     creation and \code{create_time_distance_sf()} to calculate only the
#'     nearest target location
#' @export
#'
create_time_distance_n_sf <- function(odm_object, n) {
  nearest_target_dist <- identify_n_nearest_targets(odm_object, "distance", n)
  nearest_target_time <- identify_n_nearest_targets(odm_object, "duration", n)
  source_sf <- odm_object$sources
  target_df <- odm_object$targets
  build_n_sf(source_sf, nearest_target_dist, nearest_target_time, target_df, n)
}
