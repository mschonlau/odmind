#' weight_targets_by_time
#'
#' @param data A tibble
#' @param ors_profile Route profile
#'
#' @return A tibble with count values weighted by time
#' @noRd
#'
weight_targets_by_time <- function(data, ors_profile) {
  if (ors_profile == "foot-walking") {
    x <- data %>%
      dplyr::group_by(dplyr::across(1)) %>%
      dplyr::mutate(value_w = apply_foot_walking_decay_time(.data$value)) %>%
      dplyr::mutate(value_w = dplyr::case_when(
        .data$value_w > 100 ~ 100,
        TRUE ~ .data$value_w
      )) %>%
      dplyr::summarise(target_pot = sum(.data$value_w))
  }
  else {
    x <- data %>%
      dplyr::group_by(dplyr::across(1)) %>%
      dplyr::mutate(value_w = apply_driving_car_decay_time(.data$value)) %>%
      dplyr::mutate(value_w = dplyr::case_when(
        .data$value > 30 ~ 0,
        TRUE ~ .data$value_w
      )) %>%
      dplyr::summarise(target_pot = sum(.data$value_w))
  }
}
