#' @title calc_odm (single core)
#'
#' @description Looped calculation of duration and distance matrices between all
#' sources and targets (single core)
#'
#' @param profile_string Route profile
#' @param source_locations sf object of geometry type point containing the
#' sources with coordinates in separate x, y columns
#' @param target_locations data.frame containing the sources with coordinates
#' in separate x, y columns
#' @param max_chunk_size integer value defining the maximum number of source
#' to target connections to be processed per loop
#'
#' @return odm-object of type list encompassing duration and distance matrices
#' and the source and target locations
#' @export
#'
calc_odm <- function(profile_string, source_locations, target_locations, max_chunk_size) {
  start_time <- Sys.time()
  cat("\n",paste0("Start time: ", start_time), "\n")
  n_rows <- as.numeric(nrow(source_locations))
  n_cols <-  as.numeric(nrow(target_locations))
  matrix_template <-  matrix(NA, nrow = n_rows, ncol = n_cols)
  mat <- list(duration = matrix_template,
              distance = matrix_template,
              sources = source_locations,
              targets = target_locations)
  src_locations <- get_coords_as_list(source_locations)
  dst_locations <- get_coords_as_list(target_locations)
  chunks_src <- build_chunk(src_locations, max_chunk_size)
  chunks_dst <- build_chunk(dst_locations, max_chunk_size)
  i <- 0
  pb <- txtProgressBar(min = i, max = length(chunks_src$start), style = 3)
  for (i in seq(1, length(chunks_src$start), 1)) {
    setTxtProgressBar(pb, i)
    src_location_chunk <- src_locations[chunks_src$start[i]:chunks_src$end[i]]
    src_chunk_size <- length(src_location_chunk)
    for (j in seq(1, length(chunks_dst$start), 1)) {
      dst_location_chunk <- dst_locations[chunks_dst$start[j]:chunks_dst$end[j]]
      dst_chunk_size <- length(dst_location_chunk)
      coordinates <- c(src_location_chunk, dst_location_chunk)
      res <- call_ors_matrix(coordinates, profile_string, src_chunk_size, dst_chunk_size)
      mat[["duration"]][chunks_src$start[i]:chunks_src$end[i], chunks_dst$start[j]:chunks_dst$end[j]] <- res$durations / 60
      mat[["distance"]][chunks_src$start[i]:chunks_src$end[i], chunks_dst$start[j]:chunks_dst$end[j]] <- res$distances
    }
    if (i == length(chunks_src$start)) {
      cat("\n","Done!", "\n")}
  }
  cat(paste0(" Duration: ", Sys.time() - start_time), "\n")
  return(mat)
}
