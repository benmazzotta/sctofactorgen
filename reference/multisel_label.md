# Apply variable labels to multiselects

Multiselects are complicated. They store responses to questions across
multiple columns. This function applies one label to each column,
indicating both the question text (label) and response (label). These
character strings are concatenated with a tilde `~` separator. To do
this, we process the labels first and then apply them to the columns of
the response data. At some point, I would like to have the ability to
provide the user the choice whether these are dummy variables `{0,1}`,
missing values, `{NA, 1}`, or booleans `{F, T}`.

## Usage

``` r
multisel_label(surveydata, thefields, thechoices)
```

## Arguments

- surveydata:

  a tibble with survey data as processed by `scto_responses`

- thefields:

  a tibble with survey fields as processed by `read_questions`

- thechoices:

  a tibble with choices as processed by `read_choices`

## Value

a tibble with variable labels for each column of a multiple_select
question

## Examples

``` r
NULL
#> NULL
```
