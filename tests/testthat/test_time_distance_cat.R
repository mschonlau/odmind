library(testthat)
library(odmind)

# Test whether an sf object is created
test_that("sf objects are created", {
  is_sf <- function(data) {
    data_attr <- attributes(data)
    all(data_attr$class == c("sf", "data.frame")) &
      data_attr$sf_column %in% c("geometry", "geom")
  }
  output_sf <- create_time_distance_by_cat_sf(
    odm_object = testdata$od_result,
    filter_attribute = "category",
    filter_value = "A"
  )
  expect_true(is_sf(output_sf))
})

# Test whether the output contains the correct number of rows
test_that("output_sf contains the correct number of rows", {
  output_sf <- create_time_distance_by_cat_sf(
    odm_object = testdata$od_result,
    filter_attribute = "category",
    filter_value = "A"
  )
  expect_equal(nrow(output_sf), nrow(testdata$od_result$sources))
})

# Test whether the output contains values in Min_Dist and Min_Time cols
test_that("output_sf contains values in Min_Dist and Min_Time
          cols", {
  output_sf <- create_time_distance_by_cat_sf(
    odm_object = testdata$od_result,
    filter_attribute = "category",
    filter_value = "A"
  )

  expect_identical(
    c(output_sf$Min_Dist, output_sf$Min_Time),
    na.omit(c(output_sf$Min_Dist, output_sf$Min_Time))
  )
})

# Test if the output contains only the chosen filter_value
test_that("output_sf contains only the chosen filter_value
          cols", {
  filter_value <- "A"
  output_sf <- create_time_distance_by_cat_sf(
    odm_object = testdata$od_result,
    filter_attribute = "category",
    filter_value = filter_value
  )

  expect_identical(unique(output_sf$category), filter_value)
})
