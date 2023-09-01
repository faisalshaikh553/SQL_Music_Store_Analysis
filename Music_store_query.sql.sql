 Q1: Who is the senior most employee based on job title? 
 
 select first_name,last_name,levels
 from employee
 order by levels desc 
 limit 1
 
 
 Q2: Which countries have the most Invoices? 
 
 select count(*) as c,billing_country
 from invoice
 group by billing_country
 order by c desc 


Q3: What are top 3 values of total invoice?

select total
from invoice
order by total desc
limit 3


Q4: Which city has the best customers? We would like to throw a promotional
Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoicetotals. 
Return both the city name & sum of all invoice totals ?

select billing_city, sum(total) as invoice_total 
from invoice
group by billing_city 
order by invoice_total desc
limit 1


Q5: Who is the best customer? The customer who has spent the most money 
will be declared the best customer. 
Write a query that returns the person who has spent the most money ?

select customer.customer_id, first_name , last_name, sum(total) as total_spending 
from customer
join invoice on customer.customer_id=invoice.customer_id
group by customer.customer_id 
order by total_spending desc
limit 1


 Q6: Write query to return the email, first name, last name, & Genre of 
 all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A?

select distinct email,first_name,last_name 
from customer
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice_line.invoice_id=invoice.invoice_id
where track_id in (
		select track_id from track 
		join genre on track.genre_id = genre.genre_id
		where genre.name like 'Rock'  
	)
order by email

/* Method 2 */

select distinct email,first_name,last_name,genre.name
from customer 
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
where genre.name like 'Rock'
order by email ;

 Q7: Let's invite the artists who have written the most rock music in ourdataset. 
Write a query that returns the Artist name and total track countof the top 10 rock bands ?/


SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;


 Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song
length with the longest songs listed first ?


select name , milliseconds from track 
where milliseconds >
		(select avg(milliseconds) as avg_track_length
		from track)
order by milliseconds desc
		




