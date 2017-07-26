CREATE DATABASE IF NOT EXISTS stocks;

use stocks;

# Reset the Database
SET foreign_key_checks =0;
DROP TABLE IF EXISTS securities;
DROP TABLE IF EXISTS prices;
DROP TABLE IF EXISTS prices_split;
DROP TABLE IF EXISTS fillings;
DROP TABLE IF EXISTS fundamentals;
SET foreign_key_checks =1;

# Create tables
# Data gathered from https://www.kaggle.com/dgawlik/nyse

# general description of each company with division on sectors
CREATE TABLE securities 
(
	symbol VARCHAR(5) PRIMARY KEY,
	Security VARCHAR(20) NOT NULL,
	SEC_filings CHAR(7) NOT NULL,
	GICS_Sector VARCHAR(20) NOT NULL,
	GICS_Sub_Industry VARCHAR(30) NOT NULL,
	Address VARCHAR(25) NOT NULL,
	Date_first_added DATE,
	CIK INT NOT NULL
);

# raw, as_is daily prices. Most of data spans from 2010 to the end 2016,
# for companies new on stock market date range is shorter. There have 
# been approx. 140 stock splits in that time, this set doesn't account for that.

CREATE TABLE prices
(
	date DATE NOT NULL,
	symbol VARCHAR(5)  NOT NULL,
	open  DECIMAL(10,6) NOT NULL,
	close DECIMAL(10,6) NOT NULL,
	low   DECIMAL(10,6) NOT NULL,
	high  DECIMAL(10,6) NOT NULL,
	volume INT,
	CONSTRAINT FOREIGN KEY (symbol) REFERENCES securities(symbol)
		ON DELETE CASCADE
		ON UPDATE CASCADE, 
	CONSTRAINT PRIMARY KEY  (date, symbol)
);

# same as prices, but there have been added adjustments for splits.
CREATE TABLE prices_split
(
	date DATE NOT NULL,
	symbol VARCHAR(5) NOT NULL,
	open  DECIMAL(10,6) NOT NULL,
	close DECIMAL(10,6) NOT NULL,
	low   DECIMAL(10,6) NOT NULL,
	high  DECIMAL(10,6) NOT NULL,
	volume INT,
	CONSTRAINT FOREIGN KEY (symbol) REFERENCES securities (symbol)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT PRIMARY KEY (date, symbol)
);

# SEC 10K annual fillings (2016_2012)
CREATE TABLE fundamentals (
	ID INT PRIMARY KEY,
	Symbol VARCHAR(5) NOT NULL,
	Period_Ending DATE NOT NULL,
	Accounts_Payable BIGINT NOT NULL,
	Accounts_Receivable BIGINT NOT NULL,
	Add_income_expenses BIGINT NOT NULL,
	After_Tax_ROE SMALLINT NOT NULL,
	Capital_Expenditures BIGINT NOT NULL,
	Capital_Surplus BIGINT NOT NULL,
	Cash_Ratio SMALLINT NOT NULL,
	CC_Equivalents BIGINT NOT NULL,
	Changes_in_Inventories BIGINT NOT NULL,
	Common_Stocks BIGINT NOT NULL,
	Cost_of_Revenue BIGINT NOT NULL,
	Current_Ratio SMALLINT,
	Deferred_Asset_Charges BIGINT NOT NULL,
	Deferred_Liability_Charges BIGINT NOT NULL,
	Depreciation BIGINT NOT NULL,
	Earnings_Before_Interest_and_Tax BIGINT NOT NULL,
	Earnings_Before_Tax INT NOT NULL,
	Effect_of_Exchange_Rate BIGINT NOT NULL,
	Equity_Earnings_Loss_Unconsolidated_Subsidiary BIGINT NOT NULL,
	Fixed_Assets BIGINT NOT NULL,
	Goodwill BIGINT NOT NULL,
	Gross_Margin TINYINT NOT NULL,
	Gross_Profit BIGINT NOT NULL, 
 	Income_Tax BIGINT NOT NULL,
 	Intangible_Assets BIGINT NOT NULL,
 	Interest_Expense BIGINT NOT NULL,
 	Inventory BIGINT NOT NULL,
 	Investments BIGINT NOT NULL,
 	Liabilities BIGINT NOT NULL,
 	Long_Term_Debt BIGINT NOT NULL,
 	Long_Term_Investments BIGINT NOT NULL,
 	Minority_Interest BIGINT NOT NULL,
 	Misc_Stocks BIGINT NOT NULL,
 	Net_Borrowings BIGINT NOT NULL,
 	Net_Cash_Flow BIGINT NOT NULL,
 	Net_Cash_Flow_Operating BIGINT NOT NULL,
 	Net_Cash_Flows_Financing BIGINT NOT NULL,
 	Net_Cash_Flows_Investing BIGINT NOT NULL,
 	Net_Income BIGINT NOT NULL,
 	Net_Income_Adjustments BIGINT NOT NULL,
 	Net_Income_Applicable_to_Common_Shareholders BIGINT NOT NULL,
 	Net_Income_Cont_Operations BIGINT NOT NULL,
 	Net_Receivables BIGINT NOT NULL,
 	Non_Recurring_Items BIGINT NOT NULL,
 	Operating_Income BIGINT NOT NULL,
 	Operating_Margin SMALLINT NOT NULL,
 	Other_Assets BIGINT NOT NULL,
 	Other_Current_Assets BIGINT NOT NULL,
 	Other_Current_Liabilities BIGINT NOT NULL,
 	Other_Equity BIGINT NOT NULL,
 	Other_Financing_Activities BIGINT NOT NULL,
 	Other_Investing_Activities BIGINT NOT NULL,
 	Other_Liabilities BIGINT NOT NULL,
 	Other_Operating_Activities BIGINT NOT NULL,
 	Other_Operating_Items BIGINT NOT NULL,
 	PreTax_Margin SMALLINT NOT NULL,
 	PressTax_ROE SMALLINT NOT NULL,
 	Profit_Margin SMALLINT NOT NULL,
 	Quick_Ratio SMALLINT,
 	Research_and_Development BIGINT NOT NULL,
 	Retained_Earnings BIGINT NOT NULL,
 	Sale_and_Purchase_of_Stock BIGINT NOT NULL,
 	Sales_General_and_Admin BIGINT NOT NULL,
 	STD_Current_Portion_of_Long_Term_Debt BIGINT NOT NULL,
 	Short_Term_Investments BIGINT NOT NULL,
 	Total_Assets BIGINT NOT NULL,
 	Total_Current_Assets BIGINT NOT NULL,
 	Total_Current_Liabilities BIGINT NOT NULL,
 	Total_Equity BIGINT NOT NULL,
 	Total_Liabilities BIGINT NOT NULL,
 	Total_Liabilities_Equity BIGINT NOT NULL,
 	Total_Revenue BIGINT NOT NULL,
 	Treasury_Stock TINYINT NOT NULL,
 	For_Year SMALLINT,
 	Earnings_Per_Share TINYINT,
 	Estimated_Shares_Outstanding BIGINT
 );
