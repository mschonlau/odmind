#' min_n
#'
#' @param x A row of a matrix
#' @param n An integer defining the number of minimum values to be extracted
#'
#' @return A vector of length at most n with the indices of the n smaller
#' elements.
#' @noRd
#'
min_n <- function(x, n = 1) {
  if (n == 1) {
    which.min(x)
  } else {
    if (n > 1) {
      ii <- order(x, decreasing = FALSE)[1:min(n, length(x))]
      ii[!is.na(x[ii])]
    }
    else {
      stop("n must be >=1")
    }
  }
}
