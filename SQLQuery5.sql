USE BikeStores;
-------------------
SELECT 
     model_year ,sum( list_price)
FROM
    production.products
GROUP BY 
       model_year;
-------------
SELECT
     customer_id,
	 YEAR(order_date) order_year,
	 COUNT(order_id)order_placed
FROM 
    sales.orders
WHERE
    customer_id IN (1,2)
GROUP BY 
      customer_id,
	  YEAR(order_date)
ORDER BY
     customer_id;
----------------------

SELECT
     product_name , model_year, MAX (discount) as MAX_Discount
FROM
    production.products p 
JOIN
   sales.order_items o ON p.product_id = o.product_id

GROUP BY 
    product_name,
	model_year;

------------------

SELECT
    order_id,
    SUM (
        quantity * list_price * (1 - discount)
    ) net_value
FROM
    sales.order_items
GROUP BY
    order_id
HAVING
    SUM (
        quantity * list_price * (1 - discount)
    ) > 20000
ORDER BY
    net_value;
------------

	SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;
-------------------  





SELECT * FROM production.products;
SELECT * FROM sales.order_items;

