#' format_results
#'
#' @param matrix_object A time or distance matrix
#'
#' @return A tibble
#' @noRd

#'
format_results <- function(matrix_object) {
  x <- matrix_object %>%
    tibble::as_tibble(.data, rownames = NA) %>%
    tibble::rownames_to_column(.data, "ID") %>%
    dplyr::mutate(ID = as.numeric(.data$ID)) %>%
    tidyr::pivot_longer(-.data$ID, names_to = "target_id", values_to = "value")
}
