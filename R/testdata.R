#' Origin-Destination Calculation Results
#'
#' A preprocessed calculation using a sample of 200 buildings and
#' 163 amenity locations both taken from OpenGeodata.NRW. Additionally,
#' a polygon grid with a spatial resolution of 500 meters for aggregation
#' purposes is delivered.
#'
#' @docType data
#'
#' @usage data(testdata)
#'
#' @format od_result of class \code{"list"} and grid_500m of class
#' \code{("sfc_POLYGON", "sfc")}
#'
#' @keywords datasets
#'
#' @references Land NRW, 2020-11-03
#' (\href{https://www.opengeodata.nrw.de/produkte/}{OpenGeodata.NRW})
#'
#' @source \href{https://www.opengeodata.nrw.de/produkte/}{OpenGeodata.NRW}
#'
#' @examples
#' library(dplyr)
#' library(sf)
#' data(testdata)
#' targets_sf <- sf::st_as_sf(testdata$od_result$targets,
#'   coords = c("x", "y")
#' ) %>%
#'   sf::st_set_crs(4326) %>%
#'   sf::st_transform(3035)
#' plot(testdata$grid_500m$geometry, reset = FALSE)
#' plot(sf::st_transform(testdata$od_result$sources, 3035)$geom, add = TRUE)
#' plot(targets_sf$geometry, col = "red", pch = 20, add = TRUE)
"testdata"
