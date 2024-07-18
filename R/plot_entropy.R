#' plot entropy
#'
#' @param df tibble from get measure
#'
#' @return plot
#' @export
plot_entropy <- function(df) {
  overall_E <- calc_entropy(df$grid)
  df |>
    dplyr::summarise(entropy = calc_entropy(grid), .by = behaviour) |>
    dplyr::mutate(
      behaviour = forcats::fct_reorder(behaviour, entropy)
    ) |>
    ggplot2::ggplot(ggplot2::aes(entropy, behaviour, fill = behaviour)) +
    ggplot2::geom_col(show.legend = FALSE) +
    harrypotter::scale_fill_hp_d("Ravenclaw") +
    ggplot2::geom_text(ggplot2::aes(label = round(entropy, 2)), hjust = "right", col = "black", size = 5) +
    ggplot2::geom_vline(xintercept = overall_E, linetype = "dashed", linewidth = 2) +
    ggplot2::annotate("text", x = overall_E, y = 1, label = stringr::str_glue("Overall entropy: {round(overall_E, 2)}"), size = 5) +
    ggplot2::theme(text = ggplot2::element_text(size = 20))
}
# pacman::p_load(conflicted, tidyverse, targets)
# data(skink)
# grid <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
# skink <- skink |> add_grid(grid)
# plot_entropy(skink) |> print()
