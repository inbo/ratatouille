# Don't actually get all records for tests: mock listing function to only return
# 50 random records instead of all
local_mocked_bindings(
  list_object_ids = function(...) {sample(list_object_ids(...), size = 50)}
)

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
  expect_s3_class(
    ratatouille(batch_size = 1),
    "data.frame"
  )
})
