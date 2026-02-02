test_that("connect to the bakerbat_database", {
  con<-bakerbat_database_connect('/home/stella/Desktop/mycredentials.txt')
  expect_s4_class(con, "MySQLConnection")
  tt<-RMySQL::dbReadTable(con, 'Census_meta')
  expect_type(tt, "list")
  RMySQL::dbDisconnect(con)
  })
