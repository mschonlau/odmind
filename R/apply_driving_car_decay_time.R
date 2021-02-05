#' apply_driving_car_decay_time
#'
#' @param time_value A numeric value: minutes
#'
#' @return A numeric value
#' @noRd
#'
apply_driving_car_decay_time <- function(time_value) {
  a <- 0
  b <- 100
  a + (b - a) * (exp(-0.05 * time_value))
}
