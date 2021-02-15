#' rep_target_coords
#'
#' @param target_coords_base List of longitude, latitude coordinate pairs
#' @param src_split_list_len An integer value to signal the number of list
#'     elements
#' @param max_chunk_size An integer value defining the maximum number of values
#'     per chunk
#'
#' @return A list of lists with longitude, latitude coordinate pairs repeated
#'     \code{src_split_list_len} times
#' @noRd
#'
rep_target_coords <- function(target_coords_base,
                              src_split_list_len,
                              max_chunk_size) {
  len <- length(target_coords_base)
  target_coords_split <- split(target_coords_base,
                               rep(1:ceiling(len/max_chunk_size),
                                   each=max_chunk_size)[1:len])
  target_coords_split_rep <- rep(target_coords_split, src_split_list_len)
  sorting <- sort(as.numeric(names(target_coords_split_rep)))
  target_coords_split_sorted <- target_coords_split_rep[as.character(sorting)]
  stats::setNames(target_coords_split_sorted,
                  c(1:length(target_coords_split_sorted)))
}
