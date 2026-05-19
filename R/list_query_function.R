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


#' census_meta_data
#'
#' This function queries census_meta_data + census_technitians + technitians tables to create the final Census_Meta_Data table
#' @param database.connection.object The database connection object created with the bakerbat_database_connect() function
#' @keywords database tables
#' @return A vector of all tables in the bakerbat_database.
#' @export

census_meta_data <- function(database.connection.object) {
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


#' technitians
#'
#' This function queries census_technitians + technitians + activity_roles tables to create the final Technitians table
#' @param database.connection.object The database connection object created with the bakerbat_database_connect() function
#' @keywords database tables
#' @return A vector of all tables in the bakerbat_database.
#' @export

technitians <- function(database.connection.object) {
  query <- "
    SELECT 
        ct.census_id, 
        t.full_name, 
        t.initials, 
        GROUP_CONCAT(DISTINCT r.role_description SEPARATOR ', ') AS roles
    FROM census_technitians AS ct
    LEFT JOIN technitians AS t ON t.tech_id = ct.tech_id
    LEFT JOIN activity_roles AS r ON r.role_id = ct.role_id
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

#' census bat data function
#' This function queries general data of bats from the Bakerbat project
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
census_bat_data <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from census_bat_data")
  RMySQL::fetch(rs, n = -1)
}

#' tattoo information function
#' This function queries details of the tattooing activities during the Bakerbat project
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
census_tattoo_information <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from census_tattoo_information")
  RMySQL::fetch(rs, n = -1)
}


#' sample extracted function
#' This function queries details on the type of samples extracted during the Bakerbat project
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
census_sample_extracted <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from census_sample_extracted")
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


#' maternal colony experiment - metadata function
#' This function queries details on the metadata of the maternal colony experiment 
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
maternal_colony_exp_meta_data <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from maternal_colony_exp_meta_data")
  RMySQL::fetch(rs, n = -1)
}

#' maternal colony experiment - mom data function
#' This function queries general data of the mothers from the maternal colony experiment
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
maternal_colony_exp_mom_data <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from maternal_colony_exp_mom_data")
  RMySQL::fetch(rs, n = -1)
}



#' maternal colony experiment - mom sample extracted function
#' This function queries details on the type of samples extracted from the mothers of the maternal colony experiment 
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
maternal_colony_exp_mom_sample_extracted <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from maternal_colony_exp_mom_sample_extracted")
  RMySQL::fetch(rs, n = -1)
}


#' maternal colony experiment - mom tattoo information function
#' This function queries details of the tattooing activities conducted with the mothers from the maternal colony experiment
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
maternal_colony_exp_mom_tattoo_information <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from maternal_colony_exp_mom_tattoo_information")
  RMySQL::fetch(rs, n = -1)
}


#' maternal colony experiment - pup data function
#' This function queries general data of the pups from the maternal colony experiment
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
maternal_colony_exp_pup_data <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from maternal_colony_exp_pup_data")
  RMySQL::fetch(rs, n = -1)
}


#' maternal colony experiment - pup sample extracted function
#' This function queries details on the type of samples extracted from the pups of the maternal colony experiment 
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
maternal_colony_exp_pup_sample_extracted <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from maternal_colony_exp_pup_sample_extracted")
  RMySQL::fetch(rs, n = -1)
}


#' maternal colony experiment - pup tattoo information function
#' This function queries details of the tattooing activities conducted with the pups from the maternal colony experiment
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
maternal_colony_exp_pup_tattoo_information <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from maternal_colony_exp_pup_tattoo_information")
  RMySQL::fetch(rs, n = -1)
}


#' maternal colony experiment - registry function
#' This function queries details of the birthdays of pups from the maternal colony experiment
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
maternal_colony_exp_pup_registry <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from maternal_colony_exp_pup_registry")
  RMySQL::fetch(rs, n = -1)
}


#' maternal colony experiment - technitians function
#' This function queries details of the activities of each technitian during the maternal colony experiment
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
maternal_colony_exp_technitians <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from maternal_colony_exp_technitians")
  RMySQL::fetch(rs, n = -1)
}

#' maternal colony experiment - mom-pup-pair function
#' This function shows details of the mom-pup pairs from the maternal colony experiment
#' @param database.connection.object The database connection object created with the new_preempt_database_connect() function
#'
#' @return a dataframe
#' @export
#'
#'
mom_pup_pair <- function(database.connection.object) {
  rs <-  RMySQL::dbSendQuery(database.connection.object, "select * from mom_pup_pair")
  RMySQL::fetch(rs, n = -1)
}

