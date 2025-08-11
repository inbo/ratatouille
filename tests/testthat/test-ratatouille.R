test_that("ratatouille supports fetching data from rato", {
  skip_if_offline(host = "gis.oost-vlaanderen.be")
  skip_if(Sys.getenv("RATO_USER") == "")
  skip_if(Sys.getenv("RATO_PWD") == "")

  expect_s3_class(
    ratatouille(source = "rato"),
    "data.frame"
  )
})

test_that("ratatouille returns error on invalid source", {
  expect_error(
    ratatouille(source = "not a source"),
    regexp = "`source` must be one of"
  )
})

test_that("ratatouille can pass on arguments to its internal helpers", {
  my_object_ids <- sample(list_object_ids(), size = 5)
  
  expect_s3_class(
    ratatouille(object_ids = my_object_ids,
                batch_size = 1),
    "data.frame"
  )
})
