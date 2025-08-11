test_that("get_objects() can retreive a single object", {
  # Need to be able to connect to API
  skip_if_offline(host = "gis.oost-vlaanderen.be")
  # Need to have credentials stored
  skip_if(Sys.getenv("RATO_USER") == "")
  skip_if(Sys.getenv("RATO_PWD") == "")
  
  
  expect_s3_class(
    get_objects(list_object_ids()[1]),
    "data.frame"
  )
  
})

test_that("get_objects() returns one row for every input object_id", {
  # Need to be able to connect to API
  skip_if_offline(host = "gis.oost-vlaanderen.be")
  # Need to have credentials stored
  skip_if(Sys.getenv("RATO_USER") == "")
  skip_if(Sys.getenv("RATO_PWD") == "")
  
  # Store 25 random object ids for testing
  object_ids <- sample(list_object_ids(), size = 25)
  
  expect_length(
   get_objects(object_ids)[[1]], # compare length of values of first column
   length(object_ids)
  )
})

test_that("get_objects() warns for batch sizes above 50", {
  # Store 25 random object ids for testing
  object_ids <- sample(list_object_ids(), size = 25)
  
  expect_warning(
    get_objects(object_ids, batch_size = 51),
    regexp = "Batch size is set to a higher than default value"
  )
})

test_that("get_objects() can fallback on dplyr if data.table is not installed", {
  # Implement with mocked binding or with withr::with_libpath ?
})