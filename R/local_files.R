#' Read a downloaded SurveyCTO form
#' @param path Path to an XLS or XLSX form containing survey and choices sheets.
#' @return A list with fields and choices tables, compatible with scto_form().
#' @export
scto_read_form <- function(path) {
  sheets <- readxl::excel_sheets(path)
  if (!all(c("survey", "choices") %in% sheets))
    stop("Form must contain survey and choices sheets.", call. = FALSE)
  list(fields = readxl::read_excel(path, sheet = "survey", col_types = "text"),
       choices = readxl::read_excel(path, sheet = "choices", col_types = "text"))
}

#' Read downloaded SurveyCTO responses
#' @param path Path to a CSV export containing raw choice codes.
#' @return A data frame with character columns, preserving choice codes.
#' @export
scto_read_csv <- function(path) {
  utils::read.csv(path, colClasses = "character", check.names = FALSE,
                  na.strings = "", fileEncoding = "UTF-8-BOM")
}
