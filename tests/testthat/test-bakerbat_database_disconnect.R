test_that("disconnect from the bakerbat_database", {
dbcon <- RMySQL::dbConnect(RMySQL::MySQL(), dbname = "bakerbat_database", host = "preempt-database.cy5swjbpwcs6.us-west-2.rds.amazonaws.com", user = "wyattmadden", password = "55bf4yrzr8faag4xuz56x24nb")
tt<-RMySQL::dbReadTable(dbcon, 'Census_meta')
bakerbat_database_disconnect(dbcon)
expect_error(RMySQL::dbGetQuery(dbcon, "SELECT * FROM Census_meta;"))
})
