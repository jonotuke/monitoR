uneven_df <- tibble::tibble(
  zone = 1:2,
  obs = c(0, 100),
  n_grids = rep(1,2)
)
even_df <- tibble::tibble(
  zone = 1:2,
  obs = c(50,50),
  n_grids = rep(1,2)
)
n <- length(unique(uneven_df$zone))
test_that("calc-ei on uneven data",{
  expect_equal(calc_ei(uneven_df) |> dplyr::pull(ei), c(-1, (n-1)/(n+1)))
})
test_that("calc-ei on even data",{
  expect_equal(calc_ei(even_df) |> dplyr::pull(ei), c(0,0))
})
