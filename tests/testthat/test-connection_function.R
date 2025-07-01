test_that("connect to the bakerbat_database", {
  expect_equal(con<-bakerbat_database_connect('/home/stella/Desktop/mycredentials.txt'), con)
})
