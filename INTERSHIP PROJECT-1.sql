create database project1;
use project1;
select*from customer;
select*from orders;
select*from agents;

#Retrieve customer details along with the agent's name who helped them, showing the total outstanding amount.
SELECT C.CUST_CODE,
       C.CUST_NAME,
       A.AGENT_NAME,
       C.OUTSTANDING_AMT
FROM CUSTOMER C
JOIN AGENTS A
ON C.AGENT_CODE = A.AGENT_CODE;

#Find the agents whose total order amount exceeds 10,000.
SELECT AGENT_CODE,
       SUM(ORD_AMOUNT) AS TOTAL_ORDER_AMOUNT
FROM ORDERS
GROUP BY AGENT_CODE
HAVING SUM(ORD_AMOUNT) > 10000;

#Create a view to list all orders along with customer names and their respective agent's names.
CREATE VIEW ORDER_DETAILS_VIEW AS
SELECT O.ORD_NUM,
       C.CUST_NAME,
       A.AGENT_NAME
FROM ORDERS O
JOIN CUSTOMER C
ON O.CUST_CODE = C.CUST_CODE
JOIN AGENTS A
ON O.AGENT_CODE = A.AGENT_CODE;
 select*from order_details_view;
 
#Find all orders placed by customers who reside in New York.
SELECT O.*,
       C.CUST_CITY
FROM ORDERS O
JOIN CUSTOMER C
ON O.CUST_CODE = C.CUST_CODE
WHERE C.CUST_CITY = 'New York';

#Find the total number of orders handled by each agent.
SELECT AGENT_CODE,
       COUNT(*) AS TOTAL_ORDERS
FROM ORDERS
GROUP BY AGENT_CODE;

#Get the list of customers who placed an order with an advance amount greater than or equal to 50% of the order amount.
SELECT DISTINCT C.CUST_CODE,
                C.CUST_NAME,
                O.ORD_AMOUNT,
                O.ADVANCE_AMOUNT
FROM CUSTOMER C
JOIN ORDERS O
ON C.CUST_CODE = O.CUST_CODE
WHERE O.ADVANCE_AMOUNT >= (O.ORD_AMOUNT * 0.50);

#Find the number of customers in each city and the total outstanding amount for each city.
SELECT CUST_CITY,
       COUNT(*) AS TOTAL_CUSTOMERS,
       SUM(OUTSTANDING_AMT) AS TOTAL_OUTSTANDING
FROM CUSTOMER
GROUP BY CUST_CITY;

#List all customers along with their orders, including customers who have not placed any orders
 SELECT
    c.CUST_CODE,
    c.CUST_NAME,
    o.ORD_NUM,
    o.ORD_AMOUNT,
    o.ORD_DATE
FROM customer c
LEFT JOIN orders o
    ON c.CUST_CODE = o.CUST_CODE;
    
#Find the customer who placed the highest order amount using a subquery.
SELECT CUST_CODE, CUST_NAME
FROM customer
WHERE CUST_CODE IN (
    SELECT CUST_CODE
    FROM orders
    WHERE ORD_AMOUNT = (
        SELECT MAX(ORD_AMOUNT)
        FROM orders
    )
);
#Find the total order amount for customers who have placed more than 2 orders using a subquery.
SELECT CUST_CODE,
       SUM(ORD_AMOUNT) AS TOTAL_ORDER_AMOUNT
FROM ORDERS
WHERE CUST_CODE IN (
    SELECT CUST_CODE
    FROM ORDERS
    GROUP BY CUST_CODE
    HAVING COUNT(*) > 2
)
GROUP BY CUST_CODE;   
 
#List the orders placed in the month of May 2008
SELECT *FROM ORDERS
WHERE ORD_DATE BETWEEN '2008-05-01' AND '2008-05-31';

#List orders where the amount is greater than 1000 or the order date is before '2008-12-31'.
select *
FROM ORDERS
WHERE ORD_AMOUNT > 1000
   OR ORD_DATE < '2008-12-31';
   
#Find all orders placed by customers in 'New York' or whose order amount is greater than 5000.
SELECT O.*,
       C.CUST_CITY
FROM ORDERS O
JOIN CUSTOMER C
ON O.CUST_CODE = C.CUST_CODE
WHERE C.CUST_CITY = 'New York'
   OR O.ORD_AMOUNT > 5000;
   
#Find the agents who have handled orders for more than 3 distinct customers.
SELECT AGENT_CODE,
       COUNT(DISTINCT CUST_CODE) AS TOTAL_CUSTOMERS
FROM ORDERS
GROUP BY AGENT_CODE
HAVING COUNT(DISTINCT CUST_CODE) >= 3;

#Find customers who have made at least one payment but still have an outstanding amount greater than 7000.
SELECT 
    CUST_CODE,
    PAYMENT_AMT,
    OUTSTANDING_AMT
FROM customer
WHERE PAYMENT_AMT > 0
AND OUTSTANDING_AMT > 7000;
