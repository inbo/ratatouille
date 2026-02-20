test_that("get_token() returns token with correct credentials", {
  # Need to be able to connect to API
  skip_if_offline(host = "gis.oost-vlaanderen.be")
  # Need to have credentials stored
  skip_if(Sys.getenv("RATO_USER") == "")
  skip_if(Sys.getenv("RATO_PWD") == "")

  expect_type(
    get_token(),
    "character"
  )

  # The returned tokens from RATO have a set length
  expect_identical(
    nchar(get_token()),
    192L
  )
})

test_that("get_token() supports source argument as enum", {
  
  
})

test_that("get_token() does not support multiple sources",{
  # Only one token can be fetched at a time.
})

test_that("get_token() can return token for RATO API", {
  
})

test_that("get_token() can return token for West Flanders API", {
  
})