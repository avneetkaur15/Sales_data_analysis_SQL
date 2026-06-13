-- 1. What are the top 5 most selling products by quantity?

select 
	product_name, 
	sum(quantity) as total_quantity_Sold 
from sales 
where status = 'delivered' 
group by product_name 
order by total_quantity_Sold DESC 
limit 5;

-- 2. Which products are most frequently cancelled?
select 
	product_name,
	count(status) as total_cancelled 
from sales 
where status = 'cancelled' 
group by product_name 
order by total_cancelled DESC 
limit 10;

-- 3. What times of the day has the highest number of purchases?
select 
case 
	when Extract(hour from time_of_purchase) between 6 and 11 then 'Morning'
	when Extract(hour from time_of_purchase) between 12 and 17 then 'Afternoon'
	when Extract(hour from time_of_purchase) between 18 and 23 then 'Evening'
	else 'Night'
end as time_of_the_day,
count(*) 
from sales 
group by time_of_the_day 
order by count(*) DESC ;

-- 4. Who are the top 5 highest spending customers?
select 
	customer_id,
	customer_name,
	sum(quantity*price) as total_spendings
from sales
where status = 'delivered'
group by customer_id,customer_name
order by total_spendings DESC
limit 5;

-- 5. Which product categories generate the highest revenue (quantity × price)?
select 
	product_category, 
	sum(quantity*price) as Revenue 
from sales
where status = 'delivered'
group by product_category
order by revenue DESC;

-- 6. What is the return and cancellation rate per product category?

select 
	product_category,
	count(*) as total,
	sum(case when status = 'returned' then 1 else 0 end) as returned,
	sum(case when status = 'cancelled' then 1 else 0 end)as cancelled,
	round(sum(case when status = 'returned' then 1 else 0 end)::numeric * 100/count(*),2)as ret_percentage,
	round(sum(case when status = 'cancelled' then 1 else 0 end)::numeric * 100/count(*),2)as cancel_percentage
from sales	
group by product_category
order by product_category;

-- 7. What is the preferred payment mode?
select 
	payment_mode,
	count(*)
from sales
group by payment_mode
order by count(*) DESC;

-- 8. How does age group affect purchasing behaviour?

select 
case
	when customer_age between 18 and 25 then '18-25'
	when customer_age between 26 and 35 then '26-35'
	when customer_age between 36 and 50 then '36-50'
	else '51+'
end as age_group,
sum(quantity * price) as total_purchase
from sales
group by age_group
order by total_purchase DESC;

-- 9. What is the monthly sales trend?

select
	to_char(purchase_date,'YYYY-Month') as monthly_purchase,
	sum(quantity*price) as total_sales,
	sum(quantity) as total_items
from sales
group by monthly_purchase
ORDER BY TO_DATE(to_char(purchase_date,'YYYY-Month'), 'YYYY-Month')

-- 10. Are certain genders buying more specific product categories?
SELECT
	gender,
	product_category,
	COUNT(*) AS total_purchase
FROM sales
GROUP BY gender, product_category
ORDER BY total_purchase DESC;