#' average_n_min_values
#'
#' @param min_values_df A tibble with n minimum distances or durations for each
#' feature
#' @param n_vals An integer defining the number of minimum values to be
#' incorporated
#'
#' @return A tibble including a new column of average distances or durations for
#' each feature
#' @noRd
#' @importFrom rlang .data
#'
average_n_min_values <- function(min_values_df, n_vals) {
  select_cols <- c((n_vals + 2):(length(min_values_df)))
  dst_mat <- min_values_df %>%
    dplyr::mutate(MeanVal = rowMeans(
      dplyr::select(.data, dplyr::all_of(select_cols))
    ))
}
