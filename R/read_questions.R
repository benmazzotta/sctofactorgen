## This function reads the question list from a SurveyCTO data collection form.
#' @title Read the questions from SurveyCTO fields
#' @description
#' This function reads the question list from a SurveyCTO data collection form.
#' The form is available from SurveyCTO. When downloaded from the API, it has four parts.
#' The question list is in the element titled "fields".
#' This function will declass the data.table so that it plays nicely with dplyr and tibble.
#'
#' @param theform a SurveyCTO form as returned by `scto_form`
#'
#' @return a tibble of response lists, names, and values
#' @importFrom janitor clean_names
#' @importFrom tibble as_tibble
#' @importFrom dplyr rename_with
#' @export
#'
#' @examples NULL
read_questions <-
  ## It takes a single argument, the data collection form returned by SurveyCTO's R package
  function(theform) {
    ## Select the "fields" element. Reclass as a tibble.
    as.data.frame(theform$fields) |> as_tibble() |>
      ## Remove redundant naming fields
      rename_with(~str_remove(., "fields\\.")) |>
      ## Clean the names so it plays nicely with other software.
      clean_names()
  }

