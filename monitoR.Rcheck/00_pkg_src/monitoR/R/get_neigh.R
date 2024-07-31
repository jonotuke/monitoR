#' get neigh
#'
#' @param grid grid object
#' @param cell grid number
#'
#' @return grid cells that are neighbours
#' @export
#'
#' @examples
#' get_neigh(grid, 1)
get_neigh <- function(grid, cell) {
  i <- grid |> dplyr::filter(grid == cell) |> dplyr::pull(X)
  j <- grid |> dplyr::filter(grid == cell) |> dplyr::pull(Y)
  neighbourhood <- tidyr::expand_grid(
    X = c(i-1, i, i+1),
    Y = c(j-1, j, j+1)
  )
  neighbourhood <-
    neighbourhood |>
    dplyr::filter(!(X==i & Y==j)) |>
    dplyr::mutate(cell = stringr::str_glue("{X}-{Y}"))
  grid |>
    dplyr::mutate(cell = stringr::str_glue("{X}-{Y}")) |>
    dplyr::filter(cell %in% neighbourhood$cell) |>
    dplyr::pull(grid)
}
# get_neigh(grid, 1)
