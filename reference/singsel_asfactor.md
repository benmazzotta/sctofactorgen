# Convert single select variables to factors

Convert single select variables to factors

## Usage

``` r
singsel_asfactor(surveydata, thefields, thechoices)
```

## Arguments

- surveydata:

  a tibble with survey data as processed by `scto_responses`

- thefields:

  a tibble with survey fields as processed by `read_questions`

- thechoices:

  a tibble with choices as processed by `read_choices`

  Duplicate display labels become a single factor level, as in base R.
  Unknown response codes produce an error.

## Value

Survey data with single select factors in form choice order.

## Examples

``` r
NULL
#> NULL
```
