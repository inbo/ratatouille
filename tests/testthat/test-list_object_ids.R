test_that("list_object_ids() returns a character vector of length > 1", {
  # Assuming there is more than one record in the West Flanders (wfl) source/API

  # Need to be able to connect to API
  skip_if_offline(host = "gwadmin.west-vlaanderen.be")
  # Need to have credentials stored
  skip_if(Sys.getenv("WFL_USER") == "")
  skip_if(Sys.getenv("WFL_PWD") == "")

  object_ids <- list_object_ids(source = "wfl")

  expect_gte(
    length(object_ids),
    1L
  )

  expect_type(
    object_ids,
    "integer"
  )
})
