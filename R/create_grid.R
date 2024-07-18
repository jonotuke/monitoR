utils::globalVariables(
  c("grid")
)
get_break_pts <- function(range_x, n = 4){
  x0 <- range_x[1]
  xn <- range_x[2]
  L <- (xn - x0) / n
  # Note that need n regions to n+1 points
  pts <- x0 + 0:(n) * L
  pts
}
convert_xy_grid <- function(x, y, gx){
  grid <- (y-1) * gx + x
}
#' create_grid
#'
#' Takes an x-range and a y-range, a grid size and returns the grid information. 
#' @param x_range size 2 vector with min and max x-range
#' @param y_range size 2 vector with min and max y-range
#' @param dim size 2 vector (n rows, n cols)
#' @param zone zone for each grid cell
#'
#' @return tibble of grid info
#' @export
#'
#' @examples
#' data(skink)
#' zone = tibble::tibble(
#'   grid = 1:16,
#'   zone = rep(1:2, c(10, 6))
#' )
#' create_grid(
#'   range(skink$X),
#'   range(skink$Y),
#'   dim = c(4,4),
#'   zone
#' )
create_grid <- function(x_range, y_range,
                        dim = c(4,4), zone = NULL){
  X_df <-
    tibble::tibble(
      X = 1:dim[1],
      left = utils::head(get_break_pts(x_range, n = dim[1]), -1),
      right = get_break_pts(x_range, n = dim[1])[-1],
    )
  Y_df <-
    tibble::tibble(
      Y = 1:dim[2],
      bottom = utils::head(get_break_pts(y_range, n = dim[2]), -1),
      top = get_break_pts(y_range, n = dim[2])[-1],
    )
  df <- tidyr::expand_grid(X_df, Y_df) |>
    dplyr::mutate(
      grid = convert_xy_grid(X, Y, gx = dim[1])
    ) |>
    dplyr::arrange(grid) |>
    dplyr::select(grid, X, Y, dplyr::everything())
  if(is.null(zone)){
    df <- df |>
      dplyr::mutate(
        zone = 1
      )
  } else {
    df <- df |>
      dplyr::left_join(zone, by = "grid")
  }
  df
}
# pacman::p_load(conflicted, tidyverse, targets, monitoR)
# data(skink)
# zone = tibble(
#   grid = 1:16,
#   zone = rep(1:2, c(10, 6))
# )
# create_grid(
#   range(skink$X),
#   range(skink$Y),
#   dim = c(4,4),
#   zone
# )
