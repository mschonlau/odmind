#' get_min_values
#'
#' @param matrix_data Distance or duration matrix
#'
#' @return A tibble with the minimum distance or duration for each feature
#' @export
get_min_values <- function(matrix_data) {
  dst_mat <- t(sapply(seq(nrow(matrix_data)), function(i) {
    j <- which.min(matrix_data[i,])
    c(paste(rownames(matrix_data)[i], colnames(matrix_data)[j], sep='/'), matrix_data[i,j])})) %>%
    tibble::as_tibble(., .name_repair = "unique") %>%
    dplyr::rename(., Min_ValueIDs = ...1, Min_Value = ...2) %>%
    tidyr::separate(., Min_ValueIDs, c("source_id_", "target_id_"), sep = "/") %>%
    dplyr::mutate(across(where(is.character), as.numeric))
}
