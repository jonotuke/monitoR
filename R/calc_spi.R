#' calculate SPI
#'
#' @param zones tibble from get_measure_summary()
#'
#' @return SPI
#' @export
#'
#' @examples
#' data(skink_grid)
#' data(grid)
#' grid$zone[1:2] <- 2
#' grid
#' get_measure_summary(grid, skink_grid) |> calc_spi()
calc_spi <- function(zones) {
  zones <- zones |>
    dplyr::rename(fo = obs)
  N <- sum(zones$fo)
  zones <- zones |>
    dplyr::mutate(
      fe = N * n_grids / sum(n_grids)
    )
  SPI <- sum(abs(zones$fo - zones$fe)) / (2 * (N - min(zones$fe)))
  SPI
}
