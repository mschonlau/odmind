#' build_odm
#'
#' @param tmp_resultlist A list including multiple distance and duration
#'     matrices
#' @param sources sf object of geometry type point containing the
#' sources with coordinates in separate x, y columns
#' @param targets data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param split_source_list_len An integer value to signal the number of source
#'     list elements
#' @param split_target_list_len An integer value to signal the number of target
#'     list elements
#'
#' @return odm-object of type list encompassing duration and distance matrices
#' and the source and target locations
#' @noRd
#'
build_odm <- function(tmp_resultlist, sources, targets, split_source_list_len,
                      split_target_list_len) {
  start_indices <- seq(1,
                       split_source_list_len * split_target_list_len,
                       split_source_list_len)
  end_indices <- seq(split_source_list_len,
                     split_source_list_len * split_target_list_len,
                     split_source_list_len)
  n_rows <- as.numeric(nrow(sources))
  n_cols <- as.numeric(nrow(targets))
  matrix_template <- matrix(NA, nrow = n_rows, ncol = n_cols)
  mat <- list(
    distance = matrix_template,
    duration = matrix_template
  )
  mat[["distance"]] <- lapply(1:length(start_indices), function(i) {
    start <- start_indices[i]
    end <- end_indices[i]
    tmp <- do.call("rbind", lapply(start:end, function(x) {
      tmp_resultlist[[x]]$distances
    }))
    tmp
  })
  mat[["duration"]] <- lapply(1:length(start_indices), function(i) {
    start <- start_indices[i]
    end <- end_indices[i]
    tmp <- do.call("rbind", lapply(start:end, function(x) {
      tmp_resultlist[[x]]$durations / 60
    }))
    tmp
  })
  mat[["distance"]] <- do.call(cbind, mat[["distance"]])
  mat[["duration"]] <- do.call(cbind, mat[["duration"]])
  mat[["sources"]] <- sources
  mat[["targets"]] <- targets
  mat
}
