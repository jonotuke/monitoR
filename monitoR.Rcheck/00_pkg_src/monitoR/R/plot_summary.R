#' plot summary
#'
#' @param df zoo grid obj
#'
#' @return plot of summary
#' @export
#'
#' @examples
#' data(skink_grid)
#' skink_grid <- skink_grid |>
#'   dplyr::mutate(
#'     zone = dplyr::case_when(
#'       grid %in% c(1, 3, 5) ~ 2,
#'       TRUE ~ 1
#'     )
#'   )
#' plot_summary(skink_grid)
plot_summary <- function(df){
  df |>
  dplyr::count(behaviour, zone) |>
  ggplot2::ggplot(ggplot2::aes(n, behaviour, fill = factor(zone))) +
  ggplot2::geom_col(position = "dodge", col = "black") +
  harrypotter::scale_fill_hp_d("Ravenclaw") +
  ggplot2::geom_label(ggplot2::aes(label = n),
  position = ggplot2::position_dodge(width = .9),
  col = "white", show.legend = FALSE) +
  ggplot2::labs(fill = "Zone")
}
