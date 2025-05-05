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
    as.POSIXct(c(
      "2024-11-08 08:30:00 CET",
      "2022-10-06 15:46:40 CEST",
      "2024-11-20 08:50:00 CET",
      "2023-02-13 10:03:20 CET",
      "2025-02-06 14:03:20 CET"
    ))
  )
})