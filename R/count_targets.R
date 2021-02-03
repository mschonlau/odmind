#' count_targets
#'
#' @param data A tibble
#'
#' @return A tibble with a count of targets for each id
#' @export
#'
count_targets <- function(data) {
  x <- data %>%
    dplyr::group_by(dplyr::across(1)) %>%
    dplyr::summarise(target_cnt = dplyr::n(), .groups = "drop")
}
