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
#' @noRd
#'
build_n_sf <- function(source_sf, nearest_target_dist,
                       nearest_target_time, target_df, n) {
  res_sf <- source_sf %>%
    dplyr::left_join(nearest_target_dist,
      by = c("source_id" = "source_id")
    ) %>%
    dplyr::rename(MeanDist = .data$MeanVal) %>%
    dplyr::rename_with(
      ~ paste0("MinDist", sub("Min_Value_*", "_", .)),
      dplyr::starts_with("Min_Value")
    ) %>%
    dplyr::select(
      .data$source_id, .data$MeanDist,
      dplyr::contains("MinDist")
    ) %>%
    dplyr::left_join(nearest_target_time,
      by = c("source_id" = "source_id")
    ) %>%
    dplyr::rename(MeanTime = .data$MeanVal) %>%
    dplyr::rename_with(
      ~ paste0("MinTime", sub("Min_Value_*", "_", .)),
      dplyr::starts_with("Min_Value")
    ) %>%
    dplyr::select(
      .data$source_id, .data$MeanDist, .data$MeanTime,
      dplyr::contains("target_id"), dplyr::contains("Min")
    )

  df_list <- replicate(n, target_df, simplify = FALSE)
  df_list <- lapply(1:n, function(i) {
    df <- df_list[[i]]
    names(df) <- paste(names(df), i, sep = "_")
    df
  })
  purrr::reduce(df_list, dplyr::left_join, .init = res_sf) %>%
    sf::st_set_crs(4326)
}
