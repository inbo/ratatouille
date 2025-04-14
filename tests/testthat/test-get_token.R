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
