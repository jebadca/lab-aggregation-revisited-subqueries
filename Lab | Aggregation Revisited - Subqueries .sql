USE sakila;

#1. Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.first_name, customer.last_name, customer.email;

#2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT 
    customer.customer_id,
    CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
    AVG(payment.amount) AS average_payment
FROM 
    customer
JOIN 
    payment ON customer.customer_id = payment.customer_id
GROUP BY 
    customer.customer_id, customer_name;

#3. Select the name and email address of all the customers who have rented the "Action" movies.
	#Write the query using multiple join statements    
SELECT 
    customer.first_name, 
    customer.last_name, 
    customer.email
FROM 
    customer
JOIN 
    rental ON customer.customer_id = rental.customer_id
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON film.film_id = inventory.film_id
JOIN 
    film_category ON film_category.film_id = film.film_id
JOIN 
    category ON category.category_id = film_category.category_id
WHERE 
    category.name = 'Action'
GROUP BY 
    customer.first_name, 
    customer.last_name, 
    customer.email;

	#Write the query using sub queries with multiple WHERE clause and IN condition
SELECT 
    customer.first_name, 
    customer.last_name, 
    customer.email
FROM 
    customer
WHERE 
    customer.customer_id IN (
        SELECT 
            rental.customer_id 
        FROM 
            rental 
        WHERE 
            rental.inventory_id IN (
                SELECT 
                    inventory.inventory_id 
                FROM 
                    inventory 
                WHERE 
                    inventory.film_id IN (
                        SELECT 
                            film_category.film_id 
                        FROM 
                            film_category 
                        WHERE 
                            film_category.category_id IN (
                                SELECT 
                                    category.category_id 
                                FROM 
                                    category 
                                WHERE 
                                    category.name = 'Action'
                            )
                    )
            )
    );

#4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
SELECT 
    payment_id, 
    amount,
    CASE
        WHEN amount BETWEEN 0 AND 2 THEN 'Low'
        WHEN amount BETWEEN 2 AND 4 THEN 'Medium'
        ELSE 'High'
    END AS Transaction_Class
FROM 
    payment;
