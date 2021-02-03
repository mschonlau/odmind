#' build_sf
#'
#' @param source_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param nearest_target_dist A tibble with the minimum distance
#' @param nearest_target_time A tibble with the minimum duration
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#'
#' @return sf object of geometry type point
#' @export
#'
build_sf <- function(source_sf, nearest_target_dist,
                     nearest_target_time, target_df) {
  res_sf <- source_sf %>%
    dplyr::left_join(.data, nearest_target_dist,
      by = c("source_id" = "source_id_")
    ) %>%
    dplyr::rename(Min_Dist = .data$Min_Value) %>%
    dplyr::select(.data$source_id, .data$Min_Dist) %>%
    dplyr::left_join(.data, nearest_target_time,
      by = c("source_id" = "source_id_")
    ) %>%
    dplyr::rename(Min_Time = .data$Min_Value) %>%
    dplyr::left_join(.data, target_df,
      by = c("target_id_" = "target_id")
    ) %>%
    dplyr::rename(target_id = .data$target_id_)
}
