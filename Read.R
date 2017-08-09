library(RMySQL)

conn <- RMySQL::dbConnect(RMySQL::MySQL(), "stocks", "root")
RMySQL::dbGetInfo(conn)
RMySQL::dbListTables(conn)

# Return a data frame representation of MySQL table
securities <- RMySQL::dbReadTable(conn, "securities")
prices     <- RMySQL::dbReadTable(conn, "prices_split")


mostGrowth <- dbFetch(dbSendQuery(conn, 
  "SELECT symbol, stddev(high) as SD, max(high) - min(low) as growth 
  	FROM prices_split 
    GROUP BY symbol 
    ORDER BY SD DESC LIMIT 10;")
)

# clear MySQL connection
dbClearResult(dbListResults(conn)[[1]])

lowestGrowth <- dbFetch(dbSendQuery(conn,
  "SELECT * FROM
  (
    SELECT symbol, max(high)-min(low) AS growth FROM prices_split
    GROUP BY symbol
  ) AS subTable ORDER BY growth ASC LIMIT 1;"
))

# clear MySQL connection
dbClearResult(dbListResults(conn)[[1]])

HgrowthPrices <- dbFetch(dbSendQuery(conn,"Select * FROM prices_split WHERE symbol = 'AGN';"))

# clear MySQL connection
dbClearResult(dbListResults(conn)[[1]])

LgrowthPrices <- dbFetch(dbSendQuery(conn,
  paste("Select * FROM prices_split WHERE symbol = '", lowestGrowth[[1]], "';", sep = "")))

# clear MySQL connection
dbClearResult(dbListResults(conn)[[1]])

HProfitPrices <- dbFetch(dbSendQuery(conn,
      "SELECT Profit_Margin, fundamentals.symbol, open, date 
      FROM fundamentals JOIN prices_split ON fundamentals.symbol = prices_split.symbol
      ORDER BY Profit_Margin DESC;"))

# clear MySQL connection
dbClearResult(dbListResults(conn)[[1]])

AMZNEarnings <- dbFetch(dbSendQuery(conn,
      "SELECT MAX(high) - min(low) growth, capital_expenditures, YEAR(date), Earnings_Before_Tax, fundamentals.symbol FROM 
  	  prices_split join fundamentals on
      prices_split.symbol = fundamentals.symbol AND For_Year = YEAR(date)  
      WHERE prices_split.symbol = \"AMZN\"
      GROUP BY symbol, YEAR(date) LIMIT 10;"))

RMySQL::dbDisconnect(conn)


# Point plot of growth vs standard deviation of top 'growth' stocks.
ggplot(mostGrowth, aes(SD, growth, colour = symbol)) +
  geom_point() +
  ggtitle("Growth vs. volatility")

# Line graph of highest growth and lowest growth stocks
  # create graphable data
HLgraphData <- data.frame(high  = HgrowthPrices['open'][[1]],
                          low   = LgrowthPrices['open'][[1]],
                          dates = as.Date(HgrowthPrices['date'][[1]]))

ggplot(HLgraphData, aes(dates)) + 
  geom_line(aes(y = high, color = "AES")) +
  geom_line(aes(y = low,  color = "FTR")) +
  ylab("Price") + xlab("Date") +
  ggtitle("Highest and Lowest Growth")

# Create matrix for rectangle sizes.
rectDims <- matrix(
  c(
    abs(AMZNEarnings$Earnings_Before_Tax) / max(abs(AMZNEarnings$Earnings_Before_Tax)),
    abs(AMZNEarnings$capital_expenditures) / max(abs(AMZNEarnings$capital_expenditures))),
  nrow = length(AMZNEarnings$capital_expenditures),
  ncol = 2)

# Rectangle plot
symbols(x = AMZNEarnings$`YEAR(date)`, 
        y = AMZNEarnings$growth, 
        rectangles = rectDims, 
        xlab = 'year', 
        ylab = 'earnings',
        main = 'AMZN Absolute expenditure/earnings vs. Growth per year',
        fg = "red", #colour(s) the symbols are to be drawn in.
        ylim = c(20,600), xlim = c(2012.5,2015.8)
)
