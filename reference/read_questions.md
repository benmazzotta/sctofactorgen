# Read the questions from SurveyCTO fields

This function reads the question list from a SurveyCTO data collection
form. The form is available from SurveyCTO. When downloaded from the
API, it has four parts. The question list is in the element titled
"fields". This function will declass the data.table so that it plays
nicely with dplyr and tibble.

## Usage

``` r
read_questions(theform)
```

## Arguments

- theform:

  a SurveyCTO form as returned by `scto_form`

## Value

a tibble of response lists, names, and values

## Examples

``` r
NULL
#> NULL
```
