#' @title calc_odm_multicore (multicore)
#'
#' @description Looped calculation of duration and distance matrices between all
#' sources and targets (multicore)
#'
#' @param profile_string Route profile
#' @param sources sf object of geometry type point containing the
#' sources with coordinates in separate x, y columns
#' @param targets data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param max_chunk_size integer value defining the maximum number of source
#' to target connections to be processed per loop
#' @param ors_url url of the openrouteservice server to be used for processing
#'
#' @return odm-object of type list encompassing duration and distance matrices
#' and the source and target locations
#' @examples
#' \dontrun{
#' handlers(global = TRUE)
#' handlers("progress")
#' data(testdata)
#' sources <- testdata$od_result$sources
#' targets <- testdata$od_result$targets
#' # The testdata dataset is too small to generate time benefits out of using
#' # parallel processing. It should be applied to larger datasets
#' max_chunk_size <- 200 # depends on the config of the OpenRouteService server
#' registerDoFuture()
#' plan(multisession, gc = TRUE)
#' ors_url <- "SERVER URL"
#' res <- calc_odm_multicore(profile_string = "foot-walking",
#'                           sources = sources,
#'                           targets = targets,
#'                           max_chunk_size = 200,
#'                           ors_url = ors_url)
#' }
#' @seealso \code{calc_odm()} for sequential odm_object creation with one core
#' @export
#'

calc_odm_multicore <- function(profile_string, sources, targets,
                               max_chunk_size, ors_url) {
  coord_list <- get_calc_coords(sources, targets, max_chunk_size)
  src_coords <- coord_list[[1]]
  trgt_coords <- coord_list[[2]]
  src_split_list_len <- coord_list[[3]]
  trgt_split_list_len <- coord_list[[4]]
  n_loops <- 1:length(src_coords)
  tmp_resultlist <- calc_matrix_multicore(profile_string, src_coords,
                                           trgt_coords,n_loops, ors_url)
  build_odm(tmp_resultlist, sources, targets,
            src_split_list_len, trgt_split_list_len)
}
