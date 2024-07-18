## code to prepare `skink_grid` dataset goes here
data(skink)
grid <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
skink_grid <- add_grid(skink, grid)
usethis::use_data(skink_grid, overwrite = TRUE)
