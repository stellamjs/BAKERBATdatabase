## bakerbat_database connecting function
#' This function simplifies connecting with the bakerbat_database. It calls the username
#' and password saved as a .txt file with username as the first line and password as the second line.
#' Make sure there is not superfluous white space in this text file.
#' @param username.password.file.path The path of the text file containing the username and password to the database account
#' @param suppress.bat Set to TRUE 
#'
#' @return The database connection object 
#' @export
#'


bakerbat_database_connect <- function(username.password.file.path, suppress.bat = T) {
  credentials <- suppressWarnings(read.delim(username.password.file.path, header = F))

  my_username <- as.character(credentials[1, 1])
  my_password <- as.character(credentials[2, 1])

  mydb <- "temp"
  mydb = RMySQL::dbConnect(RMySQL::MySQL(),
                           user = my_username,
                           password = my_password,
                           dbname = 'bakerbat_database',
                           host = "preempt-database.cy5swjbpwcs6.us-west-2.rds.amazonaws.com")

  if (!is.character(mydb) & !(suppress.bat)) {
    cat("Success! Thank you for connecting with the bakerbat_database"
    )
  }
  return(mydb)
}


#' Disconnect from the bakerbat_database
#'
#' @param database.connection.object The database connection object created with the bakerbat_database_connect() function
#'
#' @return message indicating disconnecting from bakerbat_database
#' @export
#'
#'
bakerbat_database_disconnect <- function(database.connection.object) {
  test <- RMySQL::dbDisconnect(database.connection.object)
  if (test) {
    print("You are now disconnected from the bakerbat_database.")
  }
}


