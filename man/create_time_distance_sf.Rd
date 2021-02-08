% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_time_distance_sf.R
\name{create_time_distance_sf}
\alias{create_time_distance_sf}
\title{create_time_distance_sf}
\usage{
create_time_distance_sf(odm_object, source_sf, target_df)
}
\arguments{
\item{odm_object}{of type list encompassing duration and distance
matrices and the source and target locations}

\item{source_sf}{sf object of geometry type point containing the sources
with coordinates in separate x, y columns}

\item{target_df}{data.frame containing the targets with coordinates
in separate x, y columns}
}
\value{
sf object of geometry type point
}
\description{
Create sf object of geometry type point with minimum distance
and duration values for each source to target combination
}