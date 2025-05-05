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
