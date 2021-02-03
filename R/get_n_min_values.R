#' get_n_min_values
#'
#' @param matrix_data Distance or duration matrix
#' @param n_vals An integer defining the number of minimum values to be
#' extracted
#'
#' @return A tibble with n minimum distances or durations for each feature
#' @export
#'
get_n_min_values <- function(matrix_data, n_vals) {
  sources_id_col <- n_vals + 1
  targets_id_cols <- seq((2 + n_vals), (3 * n_vals), 2)
  value_cols <- seq(1, n_vals)
  value_col_names <- paste("Min_Value", seq(1:n_vals), sep = "_")
  poi_col_names <- paste("target_id", seq(1:n_vals), sep = "_")

  dst_mat <- t(sapply(seq(nrow(matrix_data)), function(i) {
    j <- min_n(matrix_data[i, ], n_vals)
    c(
      paste(rownames(matrix_data)[i], colnames(matrix_data)[j], sep = "/"),
      matrix_data[i, j]
    )
  })) %>%
    tibble::as_tibble(.data) %>%
    splitstackshape::cSplit(.data, names(.data)[1:n_vals], "/") %>%
    dplyr::rename_at(
      dplyr::vars(
        dplyr::all_of(c(value_cols, sources_id_col, targets_id_cols))
      ),
      ~ c(value_col_names, "source_id", poi_col_names)
    ) %>%
    dplyr::select(
      dplyr::all_of(c(sources_id_col, targets_id_cols, value_cols))
    ) %>%
    dplyr::mutate(dplyr::across(where(is.integer), as.numeric)) %>%
    dplyr::mutate(dplyr::across(where(is.character), as.numeric))
  dst_mat
}
utils::globalVariables(c("where"))
