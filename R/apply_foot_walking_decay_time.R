#' apply_foot_walking_decay_time
#'
#' @param time_value A numeric value: minutes
#'
#' @return A numeric value
#' @export
#'
apply_foot_walking_decay_time <- function(time_value) {
  a = 100.62568265923002
  b = 0.007929473546366426
  c = -0.42099709805127999
  y = a / (1.0 + b * exp(-1.0 * c * time_value))
}
