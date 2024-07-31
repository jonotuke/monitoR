utils::globalVariables(
  c("neighbour")
)
#' plot_neigh
#'
#' @param grid_obj grid object
#' @param cell cell number
#'
#' @return plot of neighbours
#' @export
#'
#' @examples
#' plot_neigh(grid, 6)
plot_neigh <- function(grid_obj, cell) {
  grid_obj |>
    dplyr::mutate(
      neighbour = ifelse(
        grid %in% get_neigh(grid_obj, cell), "yes", "no")
    ) |>
    ggplot2::ggplot(ggplot2::aes(X, Y, fill = neighbour)) +
    ggplot2::geom_tile(col = "white") +
    harrypotter::scale_fill_hp_d("Ravenclaw") +
    ggplot2::coord_equal() + 
    ggplot2::theme_minimal()

}
