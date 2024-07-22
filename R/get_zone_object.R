utils::globalVariables(
  c("obs")
)
#' get zone object
#'
#' @param grid grid object
#' @param zoo_grid zoo grid object
#'
#' @return zone object
#' @export
#'
#' @examples
#' data(grid)
#' grid$zone[2] <- 2
#' data(skink_grid)
#' get_zone_object(grid, skink_grid)
get_zone_object <- function(grid, zoo_grid){
  grids <- grid |> 
    dplyr::select(zone, grid) |> 
    dplyr::mutate(obs = 0)
  for(i in 1:nrow(grids)){
    grids$obs[i] <- sum(zoo_grid$grid == grids$grid[i])
  }
  zones <- grids |>
    dplyr::summarise(
      obs = sum(obs),
      n_grids = dplyr::n(),
      .by = zone
    )
  zones
}
