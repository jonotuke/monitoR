utils::globalVariables(
  c("zone", "X_grid", "Y_grid")
)
#' Add grid
#'
#' @param zoo zoo monitor tibble
#' @param grid grid object 
#'
#' @return zoo object with grid and zones
#' @export
#'
#' @examples
#' pacman::p_load(tidyverse, targets)
#' data(skink)
#' grid44 <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
#' grid44
#' 
#' add_grid(skink, grid44)
add_grid <- function(zoo, grid){
  x_pts <- sort(unique(c(grid$left, grid$right)))
  y_pts <- sort(unique(c(grid$top, grid$bottom)))
  zoo |>
    dplyr::mutate(
      X_grid = as.numeric(
        cut(X, breaks = x_pts, include.lowest = TRUE)
      ),
      Y_grid = as.numeric(
        cut(Y, breaks = y_pts, include.lowest = TRUE)
      )
    ) |>
    dplyr::left_join(grid |> dplyr::select(X, Y, grid, zone),
              by = c("X_grid" = "X", "Y_grid" = "Y")) |>
    dplyr::select(!c(X_grid, Y_grid))
}
