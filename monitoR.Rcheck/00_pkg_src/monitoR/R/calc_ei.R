utils::globalVariables(
  c("n_grids", "ri", "ratio", "wi")
)
#' calc ei
#'
#' @param zone_obj a zone object
#'
#' @return tibble with calculation and ei
#' @export
#'
#' @examples
#' zo1 <- tibble::tibble(
#'   zone = 1:2,
#'   obs = c(0, 100),
#'   n_grids = rep(1,2)
#' )
#' zo2 <- tibble::tibble(
#'   zone = 1:2,
#'   obs = c(50,50),
#'   n_grids = rep(1,2)
#' )
#' calc_ei(zo1)
#' calc_ei(zo2)
calc_ei <- function(zone_obj) {
  N <- sum(zone_obj$obs)
  n <- length(unique(zone_obj$zone))
  ei <- zone_obj |>
    dplyr::mutate(
      ri = obs / N,
      pi = n_grids / sum(n_grids),
      ratio = ri/pi,
      wi = ratio / sum(ratio),
      ei = (wi - 1/n) / (wi + 1/n)
    )
  ei
}
