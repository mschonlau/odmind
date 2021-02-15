#' get_split_list_length
#'
#' @param input_list List of longitude, latitude coordinate pairs
#' @param max_chunk_size integer value defining the maximum number of values
#'     per chunk
#'
#' @return An integer value
#' @noRd
#'
get_split_list_length <- function(input_list, max_chunk_size) {
  ceiling(length(input_list) / max_chunk_size)
}
