#' Title
#'
#' @param grid grid obj
#' @param X col to change
#' @param Y row to change
#' @param max_zone number of zones
#' @return change grid obj
#' @export
#'
#' @examples
#'  grid <- create_grid(
#'    c(0, 200),
#'    c(0, 100),
#'    dim = c(4,4)
#'  )
#'  df <- tibble::tibble(X = runif(100, 0, 200), Y = runif(100, 0, 100),
#'               behaviour = "sitting")
#'  plot_grid(grid, df, zone_fill = TRUE)
#'  grid <- update_zone(grid, 25, 24, 2)
#'  plot_grid(grid, df, zone_fill = TRUE)
update_zone <- function(grid, X, Y, max_zone){
  df <- tibble::tibble(X, Y)
  grid_cell <- add_grid(df, grid) |> dplyr::pull(grid)
  index <- which(grid$grid == grid_cell)
  grid$zone[index] <- ifelse(
    grid$zone[index] == max_zone, 1, grid$zone[index] + 1
  )
  grid
}
