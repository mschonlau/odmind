#' get_calc_coords
#'
#' @param sources sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param targets data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param max_chunk_size An integer value defining the maximum number of values
#'     per chunk
#'
#' @return A list
#' @noRd
#'

get_calc_coords <- function(sources, targets, max_chunk_size) {
  src_coords_base <- get_coords_as_list(sources)
  src_split_list_len <- get_split_list_length(src_coords_base, max_chunk_size)
  trgt_coords_base <- get_coords_as_list(targets)
  trgt_split_list_len <- get_split_list_length(trgt_coords_base, max_chunk_size)

  src_coords <- rep_source_coords(src_coords_base, trgt_split_list_len, max_chunk_size)
  trgt_coords <- rep_target_coords(trgt_coords_base, src_split_list_len, max_chunk_size)

  list(src_coords, trgt_coords, src_split_list_len, trgt_split_list_len)
}
