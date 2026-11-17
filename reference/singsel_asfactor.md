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

## Value

a tibble with survey data where single select variables have variable
labels in the `label` attribute

## Examples

``` r
NULL
#> NULL
```
