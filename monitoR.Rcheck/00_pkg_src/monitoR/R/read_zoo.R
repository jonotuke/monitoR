utils::globalVariables(
  c("DateTime", "Space Use Coordinate X", "Space Use Coordinate Y", "Interval Channel 1 Value", "time", "X", "Y", "behaviour")
)
#' read_zoo
#'
#' @param file zoo monitor file
#'
#' @return tibble with time, X, Y and behaviour
#' @export
read_zoo <- function(file){
  zoo <- file |> readxl::read_excel()
  zoo <- zoo |>
    dplyr::select(
      time = DateTime,
      X = `Space Use Coordinate X`,
      Y = `Space Use Coordinate Y`,
      behaviour = `Interval Channel 1 Value`
    )
  zoo <- zoo |>
    dplyr::mutate(
      time = lubridate::ymd_hms(time),
      behaviour = stringr::str_to_title(behaviour)
    )
  zoo <- zoo |>
    dplyr::filter(!is.na(X)) |>
    dplyr::filter(!is.na(Y)) |>
    dplyr::filter(!is.na(behaviour))
  zoo
}
# pacman::p_load(tidyverse, targets)
# file <- fs::path_package("monitoR", 
#   "inst/extdata/skinks/2024-05-14-skink-zoo-monitor.xlsx")
# read_zoo(file) |> print()