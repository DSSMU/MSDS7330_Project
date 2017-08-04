SELECT max(open), min(open), avg(open) FROM prices_split;
SELECT max(close), min(close), avg(close), stddev(close) FROM prices_split;
SELECT max(low), min(low), avg(low), stddev(low) FROM prices_split;
SELECT max(high), min(high), avg(high), stddev(high) FROM prices_split;
SELECT max(volume), min(volume), avg(volume), stddev(volume) FROM prices_split;
SELECT symbol, stddev(high) as SD, max(high) - min(low) as growth 
	FROM prices_split 
	GROUP BY symbol 
	ORDER BY SD DESC LIMIT 10;
