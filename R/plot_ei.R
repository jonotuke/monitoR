utils::globalVariables(
  c("data", "ei")
)
#' plot ei
#'
#' @param grid grid obj
#' @param zoo_grid zoo_grid obj
#'
#' @return plot of ei
#' @export
#'
#' @examples
#' data(skink_grid)
#' data(grid)
#' grid$zone[5:8] <- 2
#' grid$zone[8:16] <- 3
#' plot_ei(grid, skink_grid)
plot_ei <- function(grid, zoo_grid) {
  n_behaviours <- length(unique(zoo_grid$behaviour))
  overall_ei <- get_measure_summary(grid, zoo_grid) |> calc_ei()
  zoo_grid <- zoo_grid |>
  dplyr::group_by(behaviour) |>
  tidyr::nest() |>
  dplyr::mutate(
    ei = purrr::map(data, \(x) get_measure_summary(grid, x) |> calc_ei())
  ) |>
  tidyr::unnest(ei)
  
  zoo_grid |>
  dplyr::ungroup() |>
  dplyr::mutate(
    behaviour = forcats::fct_reorder(behaviour, ei)
  ) |>
  ggplot2::ggplot(ggplot2::aes(ei, behaviour, fill = factor(zone))) +
  ggplot2::geom_col(position = "dodge") +
  harrypotter::scale_fill_hp_d("Ravenclaw") +
  ggplot2::theme(text = ggplot2::element_text(size = 20), legend.position = "top") +
  ggplot2::labs(fill = "Zone", x = "Elective Index") +
  ggplot2::geom_hline(yintercept = seq(1.5, 1.5 + (n_behaviours - 2)))
  
}
