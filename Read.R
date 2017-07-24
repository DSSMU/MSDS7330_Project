#install.packages("sqldf")

library(sqldf)

sqldf('show tables')

sqldf('SELECT COUNT(*) FROM stocks.securites')

# install.packages("RMySQL")
library(RMySQL)

conn <- RMySQL::dbConnect(RMySQL::MySQL(), "stocks", "root")
RMySQL::dbGetInfo(conn)
RMySQL::dbListTables(conn)

# Return a data frame representation of MySQL table
securities <- RMySQL::dbReadTable(conn, "securities")


