utils::globalVariables(
  c("left", "right", "top", "bottom")
)
#' plot_grid
#'
#' @param grid grid object
#' @param zoo zoo object
#' @param grid_col fill to show grid name
#' @param zone_fill show zone colour
#' @param label boolean to show grid labels
#'
#' @return plot of grid on zoo data
#' @export
#'
#' @examples
#' data(skink)
#' grid <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
#' grid$zone[1] <- 2
#' plot_grid(grid, skink, zone_fill = TRUE)
plot_grid <- function(
  grid,
  zoo,
  grid_col = FALSE,
  zone_fill = FALSE,
  label = TRUE
) {
  p <- grid |>
    ggplot2::ggplot() +
    ggplot2::geom_rect(
      ggplot2::aes(xmin = left, xmax = right, ymin = bottom, ymax = top),
      col = "black",
      alpha = 0.1,
      fill = NA
    )
  if (grid_col) {
    p <- p +
      ggplot2::geom_point(ggplot2::aes(X, Y, col = factor(grid)), data = zoo)
  } else {
    p <- p +
      ggplot2::geom_point(ggplot2::aes(X, Y, col = behaviour), data = zoo)
  }
  if (label) {
    p <- p +
      ggplot2::geom_label(
        ggplot2::aes(x = left, y = bottom, label = grid),
        vjust = "top",
        hjust = "left"
      )
  }
  p <- p +
    ggplot2::coord_fixed() +
    ggplot2::theme_minimal() +
    harrypotter::scale_fill_hp_d("Ravenclaw") +
    harrypotter::scale_colour_hp_d("Ravenclaw") +
    ggplot2::labs(colour = "Behaviour")
  if (zone_fill) {
    p <- p +
      ggplot2::geom_rect(
        ggplot2::aes(
          xmin = left,
          xmax = right,
          ymin = bottom,
          ymax = top,
          fill = factor(zone)
        ),
        col = "black",
        alpha = 0.5,
      ) +
      ggplot2::labs(fill = "Zone")
  }
  p <- p + ggplot2::scale_y_reverse()
  p
}
# data(skink)
# grid <- create_grid(range(skink$X), range(skink$Y), dim = c(4, 4))
# grid$zone[1] <- 2
# plot_grid(grid, skink, zone_fill = TRUE, label = FALSE) |> print()
