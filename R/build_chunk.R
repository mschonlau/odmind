#' build_chunk
#'
#' @param coord_list A list of x-y-coordinates
#' @param max_chunk_size An integer value defining the maximum chunk size
#'
#' @return A list
#' @noRd
build_chunk <- function(coord_list, max_chunk_size) {
  coord_list_len <- length(coord_list)
  if (coord_list_len <= max_chunk_size) {
    start <- 1
    end <- coord_list_len
  }
  if (coord_list_len %% max_chunk_size == 0) {
    start <- seq(1, coord_list_len, max_chunk_size)
    end <- seq(max_chunk_size, coord_list_len, max_chunk_size)
  }
  if (coord_list_len > max_chunk_size) {
    start <- seq(1, coord_list_len, max_chunk_size)
    end <- seq(max_chunk_size, coord_list_len, max_chunk_size) %>%
      append(coord_list_len) %>% unlist()
  }
  list(start = start, end = end)
}
