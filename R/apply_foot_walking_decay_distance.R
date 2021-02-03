#' apply_foot_walking_decay_distance
#'
#' @param distance_value time_value A numeric value: meters
#'
#' @return A numeric value
#' @export
#'
apply_foot_walking_decay_distance <- function(distance_value) {
  a <- 103.09064080697681
  b <- 9.6418791247770663
  c <- 4.4194249202824070
  d <- 18.571799184028070
  f <- -20.125818369784888
  a * exp(-0.5 * ((log((distance_value - f) / b) / c)^d))
}
