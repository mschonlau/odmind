library(testthat)
library(odmind)

# Test whether an sf object is created
test_that("sf objects are created",{

  is_sf <- function(data) {
    data_attr <- attributes(data)
    all( data_attr$class == c("sf", "data.frame") ) &
      data_attr$sf_column %in% c("geometry", "geom")
  }
  output_sf <- create_cumulative_by_cat_sf(odm_object = testdata$od_result,
                                           filter_value_type = "distance",
                                           accessibility_filter_value = 750,
                                           search_direction = "to_target",
                                           filter_attribute = "category",
                                           filter_value = "A")
  expect_true( is_sf(output_sf) )
})
test_that("sf objects are created",{

  is_sf <- function(data) {
    data_attr <- attributes(data)
    all( data_attr$class == c("sf", "data.frame") ) &
      data_attr$sf_column %in% c("geometry", "geom")
  }
  output_sf <- create_cumulative_by_cat_sf(odm_object = testdata$od_result,
                                           filter_value_type = "distance",
                                           accessibility_filter_value = 750,
                                           search_direction = "from_target",
                                           filter_attribute = "category",
                                           filter_value = "A")
  expect_true( is_sf(output_sf) )
})


# Test whether the output contains the correct number of rows
test_that("output_sf contains the correct number of rows", {
  output_sf <- create_cumulative_by_cat_sf(odm_object = testdata$od_result,
                                           filter_value_type = "distance",
                                           accessibility_filter_value = 750,
                                           search_direction = "to_target",
                                           filter_attribute = "category",
                                           filter_value = "A")
  expect_identical(nrow(output_sf), nrow(testdata$od_result$sources))
})

# Test whether the output contains the correct number of rows
test_that("output_sf contains the correct number of rows", {
  output_sf <- create_cumulative_by_cat_sf(odm_object = testdata$od_result,
                                           filter_value_type = "distance",
                                           accessibility_filter_value = 750,
                                           search_direction = "from_target",
                                           filter_attribute = "category",
                                           filter_value = "A")
  expect_identical(nrow(output_sf), nrow(testdata$od_result$targets))
})

# Test whether the output contains values in target_cnt col
test_that("output_sf contains values in target_cnt col", {
  output_sf <- create_cumulative_by_cat_sf(odm_object = testdata$od_result,
                                           filter_value_type = "distance",
                                           accessibility_filter_value = 750,
                                           search_direction = "to_target",
                                           filter_attribute = "category",
                                           filter_value = "A")
  expect_true(any(!is.na(output_sf$target_cnt)))
})

# Test whether the output contains values in source_cnt col
test_that("output_sf contains values in source_cnt col", {
  output_sf <- create_cumulative_by_cat_sf(odm_object = testdata$od_result,
                                           filter_value_type = "distance",
                                           accessibility_filter_value = 750,
                                           search_direction = "from_target",
                                           filter_attribute = "category",
                                           filter_value = "A")
  expect_true(any(!is.na(output_sf$source_cnt)))
})
