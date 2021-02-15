#' calc_matrix_multicore
#'
#' @param profile_string  Route profile
#' @param src_coords A list of lists with longitude, latitude coordinate pairs
#'     repeated \code{trgt_split_list_len} times
#' @param trgt_coords A list of lists with longitude, latitude coordinate pairs
#'     repeated \code{src_split_list_len} times
#' @param n_loops An integer value that depends on the length of list
#' @param ors_url url of the openrouteservice server to be used for processing
#'
#' @return A list including multiple distance and duration matrices
#' @noRd
#' @importFrom foreach %:% %dopar%
#'
calc_matrix_multicore <- function(profile_string, src_coords, trgt_coords,
                                  n_loops, ors_url) {
  start_time <- Sys.time()
  cat("\n", paste0("Start time: ", start_time), "\n")
  p <- progressr::progressor(along = n_loops)
  res <- foreach::foreach(x = n_loops) %dopar% {
    p()
    src_chunk_size <- length(src_coords[[x]])
    dst_chunk_size <- length(trgt_coords[[x]])
    coords <- c(src_coords[[x]], trgt_coords[[x]])
    tmp <- call_ors_matrix_multicore(coords, profile_string,
                                             src_chunk_size,
                                             dst_chunk_size, ors_url)
    tmp
  }
  cat("\n", "Done!", "\n")
  cat(paste0(" Duration: ", difftime(Sys.time(), start_time, units='mins'),
             " minutes"), "\n")
  res
}
utils::globalVariables(c("x"))
