#' @title Extract response choices from a form definition
#' @description
#' The form is available from the SurveyCTO.
#' It has three parts, including settings, fields, and choices.
#' We restructure this with dplyr and janitor so that it works nicely with other packages.
#'
#'
#' @param theform A survey form as imported by `scto_form`
#'
#' @return a tibble with response choices named as they appear on the XLS form `choices`
#' @export
#' @importFrom tibble as_tibble
#' @importFrom stringr str_remove
#' @importFrom dplyr rename_with
#' @importFrom janitor clean_names
#'
#' @examples NULL
read_choices <-
  ## It takes a single argument, the data collection form returned by SurveyCTO's R package
  function(theform) {
    ## Select the second element. Reclass as a tibble.
    as.data.frame(theform$choices) |> as_tibble() |>
      ## Remove redundant naming fields
      rename_with(~str_remove(., "choices\\.")) |>
      ## Clean the names so it plays nicely with other software.
      clean_names()
  }

