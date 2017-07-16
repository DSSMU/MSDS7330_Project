
use stocks;


LOAD DATA LOCAL INFILE '/Users/Ethan/Desktop/nyse/securities.csv' INTO TABLE securities
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/Users/Ethan/Desktop/nyse/prices.csv' INTO TABLE prices
FIELDS TERMINATED BY ',' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/Users/Ethan/Desktop/nyse/prices-split-adjusted.csv' INTO TABLE prices_split
FIELDS TERMINATED BY ',' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/Users/Ethan/Desktop/nyse/fundamentals.csv' INTO TABLE fundamentals
FIELDS TERMINATED BY ',' IGNORE 1 LINES;

