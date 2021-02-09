#' filter_odm
#'
#' @param matrix_data Distance or duration matrix
#' @param target_df data.frame containing the sources with coordinates
#' in separate x, y columns
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#' @param search_direction A character string, "to_target" or "from_target"
#'
#' @return A matrix including only features matching the applied filter
#' @noRd
#'
filter_odm <- function(matrix_data, target_df, filter_attribute, filter_value,
                       search_direction) {
  ids <- target_df %>%
    dplyr::filter(.data[[filter_attribute]] == filter_value) %>%
    dplyr::select(1) %>%
    dplyr::pull(1)

  if (search_direction == "to_target") {
    subset(matrix_data, select = ids)
  }
  else {
    matrix_data[ids, ]
  }
}
