pkgname <- "monitoR"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('monitoR')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("add_grid")
### * add_grid

flush(stderr()); flush(stdout())

### Name: add_grid
### Title: Add grid
### Aliases: add_grid

### ** Examples

pacman::p_load(tidyverse, targets)
data(skink)
grid44 <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
grid44

add_grid(skink, grid44)



cleanEx()
nameEx("add_neigh_mean")
### * add_neigh_mean

flush(stderr()); flush(stdout())

### Name: add_neigh_mean
### Title: add_neigh_mean
### Aliases: add_neigh_mean

### ** Examples

grid_example <- grid
count_grid_behaviour(grid_example, skink_grid) |> 
dplyr::mutate(
 neigh_mean = add_neigh_mean(obs, grid_example)
)



cleanEx()
nameEx("calc_ei")
### * calc_ei

flush(stderr()); flush(stdout())

### Name: calc_ei
### Title: calc ei
### Aliases: calc_ei

### ** Examples

zo1 <- tibble::tibble(
  zone = 1:2,
  obs = c(0, 100),
  n_grids = rep(1,2)
)
zo2 <- tibble::tibble(
  zone = 1:2,
  obs = c(50,50),
  n_grids = rep(1,2)
)
calc_ei(zo1)
calc_ei(zo2)



cleanEx()
nameEx("calc_entropy")
### * calc_entropy

flush(stderr()); flush(stdout())

### Name: calc_entropy
### Title: calculate entropy
### Aliases: calc_entropy

### ** Examples

calc_entropy(sample(1:16, size = 1000, replace = TRUE)) |> print()



cleanEx()
nameEx("calc_spi")
### * calc_spi

flush(stderr()); flush(stdout())

### Name: calc_spi
### Title: calculate SPI
### Aliases: calc_spi

### ** Examples

data(skink_grid)
data(grid)
grid$zone[1:2] <- 2
grid
get_zone_object(grid, skink_grid) |> calc_spi()



cleanEx()
nameEx("count_grid_behaviour")
### * count_grid_behaviour

flush(stderr()); flush(stdout())

### Name: count_grid_behaviour
### Title: count_grid behaviour
### Aliases: count_grid_behaviour

### ** Examples

count_grid_behaviour(grid, skink_grid)



cleanEx()
nameEx("create_grid")
### * create_grid

flush(stderr()); flush(stdout())

### Name: create_grid
### Title: create_grid
### Aliases: create_grid

### ** Examples

data(skink)
zone = tibble::tibble(
  grid = 1:16,
  zone = rep(1:2, c(10, 6))
)
create_grid(
  range(skink$X),
  range(skink$Y),
  dim = c(4,4),
  zone
)



cleanEx()
nameEx("get_entropy_null")
### * get_entropy_null

flush(stderr()); flush(stdout())

### Name: get_entropy_null
### Title: get_entropy_null
### Aliases: get_entropy_null

### ** Examples

get_entropy_null(1:16, n_sims = 10, n_grid = 16)



cleanEx()
nameEx("get_ess")
### * get_ess

flush(stderr()); flush(stdout())

### Name: get_ess
### Title: get ESS
### Aliases: get_ess

### ** Examples

get_ess(skink_grid)



cleanEx()
nameEx("get_ess_null")
### * get_ess_null

flush(stderr()); flush(stdout())

### Name: get_ess_null
### Title: get ess null
### Aliases: get_ess_null

### ** Examples

get_ess_null(skink_grid)



cleanEx()
nameEx("get_neigh")
### * get_neigh

flush(stderr()); flush(stdout())

### Name: get_neigh
### Title: get neigh
### Aliases: get_neigh

### ** Examples

get_neigh(grid, 1)



cleanEx()
nameEx("get_neigh_mat")
### * get_neigh_mat

flush(stderr()); flush(stdout())

### Name: get_neigh_mat
### Title: get_neigh_mat
### Aliases: get_neigh_mat

### ** Examples

get_neigh_mat(grid)



cleanEx()
nameEx("get_zone_object")
### * get_zone_object

flush(stderr()); flush(stdout())

### Name: get_zone_object
### Title: get zone object
### Aliases: get_zone_object

### ** Examples

data(grid)
grid$zone[2] <- 2
data(skink_grid)
get_zone_object(grid, skink_grid)



cleanEx()
nameEx("plot_ei")
### * plot_ei

flush(stderr()); flush(stdout())

### Name: plot_ei
### Title: plot ei
### Aliases: plot_ei

### ** Examples

data(skink_grid)
data(grid)
grid$zone[5:8] <- 2
grid$zone[8:16] <- 3
plot_ei(grid, skink_grid)



cleanEx()
nameEx("plot_grid")
### * plot_grid

flush(stderr()); flush(stdout())

### Name: plot_grid
### Title: plot_grid
### Aliases: plot_grid

### ** Examples

data(skink)
grid <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
grid$zone[1] <- 2
plot_grid(grid, skink, zone_fill = TRUE)



cleanEx()
nameEx("plot_neigh")
### * plot_neigh

flush(stderr()); flush(stdout())

### Name: plot_neigh
### Title: plot_neigh
### Aliases: plot_neigh

### ** Examples

plot_neigh(grid, 6)



cleanEx()
nameEx("plot_spi")
### * plot_spi

flush(stderr()); flush(stdout())

### Name: plot_spi
### Title: plot spi
### Aliases: plot_spi

### ** Examples

data(grid)
data(skink_grid)
grid$zone[1:8] <- 2
plot_spi(grid, skink_grid)



cleanEx()
nameEx("plot_summary")
### * plot_summary

flush(stderr()); flush(stdout())

### Name: plot_summary
### Title: plot summary
### Aliases: plot_summary

### ** Examples

data(skink_grid)
skink_grid <- skink_grid |>
  dplyr::mutate(
    zone = dplyr::case_when(
      grid %in% c(1, 3, 5) ~ 2,
      TRUE ~ 1
    )
  )
plot_summary(skink_grid)



cleanEx()
nameEx("update_zone")
### * update_zone

flush(stderr()); flush(stdout())

### Name: update_zone
### Title: Title
### Aliases: update_zone

### ** Examples

 grid <- create_grid(
   c(0, 200),
   c(0, 100),
   dim = c(4,4)
 )
 df <- tibble::tibble(X = runif(100, 0, 200), Y = runif(100, 0, 100),
              behaviour = "sitting")
 plot_grid(grid, df, zone_fill = TRUE)
 grid <- update_zone(grid, 25, 24, 2)
 plot_grid(grid, df, zone_fill = TRUE)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
