n <- 1000
obs <- tibble::tibble(
  X = c(runif(n, 0, 100), runif(n, 100, 200)),
  Y = c(runif(n, 100, 200), runif(n, 0, 100)),
  grid = rep(c(1, 4), each = n),
  behaviour = "resting"
)
grid <-
  create_grid(c(0, 200),c(0, 200), c(2,2))
grid_even <- grid |> dplyr::mutate(zone = c(1,1, 2, 2))
grid_uneven <- grid |> dplyr::mutate(zone = c(1,2, 2, 1))
grid_onezone <- grid |> dplyr::mutate(zone = c(1,1,1,1))
plot_grid(grid_even, obs, grid_col = TRUE, zone_fill = TRUE)
plot_grid(grid_uneven, obs, grid_col = TRUE, zone_fill = TRUE)
plot_grid(grid_onezone, obs, grid_col = TRUE, zone_fill = TRUE)
test_that("even spi", {
  expect_equal(get_measure_summary(grid_even, obs) |> calc_spi(), 0)
})
test_that("uneven spi", {
  expect_equal(get_measure_summary(grid_uneven, obs) |> calc_spi(), 1)
})
