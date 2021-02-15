#' rep_source_coords
#'
#' @param source_coords_base List of longitude, latitude coordinate pairs
#' @param trgt_split_list_len An integer value to signal the number of list
#'     elements
#' @param max_chunk_size An integer value defining the maximum number of values
#'     per chunk
#'
#' @return A list of lists with longitude, latitude coordinate pairs repeated
#'     \code{trgt_split_list_len} times
#' @noRd
#'
rep_source_coords <- function(source_coords_base,
                              trgt_split_list_len,
                              max_chunk_size) {
  len <- length(source_coords_base)
  source_coords_split <- split(source_coords_base,
                               rep(1:ceiling(len/max_chunk_size),
                                   each=max_chunk_size)[1:len])
  source_coords_split_rep <- rep(source_coords_split, trgt_split_list_len)
  stats::setNames(source_coords_split_rep,
           c(1:length(source_coords_split_rep)))
}
