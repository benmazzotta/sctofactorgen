#' Validate a labelled vector
#'
#' Compatibility helper. Validation follows the public haven constructor.
#' @param x A labelled vector.
#' @return The validated vector.
#' @export
validate_labelled <- function(x) {
  haven::labelled(as.vector(x), labels = attr(x, "labels"), label = attr(x, "label", exact = TRUE))
  x
}
