#' apply_driving_car_decay_distance
#'
#' @param distance_value A numeric value: meters
#'
#' @return A numeric value
#' @export
#'
apply_driving_car_decay_distance <- function(distance_value) {
  a <- 0
  b <- 100
  a + (b - a) * (exp(-0.00008 * distance_value))
}
