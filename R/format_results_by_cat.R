#' format_results_by_cat
#'
#' @param matrix_object A time or distance matrix
#' @param target_df A dataframe containing the targets
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#' @param search_direction A character string, "to_target" or "from_target"
#' @return A tibble
#' @noRd
#'

format_results_by_cat <- function(matrix_object, target_df,
                                  filter_attribute, filter_value,
                                  search_direction) {
  filtered_matrix <- filter_odm(
    matrix_object, target_df,
    filter_attribute, filter_value, search_direction
  )
  x <- filtered_matrix %>%
    tibble::as_tibble(rownames = NA) %>%
    tibble::rownames_to_column("ID") %>%
    dplyr::mutate(ID = as.numeric(.data$ID)) %>%
    tidyr::pivot_longer(-.data$ID,
                        names_to = "target_id",
                        values_to = "value")
}
