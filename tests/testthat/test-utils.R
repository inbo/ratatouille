test_that("as_datetime() returns a POSIXct object", {
  expect_s3_class(
    as_datetime(1.729841e+12),
    "POSIXct"
  )
})

test_that("as_datetime() succesfully converts a few known examples", {
  expect_identical(
    as_datetime(c(
      1.731051e+12,
      1.665064e+12,
      1.732089e+12,
      1.676279e+12,
      1.738847e+12
    )),
    as.POSIXct(
      c(
        "2024-11-08 07:30:00 UTC",
        "2022-10-06 13:46:40 UTC",
        "2024-11-20 07:50:00 UTC",
        "2023-02-13 09:03:20 UTC",
        "2025-02-06 13:03:20 UTC"
      ),
      tz = "UTC"
    )
  )
})

test_that("get_api_domain() returns correct API base urls", {
  expect_identical(
    get_api_domain("rato"),
    "https://gis.oost-vlaanderen.be"
  )
  expect_identical(
    get_api_domain("wfl"),
    "https://gwadmin.west-vlaanderen.be"
  )
})

test_that("get_api_domain() returns error on multiple sources", {
  expect_error(
    get_api_domain(c("rato", "wfl")),
    class = "rata_multiple_sources"
  )
})

test_that("check_credentials() returns an error if credentials are unset", {
  withr::with_envvar(
    new = c("RATO_PWD" = ""),
    code = {
      expect_error(
        check_credentials("rato"),
        class = "rata_no_credentials_set"
      )
    }
  )

  withr::with_envvar(
    new = c("RATO_USER" = ""),
    code = {
      expect_error(
        check_credentials("rato"),
        class = "rata_no_credentials_set"
      )
    }
  )

  withr::with_envvar(
    new = c("WFL_USER" = ""),
    code = {
      expect_error(
        check_credentials("wfl"),
        class = "rata_no_credentials_set"
      )
    }
  )

  withr::with_envvar(
    new = c("WFL_PWD" = ""),
    code = {
      expect_error(
        check_credentials("wfl"),
        class = "rata_no_credentials_set"
      )
    }
  )

  withr::with_envvar(
    new = c("WFL_USER" = "a_username",
            "WFL_PWD" = "a_password",
            "RATO_USER" = "",
            "RATO_PWD" = ""),
    code = {
      expect_true(
        check_credentials("wfl")
      )

      expect_error(
        check_credentials("rato"),
        class = "rata_no_credentials_set"
      )
    }
  )
})

test_that("check_source() returns error on multiple sources", {
  expect_error(
    check_source(c("rato", "wfl")),
    class = "rata_multiple_sources"
  )
})

test_that("check_source() returns error on invalid source", {
  expect_error(
    check_source("invalid_source"),
    class = "rlang_error"
  )
})

test_that("check_source() returns error on missing source", {
  expect_error(
    check_source(),
    class = "rata_no_source_specified"
  )
})
