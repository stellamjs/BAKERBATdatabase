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


#' Technitians
#'
#' This function queries census_technitians + technitians + census_roles tables to create the final Technitians table
#' @param database.connection.object The database connection object created with the bakerbat_database_connect() function
#' @keywords database tables
#' @return A vector of all tables in the bakerbat_database.
#' @export

Technitians <- function(database.connection.object) {
  query <- "
    SELECT 
        ct.census_id, 
        t.full_name, 
        t.initials, 
        GROUP_CONCAT(DISTINCT r.role_description SEPARATOR ', ') AS roles
    FROM census_technitians AS ct
    LEFT JOIN technitians AS t ON t.tech_id = ct.tech_id
    LEFT JOIN census_roles AS r ON r.role_id = ct.role_id
    GROUP BY ct.census_id, t.full_name, t.initials;
  "
  tryCatch({
    df_roles <- DBI::dbGetQuery(database.connection.object, query)
    return(df_roles)
  }, error = function(e) {
    message("Error en la consulta de roles: ", e$message)
    return(NULL)
  })
}

#' Bat Data function
#' This function queries general data of bats from the Bakerbat project
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
Bat_Data <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from bat_data")
  RMySQL::fetch(rs, n = -1)
}

#' Tattoo Information function
#' This function queries details of the tattooing activities during the Bakerbat project
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
Tattoo_Information <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from tattoo_information")
  RMySQL::fetch(rs, n = -1)
}


#' Sample Extracted function
#' This function queries details on the type of samples extracted during the Bakerbat project
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
Sample_Extracted <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from sample_extracted")
  RMySQL::fetch(rs, n = -1)
}


#' RIP function
#' This function queries the id and date when the bats passed
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
RIP <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from RIP")
  RMySQL::fetch(rs, n = -1)
}
