# Easy questions
# Q1: who is the senior most employee based on the job title?
select * from employee
order by levels desc
limit 1;

# Q2: which countries have the most invoices?

select count(*) as c, billing_country
from invoice 
group by billing_country
order by c desc
limit 1;

# Q3 what are the top 3 values of total invoice

select total from invoice
order by total desc
limit 3;

# Q4 which city has the best customers ?
-- we would like to throw a promotional music festival in the city we made money.
-- write a query that returns one city that has the highest sum of invoice total.
-- return both the city name & sum of all invoice totals.

select sum(total) as invoice_total, billing_city
from invoice 
group by billing_city
order by invoice_total desc;

# Q5 who is the best customer? The customer who has the spent most money will be declared the best customer.
-- write a query that returns the persons who has spent the most money.

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total DESC
LIMIT 1;


# moderate question

# Q1: write query to return the email, first name, last name & Genre 
-- of all Rock music listner. Return your list ordered alphabetically 
-- by email starting with A.


select distinct email,first_name, last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
     select track_id from track
     join genre on track.genre_id = genre.genre_id
     where genre.name like 'Rock'
)
order by email;

# Q2 Let's invite the artist who have written the most of rock music in
-- our dataset. Write a query that returns the Artist name and total 
-- track count of the top 10 rock bands.


SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

select artist.artist_id, artist.name, count(artist.artist_id) as number_oF_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id like track.genre_id
where genre.name = 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10;

# Q3 Return all the track names that have a song length longer than the average song length.
-- Retruns the Name and Milliseconds for the average song of the length with the longest songs
-- listed first.

select name, Milliseconds
from track
where milliseconds > (
    select avg(milliseconds) as avg_track_length
    from track)
order by milliseconds desc;

select distinct email, first_name, last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
    select track_id from track
    join genre on track.genre_id = genre.genre_id
    where genre.name like 'Rock'
)
order by email;
