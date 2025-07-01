#' List Tables Available
#'
#' This function lists all currently available tables in the bakerbat_database.
#' @param database.connection.object The database connection object created with the preempt_database_connect() function
#' @keywords database tables
#' @return A vector of all tables in the bakerbat_database.
#' @export

list_bakerbat_database_tables <- function(database.connection.object) {
  RMySQL::dbListTables(database.connection.object)
}

