utils::globalVariables(
  c("spi")
)
#' plot spi
#'
#' @param grid grid obj
#' @param zoo_grid zoo grid obj
#'
#' @return plot of SPI
#' @export
#'
#' @examples
#' data(grid)
#' data(skink_grid)
#' grid$zone[1:8] <- 2
#' plot_spi(grid, skink_grid)
plot_spi <- function(grid, zoo_grid) {
  overall_spi <- get_zone_object(grid, zoo_grid) |> calc_spi()
  zoo_grid |>
  dplyr::group_by(behaviour) |>
  tidyr::nest() |>
  dplyr::mutate(
    spi = purrr::map(data, \(x) get_zone_object(grid, x) |> calc_spi())
  ) |>
    tidyr::unnest(spi) |>
  dplyr::ungroup() |>
  dplyr::mutate(
    behaviour = forcats::fct_reorder(behaviour, spi)
  ) |>
  ggplot2::ggplot(ggplot2::aes(spi, behaviour, fill = behaviour)) +
  ggplot2::geom_col(show.legend = FALSE) +
  harrypotter::scale_fill_hp_d("Ravenclaw") +
  ggplot2::geom_text(ggplot2::aes(label = round(spi, 2)), hjust = "right", col = "black", size = 5) +
  ggplot2::geom_vline(xintercept = overall_spi, linetype = "dashed", linewidth = 2) +
  ggplot2::annotate("text", x = overall_spi, y = 1,
  label = stringr::str_glue("Overall Modified SPI: {round(overall_spi, 2)}"), size = 5,
  hjust = "right") +
  ggplot2::theme(text = ggplot2::element_text(size = 20))
  
}
