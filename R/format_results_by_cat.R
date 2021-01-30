#' format_results_by_cat
#'
#' @param matrix_object A time or distance matrix
#' @param target_df A dataframe containing the targets
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#'
#' @return A tibble
#' @export
#'

format_results_by_cat <- function(matrix_object, target_df, filter_attribute, filter_value) {
  filtered_matrix <- filterMatrixResults(matrix_object, target_df, filter_attribute, filter_value)
  x <- filtered_matrix %>%
    tibble::as_tibble(., rownames=NA) %>%
    tibble::rownames_to_column(., "ID") %>%
    dplyr::mutate(ID = as.numeric(ID)) %>%
    tidyr::pivot_longer(-ID, names_to="target_id", values_to = "value")
}
