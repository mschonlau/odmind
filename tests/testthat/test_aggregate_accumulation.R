library(testthat)
library(odmind)

# Test whether an sf object is created
test_that("sf objects are created",{

  is_sf <- function(data) {
    data_attr <- attributes(data)
    all( data_attr$class == c("sf", "data.frame") ) &
      data_attr$sf_column %in% c("geometry", "geom")
  }
  pnt_sf <- create_cumulative_sf(odm_object = testdata$od_result,
                                 filter_value_type = "distance",
                                 accessibility_filter_value = 750,
                                 search_direction = "to_target")
  output_sf <- aggregate_accumulation(aoi_sf = testdata$grid_500m,
                                      pnt_sf = pnt_sf,
                                      id_col = "id",
                                      crs = 4647)
  expect_true( is_sf(output_sf) )
})

# Test whether the output contains the correct number of rows
test_that("output_sf contains the correct number of rows", {
  pnt_sf <- create_cumulative_sf(odm_object = testdata$od_result,
                                 filter_value_type = "distance",
                                 accessibility_filter_value = 750,
                                 search_direction = "to_target")
  output_sf <- aggregate_accumulation(aoi_sf = testdata$grid_500m,
                                      pnt_sf = pnt_sf,
                                      id_col = "id",
                                      crs = 4647)
  expect_identical(nrow(output_sf), nrow(testdata$grid_500m))
})

# Test whether the output contains values in target_pot col
test_that("output_sf contains values in target_pot col", {
  pnt_sf <- create_cumulative_sf(odm_object = testdata$od_result,
                                 filter_value_type = "distance",
                                 accessibility_filter_value = 750,
                                 search_direction = "to_target")
  output_sf <- aggregate_accumulation(aoi_sf = testdata$grid_500m,
                                      pnt_sf = pnt_sf,
                                      id_col = "id",
                                      crs = 4647)
  expect_true(any(!is.na(output_sf$MeanCnt)))
  expect_true(any(!is.na(output_sf$MedianCnt)))
})
