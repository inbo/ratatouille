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

test_that("get_token() returns error on missing username/password", {
  expect_error(
    get_token(username = ""),
    class = "rato_no_pwd_provided"
  )
  expect_error(
    get_token(password = ""),
    class = "rato_no_pwd_provided"
  )
  expect_error(
    get_token(username = "", password = ""),
    class = "rato_no_pwd_provided"
  )
  expect_error(
    get_token(username = "myuserid", password = ""),
    class = "rato_no_pwd_provided"
  )
})
