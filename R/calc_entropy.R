utils::globalVariables(
  c("n", "N", "entropy")
)
#' calculate entropy
#'
#' @param x vector of observed grid pts
#'
#' @return entropy based on base 10
#' @export
#'
#' @examples
#' calc_entropy(sample(1:16, size = 1000, replace = TRUE)) |> print()
calc_entropy <- function(x) {
  df <- tibble::tibble(x = x)
  df <- df |>
    dplyr::count(x) |>
    dplyr::mutate(
      N = sum(n),
      p = n / N
    )
  entropy <- -sum(df$p * log10(df$p))
  entropy
}
