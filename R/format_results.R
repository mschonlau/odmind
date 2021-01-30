#' format_results
#'
#' @param matrix_object A time or distance matrix
#'
#' @return A tibble
#' @export
#'
format_results <- function(matrix_object) {
  x <- matrix_object %>%
    tibble::as_tibble(., rownames=NA) %>%
    tibble::rownames_to_column(., "ID") %>%
    dplyr::mutate(ID = as.numeric(ID)) %>%
    tidyr::pivot_longer(-ID, names_to="target_id", values_to = "value")
}
