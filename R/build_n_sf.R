#' build_n_sf
#'
#' @param source_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param nearest_target_dist A tibble with n minimum distances and the average
#' distance for each feature
#' @param nearest_target_time A tibble with n minimum durations and the average
#' duration for each feature
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param n An integer defining the number of minimum values to be
#' incorporated
#'
#' @return sf object of geometry type point
#' @export
#'
build_n_sf <- function(source_sf, nearest_target_dist, nearest_target_time, target_df, n) {
  res_sf <- source_sf %>%
    dplyr::left_join(., nearest_target_dist, by=c("source_id" = "source_id")) %>%
    dplyr::rename(MeanDist = MeanVal) %>%
    dplyr::rename_with(~paste0("MinDist", sub("Min_Value_*", "_", .)),
                       starts_with('Min_Value')) %>%
    dplyr::select(source_id, MeanDist, contains("MinDist")) %>%
    dplyr::left_join(., nearest_target_time, by=c("source_id" = "source_id")) %>%
    dplyr::rename(MeanTime = MeanVal) %>%
    dplyr::rename_with(~paste0("MinTime", sub("Min_Value_*", "_", .)),
                       starts_with('Min_Value')) %>%
    dplyr::select(source_id, MeanDist, MeanTime, contains("target_id"), contains("Min"))

  df_list <- replicate(n, target_df, simplify = F)
  df_list <- lapply(1:n, function(i) {
    df <- df_list[[i]]
    names(df) <- paste(names(df), i, sep="_")
    df
  })
  out_sf <- purrr::reduce(df_list, left_join, .init = res_sf)
}
