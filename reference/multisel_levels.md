# Convert multi select variables to factors

Convert multi select variables to factors

## Usage

``` r
multisel_levels(surveydata, thefields, thechoices, na_value = "zero")
```

## Arguments

- surveydata:

  a tibble with survey data as processed by `scto_responses`

- thefields:

  a tibble with survey fields as processed by `read_questions`

- thechoices:

  a tibble with choices as processed by `read_choices`

- na_value:

  a character string, one of `"zero"`, `"boolean"`, or `"NA"`

## Value

a tibble with survey data where single select variables have variable
labels in the `label` attribute

## Examples

``` r
NULL
#> NULL
```
