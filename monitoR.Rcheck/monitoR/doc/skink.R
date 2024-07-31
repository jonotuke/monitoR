## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)


## ----setup--------------------------------------------------------------------
library(monitoR)
pacman::p_load(conflicted, tidyverse, gt)
theme_set(theme_bw())


## -----------------------------------------------------------------------------
data(skink)


## -----------------------------------------------------------------------------
skink |> glimpse()


## -----------------------------------------------------------------------------
grid <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
skink_grid <- skink |> add_grid(grid)


## -----------------------------------------------------------------------------
#| fig-cap: Skink dataset with grid
#| label: fig-skink
plot_grid(grid, skink_grid)


## -----------------------------------------------------------------------------
calc_entropy(skink_grid$grid)


## -----------------------------------------------------------------------------
log10(16)


## -----------------------------------------------------------------------------
null_entropy <- monitoR::get_entropy_null(skink_grid$grid, n_sims = 1000, n_grid = 16)


## -----------------------------------------------------------------------------
quantile(null_entropy, c(0.025, 0.975))


## -----------------------------------------------------------------------------
#| fig-cap: Entropy for each behaviour
#| label: fig-BE
skink_grid |> 
  summarise(entropy = calc_entropy(grid), .by = behaviour) |> 
  mutate(
    behaviour = fct_reorder(behaviour, entropy)
  ) |> 
  ggplot(aes(entropy, behaviour, fill = behaviour)) + 
  geom_col(show.legend = FALSE) + 
  harrypotter::scale_fill_hp_d("Ravenclaw") + 
  labs(x = "Entropy", y = NULL)


## -----------------------------------------------------------------------------
get_ess(skink_grid)


## -----------------------------------------------------------------------------
ess_null <- get_ess_null(skink_grid, n_sims = 100)
quantile(ess_null, c(0.025, 0.975))


## -----------------------------------------------------------------------------
skink_bask <- skink_grid |> 
  filter(behaviour == "Basking")


## -----------------------------------------------------------------------------
#| fig-cap: Observations where just basking
#| label: fig-basking
plot_grid(grid, skink_bask)


## -----------------------------------------------------------------------------
#| tbl-cap: Count of number of basking events for each grid.
#| label: tbl-bask
basking_df <- count_grid_behaviour(grid = grid, skink_bask) 
basking_df <- basking_df |> 
  mutate(
    environ = "normal"
  )
basking_df$environ[c(2, 3, 5, 6, 7, 8)] <- "rocks"
basking_df |> gt()


## -----------------------------------------------------------------------------
#| fig-cap: Neighbourhoods.
#| label: fig-neigh
#| layout-ncol: 3
plot_neigh(grid, 1)
plot_neigh(grid, 2)
plot_neigh(grid, 10)


## -----------------------------------------------------------------------------
M <- get_neigh_mat(grid)
basking_df$neigh <- as.numeric(M %*% basking_df$obs)
basking_df


## -----------------------------------------------------------------------------
M1 <- lm(obs ~ environ * neigh, data = basking_df)
summary(M1)
M2 <- update(M1, .~. - environ:neigh)
summary(M2)
M3 <- update(M2, .~. - neigh)
summary(M3)

