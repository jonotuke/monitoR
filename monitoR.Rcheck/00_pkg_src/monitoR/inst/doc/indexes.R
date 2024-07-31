## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)


## ----setup--------------------------------------------------------------------
library(monitoR)


## -----------------------------------------------------------------------------
#| label: sim-data
#| echo: false
n <- 100
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


## -----------------------------------------------------------------------------
#| fig-cap: Simulated dataset with even spread
#| label: fig-spi-even
#| echo: false
plot_grid(grid_even, obs, grid_col = TRUE, zone_fill = TRUE)


## -----------------------------------------------------------------------------
#| lst-label: spi-even
#| lst-cap: Even spread SPI
get_zone_object(grid_even, obs) |> calc_spi()


## -----------------------------------------------------------------------------
#| fig-cap: Simulated uneven data
#| label: fig-spi-uneven
#| echo: true
plot_grid(grid_uneven, obs, grid_col = TRUE, zone_fill = TRUE)


## -----------------------------------------------------------------------------
get_zone_object(grid_uneven, obs) |> calc_spi()


## -----------------------------------------------------------------------------
get_zone_object(grid_even, obs) |> 
  calc_ei() |> 
  dplyr::select(zone, ei) |> 
  gt::gt()


## -----------------------------------------------------------------------------
get_zone_object(grid_uneven, obs) |> 
  calc_ei() |> 
  dplyr::select(zone, ei) |> 
  gt::gt()

