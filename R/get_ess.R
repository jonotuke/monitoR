#' get ESS
#'
#' @param df zoo grid object
#'
#' @return entropy sum of squares
#' @export
#'
#' @examples
#' get_ess(skink_grid)
get_ess <- function(df){
  df <- df |>
    dplyr::summarise(
      Ei = calc_entropy(grid), .by = behaviour
    ) |>
    dplyr::mutate(
      Ebullet = calc_entropy(df$grid)
    )
  sum((df$Ei - df$Ebullet)^2)
}

