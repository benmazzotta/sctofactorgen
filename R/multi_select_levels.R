## Multiselects are generally 1-vs-NA encoded.
## We could think about what belongs in the NA.

## Approach 1: boolean
## Approach 2: 1-0
## Approach 3: Record the multiselect value in the column head


#' Convert expanded multi select indicators
#'
#' @param surveydata a tibble with survey data as processed by `scto_responses`
#' @param thefields a tibble with survey fields as processed by `read_questions`
#' @param thechoices a tibble with choices as processed by `read_choices`
#' @param na_value a character string, one of `"zero"`, `"boolean"`, or `"NA"`
#'
#' @return Survey data with integer or logical multiselect indicators, preserving variable labels.
#' @importFrom dplyr filter select mutate right_join relocate transmute
#' @importFrom tidyr nest replace_na
#' @importFrom tibble deframe
#' @importFrom stringr str_extract
#' @importFrom labelled set_variable_labels
#' @export
#'
#' @examples NULL
multisel_levels <- function(surveydata, thefields, thechoices, na_value = "zero") {
  na_value <- match.arg(na_value, c("zero", "boolean", "NA"))
  questions <- thefields[grepl("^select_multiple\\s+", thefields$type), , drop = FALSE]
  for (i in seq_len(nrow(questions))) {
    list_name <- sub("^select_multiple\\s+([^[:space:]]+).*$", "\\1", questions$type[i])
    codes <- thechoices$value[thechoices$list_name == list_name]
    columns <- intersect(paste(questions$name[i], codes, sep = "_"), names(surveydata))
    for (column in columns) {
      x <- as.character(surveydata[[column]])
      if (any(!is.na(x) & !x %in% c("", "0", "1")))
        stop("Expected 0, 1 or missing values in ", column, call. = FALSE)
      label <- attr(surveydata[[column]], "label")
      x[x == ""] <- NA_character_
      value <- as.integer(x)
      if (na_value != "NA") value[is.na(value)] <- 0L
      if (na_value == "boolean") value <- as.logical(value)
      surveydata[[column]] <- value
      attr(surveydata[[column]], "label") <- label
    }
  }
  surveydata
}
