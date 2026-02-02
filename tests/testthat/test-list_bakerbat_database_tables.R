test_that("list all tables from the database", {
 dbcon <- RMySQL::dbConnect(RMySQL::MySQL(), dbname = "bakerbat_database", host = "preempt-database.cy5swjbpwcs6.us-west-2.rds.amazonaws.com", user = "wyattmadden", password = "55bf4yrzr8faag4xuz56x24nb")
 tt<-list_bakerbat_database_tables(dbcon)
 expect_type(tt, "character")
 RMySQL::dbDisconnect(dbcon)
})
