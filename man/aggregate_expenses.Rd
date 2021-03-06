% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggregate_expenses.R
\name{aggregate_expenses}
\alias{aggregate_expenses}
\title{Aggregate travel expenses}
\usage{
aggregate_expenses(aoi_sf, pnt_sf, id_col, crs = 4647)
}
\arguments{
\item{aoi_sf}{sf of geometry type polygon used for aggregation}

\item{pnt_sf}{sf of geometry type point including attribute to be aggregated}

\item{id_col}{name of the id column used for grouping operations}

\item{crs}{epsg code}
}
\value{
sf of geometry type polygon including aggregated distance and time
    values
}
\description{
Aggregate the sf (geometry type point) attributes
    \code{"Min_Dist"} and \code{"Min_Time"} to an area of interest
}
\examples{
data(testdata)
pnt_sf <- create_time_distance_sf(odm_object = testdata$od_result)
output_sf <- aggregate_expenses(
  aoi_sf = testdata$grid_500m,
  pnt_sf = pnt_sf,
  id_col = "id",
  crs = 4647
)
}
\seealso{
\code{create_time_distance_sf()} to create a suitable sf
}
