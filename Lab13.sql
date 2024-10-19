USE sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) FROM inventory AS inv
JOIN (SELECT *
FROM film
WHERE title = 'Hunchback Impossible') AS f
ON inv.film_id = f.film_id;

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT * FROM film
WHERE length > (SELECT ROUND(AVG(length)) from film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT fa.actor_id from film_actor as fa
WHERE fa.film_id = 
(SELECT f.film_id from film as f
WHERE f.title = 'Alone Trip');

-- BONUS
-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT fc.film_id from film_category as fc
WHERE fc.category_id = 
(SELECT cat.category_id from category as cat
WHERE cat.name = 'Family');

-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.


SELECT DISTINCT first_name as Name, email, country from address as ad
JOIN (SELECT * from customer as cust) as ct
ON ad.address_id = ct.address_id
JOIN
(SELECT * from city as c) as cities
JOIN 
(SELECT * from country as coun) as co
ON cities.country_id = co.country_id
WHERE co.country = 'Canada';

-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

SELECT title
FROM film AS f
WHERE film_id IN(
SELECT film_id
FROM film_actor AS fa
WHERE fa.actor_id = (
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1));

-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

SELECT film_id
FROM inventory AS f
WHERE f.inventory_id IN (
SELECT r.inventory_id
FROM rental AS r
WHERE r.customer_id = (
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1));

-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
SELECT AVG(total_spent)
FROM (
SELECT SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id) AS customer_totals);