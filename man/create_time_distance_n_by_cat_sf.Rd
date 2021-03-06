% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_time_distance_n_by_cat_sf.R
\name{create_time_distance_n_by_cat_sf}
\alias{create_time_distance_n_by_cat_sf}
\title{Calculate n closest distances and durations by category}
\usage{
create_time_distance_n_by_cat_sf(odm_object, filter_attribute, filter_value, n)
}
\arguments{
\item{odm_object}{of type list encompassing a duration and a distance
matrix, the source and target locations. Created by using either
\code{calc_odm} or \code{calc_odm_multicore}}

\item{filter_attribute}{A category column to subset the targets}

\item{filter_value}{A string with a specific category value}

\item{n}{An integer defining the number of minimum values to be
incorporated}
}
\value{
sf object of geometry type point
}
\description{
Creates sf of geometry type point for each source feature with
    the minimum distance and duration values to n nearest target features
    which match the applied category filter
}
\examples{
data(testdata)
od_result <- testdata$od_result
output_sf <- create_time_distance_n_by_cat_sf(
  odm_object = od_result,
  filter_attribute = "category", filter_value = "A", n = 3
)
}
\seealso{
\code{calc_odm()} or \code{calc_odm_multicore()} for odm_object
    creation and \code{create_time_distance_by_cat_sf} to calculate only
    the nearest target location for a specific category
}
