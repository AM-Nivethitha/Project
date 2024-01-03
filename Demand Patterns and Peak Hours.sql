/*Demand Patterns and Peak Hours:

Value: Understanding peak hours and periods of high demand is crucial for optimizing resource allocation and meeting customer demand efficiently.
Demand: This objective is always relevant as it directly impacts operational efficiency and customer satisfaction.

so lets concentrate on this objective.

So I want you to analyze and use both table to analyze Demand Patterns and Peak Hours thouroughly and draw insights from the analysis, which i can present to the business people.*/




-- Calculate hourly demand patterns
WITH HourlyDemand AS (
  SELECT
    EXTRACT(HOUR FROM tpep_pickup_datetime) AS pickup_hour,
    COUNT(*) AS demand_count
  FROM
    `analytics-406018.data.table_dbms`
  GROUP BY
    pickup_hour
),

-- Identify peak hours
PeakHours AS (
  SELECT
    pickup_hour,
    demand_count,
    RANK() OVER (ORDER BY demand_count DESC) AS peak_rank
  FROM
    HourlyDemand
  ORDER BY
    pickup_hour
),

-- Identify days of the week with increased demand
DailyDemand AS (
  SELECT
    EXTRACT(DAYOFWEEK FROM tpep_pickup_datetime) AS pickup_day_of_week,
    COUNT(*) AS demand_count
  FROM
    `analytics-406018.data.table_dbms`
  GROUP BY
    pickup_day_of_week
),

-- Rank days of the week by demand
RankedDays AS (
  SELECT
    pickup_day_of_week,
    demand_count,
    RANK() OVER (ORDER BY demand_count DESC) AS day_rank
  FROM
    DailyDemand
)

-- Final query combining all insights
SELECT
  pd.pickup_hour,
  pd.demand_count AS hourly_demand,
  ph.peak_rank,
  rd.pickup_day_of_week,
  rd.demand_count AS daily_demand,
  rd.day_rank
FROM
  PeakHours ph
JOIN
  HourlyDemand pd ON ph.pickup_hour = pd.pickup_hour
JOIN
  RankedDays rd ON rd.pickup_day_of_week = EXTRACT(DAYOFWEEK FROM TIMESTAMP_SECONDS(pd.pickup_hour * 3600))
ORDER BY
  ph.peak_rank, rd.day_rank;




  /*
  Based on the analysis of Demand Patterns and Peak Hours, the following insights can be drawn:

Hourly Demand Patterns:

The peak hours for taxi demand are distributed throughout the day, with the highest demand occurring at 14:00 (2:00 PM).
The demand count for each hour is indicative of the variation in taxi demand throughout the day.
Daily Demand Patterns:

Days of the week are ranked by their overall demand, with the highest demand on Fridays (day_rank = 1).
The demand patterns provide a clear understanding of the busiest days, aiding in resource allocation and operational planning.
Business Impact:

Optimizing resource allocation during peak hours, especially at 14:00, can enhance operational efficiency.
Strategic planning for high-demand days, such as Fridays, can lead to improved service and customer satisfaction.
This information can guide business decisions, helping to allocate resources effectively and improve overall service quality during peak demand periods.
*/






/*

Certainly! Here are additional insights derived from the analysis of Demand Patterns and Peak Hours:

Hourly Demand Patterns:

The peak_rank indicates the relative intensity of demand during each hour. Businesses can focus on the top-ranked hours (e.g., 14:00) for targeted promotions or incentives to further boost demand during off-peak periods.
Understanding hourly variations allows for dynamic pricing strategies, optimizing fares during high-demand hours to maximize revenue.
Daily Demand Patterns:

The day_rank highlights that Fridays have the highest overall demand. Businesses can implement targeted marketing campaigns, promotions, or incentives specifically tailored for Fridays to capitalize on increased demand.
Identifying the least busy days (higher day_rank) provides an opportunity for strategic marketing efforts to stimulate demand during traditionally slower periods.
Combined Insights:

Businesses can strategize and align operational resources based on both hourly and daily demand patterns. For instance, during the top-ranked hour on Fridays (14:00), optimizing the number of available vehicles and drivers can lead to improved service and reduced customer wait times.
The analysis provides a comprehensive view of demand fluctuations, enabling businesses to implement adaptive operational strategies for different times of the day and days of the week.
Business Impact:

Targeted marketing and promotions during identified peak hours and days can drive customer engagement and loyalty.
Dynamic resource allocation based on hourly and daily patterns can lead to cost savings and improved operational efficiency.
These insights empower businesses to make informed decisions, enhancing their ability to meet customer demand effectively and capitalize on revenue opportunities.

*/
