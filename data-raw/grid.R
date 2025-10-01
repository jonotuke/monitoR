## code to prepare `grid` dataset goes here
data(skink)
grid <- create_grid(range(skink$X), range(skink$Y), dim = c(4, 4))
usethis::use_data(grid, overwrite = TRUE)
