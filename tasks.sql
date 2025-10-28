use sales;

/*Question 1/Task 1:
 Top 5 Products by Sales in 2022 for the "Mobiles & Tablets" Category Scenario:
 The Marketing Team is preparing for a Year-End Festival and needs to identify the top 5 products in the "Mobiles & Tablets" category that had the highest sales quantities in 2022.
 The products should be filtered to ensure only valid orders are included.
 Requirements: • Filter the data to include only products from the "Mobiles & Tablets" category in 2022, where the is_valid feature is set to 1.
 • Group the data by sku_name and category, and sum the qty_ordered for each product. 
 • Rank the products based on their total sales quantity in descending order.
 • Display the top 5 products with the highest sales quantities. 
 • Generate a horizontal bar chart showing the top 5 products by quantity. 
 Key Features to Use: • category • order_date (for filtering by year) • is_valid (to filter valid orders) • sku_name (for product names) • qty_ordered (for sales quantities)
*/

-- Answer:...


select s.sku_name,s.category, sum(o.qty_ordered) as total_sales_qty
from order_detail o
inner join sku_detail s on o.sku_id=s.id
where s.category like 'Mobiles & Tablets'       -- Handles both 'Mobiles Tablets' and 'Mobiles & Tablets'
    and year(o.order_date) = 2022
    and o.is_valid = 1
group by s.sku_name, s.category
order by total_sales_qty desc
limit 5;



/* Task 2:
Analyzing Sales Decrease in the "Others" Category Between 2021 and 2022 Scenario
: The Warehouse Team has observed a surplus in the stock of "Others" category products at the end of 2022.
 They would like to know if sales have declined in 2022 compared to 2021.
 Additionally, they want to see the 20 products that experienced the largest decrease in sales.
 Requirements: 1. Create two datasets: o One for sales data in 2021 (qty_ordered for "Others" category). 
 o One for sales data in 2022 (qty_ordered for "Others" category).
 2. Merge the datasets and calculate the sales difference between 2022 and 2021. 
 3. Calculate the percentage change in sales and classify it as "DOWN", "UP", or "FAIR".
 4. Sort the products by the largest decrease in sales and show the top 20 products.
 5. Create a horizontal bar chart to display the products with the largest decrease in sales between 2022 and 2021. 
 Key Features to Use: • category • order_date (for filtering by year) • is_valid • sku_name • qty_ordered */

--  Answer:...
 
 -- This is for 2021 decrease check
 select s.sku_name,sum(o.qty_ordered) as qty_2021
 from order_detail o
 
 
 inner join sku_detail s 
 on o.sku_id=s.id
 where s.category='others'
		and year(o.order_date)=2021
        and o.is_valid=1
group by s.sku_name;
 
 -- This is for 2022 decrease check 
 select s.sku_name,sum(o.qty_ordered) as qty_2022
 from order_detail o
 inner join sku_detail s 
 on o.sku_id=s.id
 where s.category='others'
		and year(o.order_date)=2022
        and o.is_valid=1
group by s.sku_name;
 
 
/* Task 3:
Identifying Customers Who Completed Checkout but Didn't Pay in 2022 
Scenario: The Digital Marketing Team wants to identify customers who completed the checkout process but did not make a payment in 2022.
 This will help them reach out for promotional purposes.
 Requirements: • Filter the data to find records where is_gross is 1 (indicating completed che
 • Retrieve the customer_id and registered_date for these records.
 • Ensure there are no duplicate customer_id entries.
 • Share the compiled data with the Marketing Team. 
 Key Features to Use: • is_gross (for checkout status)
 • is_valid, is_net (to filter invalid or net transactions)
 • order_date (for filtering by year) 
 • customer_id 
 • registered_dateckout but no payment), is_valid is 0, and is_net is 0, for the year 2022.  */
  
 
-- Answer:...
select distinct o.customer_id , c.registered_date
from order_detail o
inner join customer_detail c on o.customer_id=c.id
where year(o.order_date)=2022
	and is_valid=0
    and is_gross=1
    and is_net=0;
 
 

/* Task 4:
 Comparing Weekend and Weekday Sales in Q4 2022 Scenario:
 The Campaign Team wants to evaluate the effectiveness of their weekend promotional campaigns (Saturdays and Sundays) 
 between October and December 2022 by comparing the average daily sales during weekends vs weekdays. 
 Requirements: 1. Calculate the average daily sales (before_discount) for weekends (Saturdays and Sundays) and weekdays
 (Monday to Friday) for each month (October, November, and December 2022).
 2. Calculate the average sales for weekends vs weekdays for the entire three-month period.
 3. Share insights on whether sales increased during weekends. 
 Key Features to Use: • order_date (for filtering by date and identifying days of the week)
 • before_discount (for sales data)
 • month_id, month_name, day_name, year (for extracting date-related information)
*/

 -- Answer:...
select date(order_date) as sales_date,
		month(order_date) as month_id,
		dayname(order_date) as day_name,
		monthname(order_date) as month_name,
        case when dayofweek(order_date) in (1,7) then 'Weekend' else 'Weekday' end as day_type,
        sum(before_discount) as total_sales

from order_detail 
where year(order_date)=2022
	and month(order_date) in (10,11,12)
group by sales_date,month_id,month_name,day_name,day_type
order by sales_date;


/*Task 5:
Finding Products with the Largest Decrease in Sales Between Two Periods (e.g., 2022 vs 2021) Scenario
: The Sales Team would like to identify which products had the most significant decrease in sales between two periods 
(e.g., 2021 and 2022)
. Requirements: 1. Create two datasets for each period (e.g., 2021 and 2022), aggregated by product (sku_name).
 2. Calculate the sales difference between the two periods. 
 3. Identify the products with the largest decrease in sales and show the top 10 products.
 4. Create a bar chart to visualize the products with the largest decrease in sales. 
 Key Features to Use: • sku_name (for product names) 
 • order_date (for filtering by year) 
 • qty_ordered (for sales data)
*/

-- Answer:...

 -- dataset 2021 
 select s.sku_name, sum(o.qty_ordered) as qty_ordered_2021
 from order_detail o
 inner join sku_detail s on o.sku_id=s.id
 where  year(order_date) = 2021
 group by sku_name
 ;
 
 -- dataset 2022
 select s.sku_name, sum(o.qty_ordered) as qty_ordered_2022
 from order_detail o 
 inner join sku_detail s on o.sku_id=s.id
 where year(order_date)= 2022
 group by sku_name
 ;
 
 
 /* Task 6:...
 Comparing Sales Trends for Multiple Categories in 2022 Scenario: 
 The Marketing Team wants to compare the sales trends for multiple categories in 2022
 to identify which category performed best. 
 \Requirements: 1. Aggregate the sales data by category for 2022. 
 2. Plot a time series of sales trends for each category (use order_date to group by month or week).
 3. Provide insights on which category had the highest sales growth. 
 Key Features to Use: • category • order_date (for time series analysis)
 • qty_ordered
 */
 
 -- Answer:...
 select s.category,
 sum(o.qty_ordered) as total_sales,
 date_format(o.order_date,'%Y-%m') as sales_month
 from order_detail o
 inner join sku_detail s on o.sku_id=s.id
 where year(order_date)=2022
 group by category,sales_month
 order by category,sales_month;
 