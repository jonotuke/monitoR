#' get ess null
#'
#' @param df zoo grid object
#' @param n_sims number of sims
#'
#' @return vector of empirical ESS
#' @export
#'
#' @examples
#' get_ess_null(skink_grid)
get_ess_null <- function(df, n_sims = 5){
  1:n_sims |>
    purrr::map(\(x) df |> 
      dplyr::mutate(grid = sample(grid))) |>
    purrr::map_dbl(get_ess)
}
# pacman::p_load(tidyverse, targets)
# get_ess_null(skink_grid)
