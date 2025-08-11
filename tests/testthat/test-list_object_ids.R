test_that("list_object_ids() returns a character vector of length > 1", {
  # Assuming there is more than one record in the RATO database

  # Need to be able to connect to API
  skip_if_offline(host = "gis.oost-vlaanderen.be")
  # Need to have credentials stored
  skip_if(Sys.getenv("RATO_USER") == "")
  skip_if(Sys.getenv("RATO_PWD") == "")

  object_ids <- list_object_ids()

  expect_gte(
    length(object_ids),
    1L
  )

  expect_type(
    object_ids,
    "integer"
  )
})
