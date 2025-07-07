SELECT state
FROM customer
WHERE state IS NOT NULL;

-- What is the title of the albumid=67 ?
SELECT title
FROM album
WHERE album_id = 67;

-- Find the name and length (in seconds) of all track that have length between 50 and 70
SELECT name, milliseconds/1000 AS seconds
FROM track
WHERE milliseconds/1000 BETWEEN 50 AND 70;

-- List all the album by artist with a black in their name
SELECT album.artist_id, artist.name AS name, album.title AS album_name
FROM album
INNER JOIN artist
ON album.artist_id = artist.artist_id
WHERE artist.name LIKE '%Black%';

--Display the city with highest sum total invoices
SELECT billing_city, SUM(total) AS totalInvoice
FROM invoice
GROUP BY billing_city
ORDER BY totalInvoice DESC
LIMIT 1;

--produce a table that list each country and the number of customers in that country
SELECT  COUNTRY, COUNT(customer_id) AS no_of_customers
FROM CUSTOMER
GROUP BY COUNTRY
ORDER BY no_of_customers DESC;

/*Find the top 5 customers in terms of sales
top 5 customerss whose combined invoice amounts 
are the highest, give their name, customerid & total invoice*/
SELECT C.customer_id, C.first_name, C.last_name, SUM(I.total) AS total_invoice
FROM customer as C
INNER JOIN invoice AS I
ON C.customer_id = I.customer_id 
GROUP BY C.customer_id
ORDER BY total_invoice DESC
LIMIT 5;



/*find the state wise count of customeID AND list the name of state
with count of customerid in decreasing order
dont include where state is null values*/
SELECT state, COUNT(customer_id) AS Counts
FROM customer
WHERE state IS NOT NULL
GROUP BY state
ORDER BY counts DESC;

--how many invoice were there in 2021 and 2023
SELECT SUM(total)
FROM invoice
WHERE invoice_date BETWEEN '2021-01-01' AND '2023-01-01';

--provide query showing only the employees who are sales agents
SELECT employee_id, last_name, first_name, title
FROM employee
WHERE title = 'Sales Support Agent';

-- Display the most use media types, their name, and count in descending order
SELECT m.name, COUNT(m.media_type_id) AS count
FROM media_type AS m
INNER JOIN track AS t
ON m.media_type_id = t.media_type_id
GROUP BY m.media_type_id
ORDER BY count DESC;

/**Provide a query showing the invoices of customers who are from brazil
the result table should shpow the customer full name,
invoice_id, date of the invoice and billing country**/
SELECT c.last_name, c.first_name, I.invoice_id, I.invoice_date, I.billing_country
FROM customer AS c
INNER JOIN invoice AS I
ON c.customer_id = I.customer_id
WHERE I.billing_country = 'Brazil';

/*Display artist name and total track count of the top 10 rock bands*/
SELECT a.name, COUNT(track.track_id) AS Track_counts
FROM album AS al
INNER JOIN artist a
ON al.artist_id = a.artist_id
INNER JOIN track 
ON track.album_id = al.album_id
INNER JOIN genre 
ON genre.genre_id = track.genre_id
WHERE track.genre_id = 1
GROUP BY a.name
ORDER BY Track_counts DESC LIMIT 10;

/* Display the best customer full name: last_name and first_name (in case of amount spend )*/
SELECT CONCAT(c.last_name,' ', c.first_name) AS Full_Name, SUM(i.total) AS Amount_Spent
FROM customer AS c
INNER JOIN invoice AS i
ON c.customer_id = i.customer_id
GROUP BY c.last_name, c.first_name
ORDER BY Amount_Spent DESC LIMIT 1; 

/* provide a query showing customers( just their full names, customer id and country) who are not in the US*/
SELECT CONCAT(last_name,' ', first_name) AS Full_Name, customer_id, country
FROM customer
WHERE country != 'USA'
ORDER BY Full_Name;

/* Provide a query that shows the total number of tracks in each playlist in descending order. 
the playlist name should be included in the resultant table*/
SELECT pl.name, COUNT(t.name) AS track_totalnumber
FROM track as t
INNER JOIN playlist_track AS pt
ON t.track_id = pt.track_id
INNER JOIN playlist AS pl
ON pl.playlist_id = pt.playlist_id
GROUP BY pl.name
ORDER BY track_totalnumber DESC;


/* Provide a query that shows all the tracks, but displays no IDs. The result table should include the Album name,
mediatype, and genre*/
SELECT al.title AS Album, md.name AS media_type, g.name AS genre
FROM album AS al 
JOIN track as t ON al.album_id = t.album_id
JOIN media_type AS md ON t.media_type_id = md.media_type_id
JOIN genre AS g ON g.genre_id = t.genre_id
GROUP BY al.title,md.name, g.name;


/* Provide a query that shows the top 10 bestselling artists. (in terms of earning)*/
SELECT Artist_Name, Total_Earned
FROM (
	SELECT a.name AS Artist_Name, SUM(t.unit_price) AS Total_Earned
	FROM album AS al
	INNER JOIN track AS t ON al.album_id = t.album_id
	INNER JOIN artist AS a ON a.artist_id = al.artist_id
	GROUP BY a.name
	) AS Best_Selling
ORDER BY total_earned DESC
LIMIT 10;
/* Provide a query that shows the most purchased mediatype*/
SELECT most_purchased
FROM (
	SELECT md.name AS most_purchased, COUNT(md.name) AS counts
	FROM media_type AS md
	INNER JOIN track AS t 
	ON t.media_type_id = md.media_type_id
	GROUP BY md.name 
	)
ORDER BY most_purchased DESC
LIMIT 1;

/* Provide a query that shows the purchased tracks of 2021, display track name and unit sold */

SELECT Track_name,Unit_Sold2021
FROM(
SELECT t.name AS Track_name, il.unit_price AS Unit_Sold2021, i.invoice_date
FROM track as t
INNER JOIN invoice_line AS il
ON t.track_id = il.track_id
INNER JOIN invoice AS i
ON il.invoice_id = i.invoice_id
WHERE i.invoice_date BETWEEN '2021-01-01' AND '2021-12-31'
) AS UnitSold2013;



