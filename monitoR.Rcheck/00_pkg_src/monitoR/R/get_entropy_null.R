#' get_entropy_null
#'
#' Get an empirical distribution of entropy for a given number of 
#' grids assuming evenly spread
#' 
#' @param obs_grid observed grid for each observation
#' @param n_sims the number of simulations to do
#' @param n_grid the number of grid cells 
#'
#' @return a vector of entropy for each permutations
#' @export
#'
#' @examples
#' get_entropy_null(1:16, n_sims = 10, n_grid = 16)
get_entropy_null <- function(obs_grid, n_sims, n_grid){
  N <- length(obs_grid)
  1:n_sims |>
    purrr::map(\(x) sample(1:n_grid, size = N, replace = TRUE)) |>
    purrr::map_dbl(\(x) calc_entropy(x))

}
# data(skink_grid)
# get_entropy_null(skink_grid$grid, n_sims = 10, n_grid = 16)


