#' add_neigh_mean
#' 
#' Get average of neighbour observations
#' @param x vector of observations
#' @param grid_obj grid object 
#'
#' @return vector of neighbour means
#' @export
#'
#' @examples
#' grid_example <- grid
#' count_grid_behaviour(grid_example, skink_grid) |> 
#' dplyr::mutate(
#'  neigh_mean = add_neigh_mean(obs, grid_example)
#' )
add_neigh_mean <- function(x, grid_obj){
  M <- get_neigh_mat(grid_obj)
  neigh_mean <- as.numeric(M %*% x)
  neigh_mean
}
