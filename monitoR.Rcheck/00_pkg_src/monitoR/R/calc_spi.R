#' calculate SPI
#'
#' @param zone_obj zone obj
#'
#' @return SPI
#' @export
#'
#' @examples
#' data(skink_grid)
#' data(grid)
#' grid$zone[1:2] <- 2
#' grid
#' get_zone_object(grid, skink_grid) |> calc_spi()
calc_spi <- function(zone_obj) {
  zone_obj <- zone_obj |>
    dplyr::rename(fo = obs)
  N <- sum(zone_obj$fo)
  zone_obj <- zone_obj |>
    dplyr::mutate(
      fe = N * n_grids / sum(n_grids)
    )
  SPI <- sum(abs(zone_obj$fo - zone_obj$fe)) / (2 * (N - min(zone_obj$fe)))
  SPI
}
