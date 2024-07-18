utils::globalVariables(
  c("n_grids", "ri", "ratio", "wi")
)
#' calc ei
#'
#' @param df tibble with columns zone, obs and n of grid for zone
#'
#' @return tibble with calculation and ei
#' @export
#'
#' @examples
#' df1 <- tibble::tibble(
#'   zone = 1:2,
#'   obs = c(0, 100),
#'   n_grids = rep(1,2)
#' )
#' df2 <- tibble::tibble(
#'   zone = 1:2,
#'   obs = c(50,50),
#'   n_grids = rep(1,2)
#' )
#' df2
#' calc_ei(df1) |> print()
#' calc_ei(df2) |> print()
calc_ei <- function(df) {
  N <- sum(df$obs)
  n <- length(unique(df$zone))
  df <- df |>
    dplyr::mutate(
      ri = obs / N,
      pi = n_grids / sum(n_grids),
      ratio = ri/pi,
      wi = ratio / sum(ratio),
      ei = (wi - 1/n) / (wi + 1/n)
    )
  df
}
