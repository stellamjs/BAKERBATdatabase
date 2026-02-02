#' List Tables Available
#'
#' This function lists all currently available tables in the bakerbat_database.
#' @param database.connection.object The database connection object created with the bakerbat_database_connect() function
#' @keywords database tables
#' @return A vector of all tables in the bakerbat_database.
#' @export

list_bakerbat_database_tables <- function(database.connection.object) {
  RMySQL::dbListTables(database.connection.object)
}


#' Census_Meta_Data
#'
#' This function queries census_meta_data + census_technitians + technitians tables to create the final Census_Meta_Data table
#' @param database.connection.object The database connection object created with the bakerbat_database_connect() function
#' @keywords database tables
#' @return A vector of all tables in the bakerbat_database.
#' @export

Census_Meta_Data <- function(database.connection.object) {
  query <- "
    SELECT 
      m.census_id, 
      m.date, 
      m.time_start, 
      m.time_end, 
      GROUP_CONCAT(DISTINCT t.full_name SEPARATOR '_') AS technitians, 
      m.notes
    FROM census_meta_data AS m
    LEFT JOIN census_technitians AS ct ON ct.census_id = m.census_id
    LEFT JOIN technitians AS t ON t.tech_id = ct.tech_id
    GROUP BY m.census_id;
  "
tryCatch({
    result <- DBI::dbGetQuery(database.connection.object, query)
    return(result)
  }, error = function(e) {
    message("Error al ejecutar la consulta: ", e$message)
    return(NULL)
  })
}
