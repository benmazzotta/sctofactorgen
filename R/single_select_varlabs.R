#' Label single select questions
#'
#' @param surveydata a tibble with survey data as processed by `scto_responses`
#' @param thefields a tibble with survey fields as processed by `read_questions`
#'
#' @return a tibble with survey data where single select variables have variable labels in the `label` attribute
#' @importFrom dplyr filter select
#' @importFrom tibble deframe
#' @importFrom labelled set_variable_labels
#' @export
#'
#' @examples NULL
singsel_label <-
  ## Two arguments: the data frame, the fields
  function(surveydata, thefields) {
    cat("Prepare a list of variable labels.\n")
    ## Filter the non-empty labels and store them a list.
    varlabs <- select(thefields, name, label) |> filter(label !="") |>
      deframe() |> as.list()
    ## And label the survey data with the variables.
    set_variable_labels(surveydata, .labels = varlabs, .strict = FALSE)
  }
