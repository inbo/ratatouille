test_that("get_token() returns token with correct credentials", {
  # Need to be able to connect to API
  skip_if_offline(host = "gis.oost-vlaanderen.be")
  # Need to have credentials stored
  skip_if(Sys.getenv("RATO_USER") == "")
  skip_if(Sys.getenv("RATO_PWD") == "")

  expect_type(
    get_token("rato"),
    "character"
  )

  # The returned tokens from RATO have a set length
  expect_identical(
    nchar(get_token("rato")),
    192L
  )
})

test_that("get_token() can forward authentication errors", {
  # Need to be able to connect to API
  skip_if_offline(host = "gis.oost-vlaanderen.be")

  withr::with_envvar(
    new = c(
      "RATO_USER" = "not_a_username",
      "RATO_PWD" = "the_incorrect_pwd"
    ),
    code = {
      # don't use cache!
      memoise::forget(get_token)

      expect_error(
        get_token("rato"),
        class = "rata_auth_error"
      )
    }
  )
})

test_that("get_token() supports source argument as enum", {
  expect_type(
    get_token(source = "rato"),
    "character"
  )
  expect_type(
    get_token(source = "wfl"),
    "character"
  )
})

test_that("get_token() does not support multiple sources", {
  # Only one token can be fetched at a time.
  expect_error(
    get_token(source = c("rato", "wfl")),
    class = "rata_multiple_sources"
  )
})

test_that("get_token() can return token for RATO API", {
  expect_type(
    get_token("rato"),
    "character"
  )
})

test_that("get_token() can return token for West Flanders API", {
  expect_type(
    get_token("wfl"),
    "character"
  )
})
