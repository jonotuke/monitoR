#' count_grid behaviour
#'
#' For each grid counts the number of observations in that
#' grid. Have to pass in grid object so that can get
#' the empty grid cells. 
#' @param grid grid object
#' @param zoo_grid zoo grid object
#'
#' @return tibble with grid number and number of obs
#' @export
#'
#' @examples
#' count_grid_behaviour(grid, skink_grid)
count_grid_behaviour <- function(grid, zoo_grid){
  grid$obs <- 0
  for(i in 1:nrow(grid)){
    grid$obs[i] <- sum(zoo_grid$grid == grid$grid[i])
  }
  grid |> 
    dplyr::select(grid, obs)
}
