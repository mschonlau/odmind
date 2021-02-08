#' @title switch_names
#'
#' @description Generate unique ids for sources and targets and move them to
#' the first column index position
#'
#' @param out_mat A duration or distance matrix object
#' @param odm_object A list object containing a duration and a distance matrix
#' object, the sources and targets
#' @param search_direction A character string, "to_target" or "from_target"
#'
#' @return A matrix object with corresponding ids for sources and targets
#'
#' @noRd
#'
switch_names <- function(out_mat, odm_object, search_direction) {
  if (!"source_id" %in% colnames(odm_object$sources)) {
    odm_object$sources <- odm_object$sources %>%
      dplyr::mutate(source_id = dplyr::row_number()) %>%
      dplyr::relocate(.data$source_id)
  }
  if (!"target_id" %in% colnames(odm_object$targets)) {
    odm_object$targets <- odm_object$targets %>%
      dplyr::mutate(target_id = dplyr::row_number()) %>%
      dplyr::relocate(.data$target_id)
  }
  if (search_direction == "to_target") {
    rownames(out_mat) <- odm_object$sources$source_id
    colnames(out_mat) <- odm_object$targets$target_id
  }
  else {
    rownames(out_mat) <- odm_object$targets$target_id
    colnames(out_mat) <- odm_object$sources$source_id
  }
  return(out_mat)
}
