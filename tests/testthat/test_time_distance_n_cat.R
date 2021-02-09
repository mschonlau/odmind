library(testthat)
library(odmind)

# Test whether an sf object is created
test_that("sf objects are created",{

  is_sf <- function(data) {
    data_attr <- attributes(data)
    all( data_attr$class == c("sf", "data.frame") ) &
      data_attr$sf_column %in% c("geometry", "geom")
  }
  output_sf <- create_time_distance_n_by_cat_sf(odm_object = testdata$od_result,
                                              filter_attribute = "category",
                                              filter_value = "A",
                                              n = 3)
  expect_true( is_sf(output_sf) )
})

# Test whether the output contains the right number of rows
test_that("output_sf contains the right number of rows", {
  output_sf <- create_time_distance_n_by_cat_sf(odm_object = testdata$od_result,
                                                filter_attribute = "category",
                                                filter_value = "A",
                                                n = 3)
  expect_equal(nrow(output_sf), nrow(testdata$od_result$sources))
})

# Test whether the output contains values in MeanDist and MeanTime cols
test_that("create_time_distance_n_sf() contains values in MeanDist and MeanTime
          cols", {
            output_sf <- create_time_distance_n_by_cat_sf(
              odm_object = testdata$od_result,
              filter_attribute = "category",
              filter_value = "A",
              n = 3
              )

            expect_identical(c(output_sf$MeanDist, output_sf$MeanTime),
                             na.omit(c(output_sf$MeanDist, output_sf$MeanTime)))
          })

# Test whether the output contains n Min_Dist and Min_Time cols with the
# respective suffix _n
test_that("output_sf contains n Min_Dist and Min_Time cols
          with the respective suffix _n", {
            n <- 3
            output_sf <-
              create_time_distance_n_by_cat_sf(odm_object = testdata$od_result,
                                               filter_attribute = "category",
                                               filter_value = "A",
                                               n = n)
            expect_true(all(c(paste0("MinDist_", 1:n), paste0("MinTime_", 1:n))
                            %in% colnames(output_sf)) == TRUE)
          })

# Test if the output contains only the chosen filter_value in every filter col
test_that("output_sf contains only the chosen filter_value
          cols", {
            get_unique <- function(data, filter_attribute) {
              data <- sf::st_drop_geometry(data)
              unique(unlist(data[grep(filter_attribute, colnames(data))]))
            }

            filter_value <- "A"
            filter_attribute <- "category"
            output_sf <- create_time_distance_n_by_cat_sf(
              odm_object = testdata$od_result,
              filter_attribute = filter_attribute,
              filter_value = filter_value,
              n = 3)

            expect_identical(get_unique(output_sf, filter_attribute),
                             filter_value)
          })
