fixture <- function() {
  list(fields = data.frame(type = c('select_one yes-no', 'select_multiple color-list'),
                          name = c('consent', 'colors'), label = c('Consent?', 'Colors?')),
       choices = data.frame(list_name = c('yes-no', 'yes-no', 'color-list', 'color-list'),
                            name = c('01', '02', 'red', 'blue'),
                            label = c('Yes', 'No', 'Red', 'Blue')))
}

test_that('downloaded forms and CSVs work without an API account', {
  form <- fixture()
  fields <- read_questions(form)
  choices <- read_choices(form)
  path <- tempfile(fileext = '.csv')
  on.exit(unlink(path))
  writeLines(c('consent,colors_red,colors_blue,other', '01,1,,untouched', '02,0,1,text'), path)
  data <- scto_read_csv(path)
  expect_identical(data$consent, c('01', '02'))
  data <- singsel_label(data, fields)
  data <- singsel_asfactor(data, fields, choices)
  expect_identical(levels(data$consent), c('Yes', 'No'))
  expect_identical(attr(data$consent, 'label'), 'Consent?')
  data <- multisel_label(data, fields, choices)
  expect_identical(attr(data$colors_red, 'label'), 'Colors? ~ Red')
  expect_identical(as.vector(multisel_levels(data, fields, choices)$colors_blue), c(0L, 1L))
  expect_identical(as.vector(multisel_levels(data, fields, choices, 'boolean')$colors_blue), c(FALSE, TRUE))
  expect_identical(as.vector(multisel_levels(data, fields, choices, 'NA')$colors_blue), c(NA_integer_, 1L))
  expect_identical(multisel_levels(data, fields, choices)$other, data$other)
  expect_identical(attr(multisel_levels(data, fields, choices)$colors_red, 'label'), 'Colors? ~ Red')
})

test_that('choice mapping handles reused lists, numeric data and duplicate label text', {
  fields <- data.frame(type = c('select_one codes', 'select_one codes'), name = c('a', 'b'))
  choices <- data.frame(list_name = 'codes', value = c('1', '2'), label = c('Same', 'Same'))
  data <- singsel_asfactor(data.frame(a = c(1, 2), b = c('2', NA)), fields, choices)
  expect_identical(as.character(data$a), c('Same', 'Same'))
  expect_true(is.na(data$b[2]))
  expect_error(singsel_asfactor(data.frame(a = 3), fields, choices), 'Unknown choice')
  choices$value <- c('1', '1')
  expect_error(singsel_asfactor(data.frame(a = 1), fields, choices), 'unique')
})

test_that('invalid multiselect values and modes fail clearly', {
  form <- fixture()
  expect_error(multisel_levels(data.frame(colors_red = 'bad'), read_questions(form), read_choices(form)), 'Expected')
  expect_error(multisel_levels(data.frame(), read_questions(form), read_choices(form), 'bad'), 'arg')
})

test_that('API arguments are checked without network access', {
  expect_false(check_scto_api())
  expect_false(check_scto_api(list()))
  auth <- structure(list(), class = c('scto_auth', 'list'))
  expect_true(check_scto_api(auth))
  expect_error(scto_form('demo', list()), 'scto_auth')
  expect_error(scto_responses('', auth), 'non-empty')
})

test_that('public labelled validation works', {
  x <- haven::labelled(c(1, 2), c(Yes = 1, No = 2))
  expect_identical(validate_labelled(x), x)
})


test_that('Excel forms preserve text choice codes', {
  form <- scto_read_form(test_path('fixtures', 'form.xlsx'))
  expect_identical(read_questions(form)$name, 'consent')
  expect_identical(read_choices(form)$value, c('01', '02'))
})
