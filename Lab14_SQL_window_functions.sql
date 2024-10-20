USE sakila;


-- Rank films by their length and create an output table that includes the title, length, and rank columns only. Filter out any rows with null or zero values in the length column.

SELECT title, length, DENSE_RANK() OVER(ORDER BY length DESC) AS 'Rank'
FROM (
SELECT *
FROM film
where length IS NOT NULL) as tablalimpia;

-- Rank films by length within the rating category and create an output table that includes the title, length, rating and rank columns only. Filter out any rows with null or zero values in the length column.

SELECT title, length, rating, 
DENSE_RANK() OVER(
PARTITION BY rating 
ORDER BY length DESC) AS 'Rank'
FROM (
SELECT *
FROM film
where length IS NOT NULL AND length != 0) as tablalimpia;

-- Produce a list that shows for each film in the Sakila database, the actor or actress who has acted in the greatest number of films, as well as the total number of films in which they have acted. 
-- Hint: Use temporary tables, CTEs, or Views when appropiate to simplify your queries.


CREATE temporary table topActor as
select DISTINCT actor_id, count(film_id) from film_actor
group by actor_id;

SELECT * from topActor
ORDER BY 2 DESC;

SELECT DISTINCT film_id, actor_id from film_actor;


DROP VIEW sakila.dv_films_actor;
CREATE VIEW sakila.dv_films_actor AS 
SELECT a.actor_id, CONCAT(a.first_name,' ',a.last_name) AS nombre_actor, COUNT(fa.film_id) AS num_films
 FROM actor a INNER JOIN film_actor fa ON (a.actor_id=fa.actor_id)
  GROUP BY a.actor_id;
  
SELECT * 
 FROM dv_films_actor;

WITH A AS (
  SELECT 
   f.film_id,
   f.title,
   dv.actor_id,
   dv.nombre_actor,
   dv.num_films,
   MAX(dv.num_films) OVER(PARTITION BY f.film_id) AS max_films
FROM film f 
 INNER JOIN film_actor fa ON (f.film_id=fa.film_id)
 INNER JOIN dv_films_actor dv ON (fa.actor_id=dv.actor_id)
 ORDER BY f.film_id, dv.num_films DESC)
SELECT film_id, title, actor_id, nombre_actor, num_films
 FROM A
  WHERE num_films=max_films;

-- Challenge 2

-- Step 1. Retrieve the number of monthly active customers, i.e., the number of unique customers who rented a movie in each month.
CREATE OR REPLACE VIEW user_activity AS
SELECT customer_id, 
       CONVERT(rental_date, DATE) AS Activity_date,
       DATE_FORMAT(CONVERT(rental_date,DATE), '%M') AS Activity_Month,
       DATE_FORMAT(CONVERT(rental_date,DATE), '%m') AS Activity_Month_number,
       DATE_FORMAT(CONVERT(rental_date,DATE), '%Y') AS Activity_year
FROM rental;

-- Checking the results
SELECT * FROM user_activity;

DROP VIEW monthly_active_users;
CREATE VIEW monthly_active_users AS
SELECT 
   Activity_year, 
   Activity_Month, 
   Activity_Month_number, 
   COUNT(DISTINCT customer_id) AS Active_users 
FROM user_activity
GROUP BY Activity_year, Activity_Month, Activity_Month_number
ORDER BY Activity_year ASC, Activity_Month_number ASC;

SELECT * from monthly_active_users;

-- Using the previously created view that aggregates monthly active users
-- Step 2. Retrieve the number of active users in the previous month.
SELECT 
   Activity_year,             -- Year of activity
   Activity_month,            -- Month of activity
   Active_users,              -- Number of active users for the specified year and month
   LAG(Active_users,1) OVER(ORDER BY Activity_year, Activity_Month_number) AS Last_month -- Number of active users from the previous month
FROM monthly_active_users;   -- Using the previously created view that aggregates monthly active users


-- Step 3. Calculate the percentage change in the number of active customers between the current and previous month.
WITH cte_view AS (
  SELECT 
   Activity_year, 
   Activity_month,
   Active_users, 
   LAG(Active_users,1) OVER(ORDER BY Activity_year, Activity_Month_number) AS Last_month
FROM monthly_active_users)
SELECT 
   Activity_year, 
   Activity_month, 
   Active_users, 
   Last_month, 
   CONCAT(ROUND(((Active_users - Last_month)/Last_month)*100),'%') Difference 
FROM cte_view;

-- Step 4. Calculate the number of retained customers every month, i.e., customers who rented movies in the current and previous months.

SELECT 
   Activity_year, 
   Activity_Month, 
   Activity_Month_number, 
   customer_id
FROM user_activity
ORDER BY Activity_year ASC, Activity_Month_number ASC, customer_id;

SELECT 
   Activity_year, 
   Activity_Month, 
   Activity_Month_number, 
   customer_id,
   LAG(customer_id,1) OVER(ORDER BY Activity_year, Activity_Month_number) AS Last_month
FROM user_activity
ORDER BY Activity_year ASC, Activity_Month_number ASC;

SELECT *
from rental;


CREATE OR REPLACE VIEW user_activity AS
SELECT customer_id, 
       DATE_FORMAT(CONVERT(rental_date,DATE), '%m') AS Activity_Month_number,
       DATE_FORMAT(CONVERT(rental_date,DATE), '%Y') AS Activity_year  
FROM rental;

SELECT * FROM user_activity;

-- 



