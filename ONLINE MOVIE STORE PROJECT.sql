-- ONLINE MOVIE RENTAL SHOP PROJECT-- 

-- 1. WHAT IS THE TOP FIVE LOWEST REPLACEMENT COST OF FILMS

SELECT DISTINCT 
	replacement_cost 
FROM film
ORDER BY replacement_cost ASC
LIMIT 5;

-- 2.  HOW MANY FILMS HAVE A REPLACEMENT COST IN THE LOW GROUP? USING THE RANGE BELOW
		/*LOW: 		9.99 - 19.99
		MEDIUM: 	20.00 - 24.99
		HIGH:		25.00 - 29.99 */
		
SELECT
	COUNT(replacement_cost) AS Count_of_films,
CASE
	WHEN replacement_cost <= 19.99 THEN 'LOW'
	WHEN replacement_cost <= 24.99 THEN 'MEDIUM'
	ELSE 'HIGH'
END AS cost_Group
FROM film
GROUP BY cost_Group;


-- 3. IN WHICH CATEGORY IS THE LONGEST FILM AND HOW LONG IS IT?

SELECT 
	length, 
	name 
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS ca
ON fc.category_id = ca.category_id
ORDER BY length DESC
LIMIT 3;

-- 4. WHICH CATEGORY (NAME) IS THE MOST COMMON AMONG THE FILMS

SELECT 
	count(title) AS count_of_title, 
	name 
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS ca
ON fc.category_id = ca.category_id
GROUP BY name
ORDER BY count_of_title DESC
LIMIT 5;

-- 5. WHO ARE THE TOP TEN ACTORS WITH THE MOST FILM APPREARANCE?

SELECT 
	first_name,
	last_name,
	count(title) AS count_of_titles
FROM actor AS ac
INNER JOIN film_actor AS fa
ON ac.actor_id = fa.actor_id
INNER JOIN film AS f
ON f.film_id = fa.film_id
GROUP BY first_name,last_name
ORDER BY  count_of_titles DESC
LIMIT 10;

-- 6. HOW MANY ADDRESS ARE NOT ASSOCIATED WITH ANY CUSTOMER?

SELECT 
	first_name,
	last_name,
	address
FROM address AS ad
LEFT JOIN customer AS cu
ON cu.address_id = ad.address_id
WHERE first_name is null;


-- 7. WHICH CITY DO THE MOST SALE OCCUR AND WHAT IS THE TOTAL AMOUNT

SELECT 
	city,
	SUM(amount) AS total_amount
FROM city AS ci
INNER JOIN address AS ad
ON ci.city_id = ad.city_id
INNER JOIN customer AS cu
ON ad.address_id = cu.address_id
INNER JOIN payment AS pa
ON pa.customer_id = cu.customer_id
GROUP BY city
ORDER BY total_amount DESC
LIMIT 10;

-- 8. WHICH COUNTRY AND CITY HAS THE LOWEST SALES AMOUNT?

SELECT 
	country,
	city,
	SUM(amount) AS total_amount
FROM city AS ci
JOIN address AS ad
ON ci.city_id = ad.city_id
JOIN customer AS cu
ON ad.address_id = cu.address_id
JOIN payment AS pa
ON pa.customer_id = cu.customer_id
JOIN country AS co
ON co.country_id = ci.country_id
GROUP BY city, country
ORDER BY total_amount ASC
LIMIT 10;

-- 10.WHICH STAFF ID MAKES ON THE AVEARGE MORE REVENUE PER CUSTOMER?
SELECT DISTINCT
	first_name,
	last_name,
	ROUND(AVG(amount),2)
FROM payment
JOIN customer
ON payment.customer_id =customer.customer_id
GROUP BY first_name,last_name;


select * from store