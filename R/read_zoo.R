utils::globalVariables(
  c(
    "DateTime",
    "Space Use Coordinate X",
    "Space Use Coordinate Y",
    "Interval Channel 1 Value",
    "time",
    "X",
    "Y",
    "behaviour",
    ".data"
  )
)
#' read_zoo
#'
#' @param file zoo monitor file
#' @param sheet file sheet to use
#'
#' @return returns a tibble with all the data in file
#' @export
read_zoo <- function(file, sheet = 1) {
  zoo <- file |> readxl::read_excel(sheet = sheet)
  zoo
}
#' clean_zoo
#'
#' @param zoo zoo monitor tibble
#' @param beh_col name of column with behaviour info
#'
#' @return tibble with time, X, Y and behaviour
#' @export
clean_zoo <- function(zoo, beh_col = "none") {
  if (beh_col == "none") {
    behaviour <- zoo |>
      dplyr::select(dplyr::ends_with("Value")) |>
      dplyr::pull(1)
  } else {
    behaviour <- zoo |> dplyr::select(dplyr::all_of(beh_col)) |> dplyr::pull(1)
  }
  zoo <- zoo |>
    dplyr::select(
      time = dplyr::matches("DateTime"),
      X = dplyr::ends_with("Coordinate X"),
      Y = dplyr::ends_with("Coordinate Y")
    ) |>
    dplyr::mutate(
      behaviour = behaviour
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
# file <- fs::path_package("monitoR", "inst/example/example-zoo.xlsx")
# read_zoo(file, sheet = 2) |>
#   clean_zoo()
# read_zoo(
#   "inst/extdata/new-england-aquarium/2025-10-01-new-england-aquarium.xlsx"
# ) |>
#   # glimpse()
#   clean_zoo("SessionID")
