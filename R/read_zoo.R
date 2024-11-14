utils::globalVariables(
  c("DateTime", "Space Use Coordinate X", "Space Use Coordinate Y", "Interval Channel 1 Value", "time", "X", "Y", "behaviour")
)
#' read_zoo
#'
#' @param file zoo monitor file
#' @param sheet file sheet to use
#'
#' @return tibble with time, X, Y and behaviour
#' @export
read_zoo <- function(file, sheet = 1){
  zoo <- file |> readxl::read_excel(sheet = sheet)
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
#   "inst/example/example-zoo.xlsx")
# read_zoo(file, sheet = 2) |> print()