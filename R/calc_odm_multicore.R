#' @title calc_odm (multicore)
#'
#' @description Looped calculation of duration and distance matrices between all
#' sources and targets (multicore)
#'
#' @param profile_string Route profile
#' @param source_locations sf object of geometry type point containing the
#' sources with coordinates in separate x, y columns
#' @param target_locations data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param max_chunk_size integer value defining the maximum number of source
#' to target connections to be processed per loop
#' @param ors_url the url of the openrouteservice instance to be used for
#' processing
#'
#' @return odm-object of type list encompassing duration and distance matrices
#' and the source and target locations
#' @export
#' @importFrom foreach %:% %dopar%
calc_odm_multicore <- function(profile_string, source_locations,
                               target_locations, max_chunk_size, ors_url) {
  start_time <- Sys.time()
  cat("\n", paste0("Start time: ", start_time), "\n")
  n_rows <- as.numeric(nrow(source_locations))
  n_cols <- as.numeric(nrow(target_locations))
  distance_template <- bigstatsr::FBM(nrow = n_rows, ncol = n_cols)
  duration_template <- bigstatsr::FBM(nrow = n_rows, ncol = n_cols)
  mat <- list(
    distance = distance_template,
    duration = duration_template,
    sources = source_locations,
    targets = target_locations
  )
  src_locations <- get_coords_as_list(source_locations)
  dst_locations <- get_coords_as_list(target_locations)
  chunks_src <- build_chunk(src_locations, max_chunk_size)
  chunks_dst <- build_chunk(dst_locations, max_chunk_size)
  max_loops <- length(chunks_src$start) * length(chunks_dst$start)
  pb <- utils::txtProgressBar(max = max_loops, style = 3)
  progress <- function(n) {
    utils::setTxtProgressBar(pb, n)
  }
  i <- 1
  j <- 1
  opts <- list(progress = progress, ors_url = ors_url)
  tmp <- foreach::foreach(
    i = seq(1, length(chunks_src$start), 1),
    .combine = cbind, .packages = "openrouteservice", .options.snow = opts
  ) %:%
    foreach::foreach(
      j = seq(1, length(chunks_dst$start), 1),
      .combine = c
    ) %dopar% {
      options(openrouteservice.url = opts[["ors_url"]])
      src_location_chunk <- src_locations[chunks_src$start[i]:chunks_src$end[i]]
      src_chunk_size <- length(src_location_chunk)
      dst_location_chunk <- dst_locations[chunks_dst$start[j]:chunks_dst$end[j]]
      dst_chunk_size <- length(dst_location_chunk)
      coordinates <- c(src_location_chunk, dst_location_chunk)
      res <- call_ors_matrix(
        coordinates, profile_string,
        src_chunk_size, dst_chunk_size
      )
      mat[["distance"]][
        chunks_src$start[i]:chunks_src$end[i],
        chunks_dst$start[j]:chunks_dst$end[j]
        ] <- res$distances
      mat[["duration"]][
        chunks_src$start[i]:chunks_src$end[i],
        chunks_dst$start[j]:chunks_dst$end[j]
        ] <- res$durations / 60
      NULL
    }
  close(pb)
  mat$distance <- mat$distance[]
  mat$duration <- mat$duration[]
  cat("\n", "Done!", "\n")
  cat(paste0(" Duration: ", Sys.time() - start_time), "\n")
  return(mat)
}
