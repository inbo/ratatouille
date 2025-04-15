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

