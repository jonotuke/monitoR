#' get_neigh_mat
#' 
#' Get a matrix where each row is a grid cell and the 
#' columns give the weighting for the mean of the neighbour cells
#'
#' @param grid_obj grid object
#'
#' @return matrix
#' @export
#'
#' @examples
#' get_neigh_mat(grid)
get_neigh_mat <- function(grid_obj){
  n <- nrow(grid_obj)
  M <- matrix(0, nrow = n, ncol = n)
  for(i in 1:n){
    cell <- grid_obj$grid[i]
    neigh <- get_neigh(grid_obj, cell)
    M[i, neigh] <- 1 / length(neigh)
  }
  M
}
# pacman::p_load(tidyverse, targets)
# grid
# get_neigh_mat(grid) |> print()
