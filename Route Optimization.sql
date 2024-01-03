/*Route Optimization:

Value: Identifying common routes with high traffic helps in optimizing route planning and increasing overall efficiency.
Demand: With the growing need for efficient transportation services, route optimization is an ongoing concern for taxi businesses.

so lets concentrate on this objective.

So I want you to analyze and use both table to analyze Demand Patterns and Peak Hours thouroughly and draw insights from the analysis, which i can present to the business people.*/




/*
1. Identify Common Routes with High Traffic:

Analysis and Insights:
Common Routes Identification:

The query identifies common routes based on pickup and dropoff locations, providing a count of trips for each route.
High Traffic Routes Ranking:

Routes are ranked by traffic count in descending order, highlighting the most frequently traveled routes.
Business Impact:

Understanding high-traffic routes is crucial for optimizing resource allocation, ensuring quicker service, and improving overall efficiency.
*/
-- Route Optimization
WITH RouteTraffic AS (
  SELECT
    ST_AsText(ST_GEOGPOINT(pickup_longitude, pickup_latitude)) AS pickup_location,
    ST_AsText(ST_GEOGPOINT(dropoff_longitude, dropoff_latitude)) AS dropoff_location,
    COUNT(*) AS traffic_count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS traffic_rank
  FROM
    `analytics-406018.data.table_dbms`
  GROUP BY
    pickup_location,
    dropoff_location
)
SELECT
  pickup_location,
  dropoff_location,
  traffic_count,
  traffic_rank
FROM
  RouteTraffic
ORDER BY
  traffic_rank;

/*
2. Explore Transformed Data for Additional Insights:

Additional Analysis on Transformed Data:
Utilizing Transformed Data:

The transformed data includes aggregated information for better readability and analysis.
Comparing Insights:

Compare the results with the original data to ensure consistency and validate the importance of identified routes.
Extended Business Impact:

Utilize the aggregated data for more straightforward communication of insights to stakeholders, showcasing the most critical routes.
Presentation to Business:
Visualizations:

Create visualizations, such as maps, to represent high-traffic routes effectively.
Recommendations:

Suggest optimizations, such as dedicated vehicles for popular routes or strategic marketing in high-demand areas.
Efficiency Gains:

Emphasize potential efficiency gains, reduced travel times, and improved customer satisfaction through optimized routes.
This analysis provides a foundation for route optimization, enabling the business to make informed decisions to enhance operational efficiency and customer experience.
*/
SELECT
  pickup_location,
  dropoff_location,
  COUNT(*) AS traffic_count,
  RANK() OVER (ORDER BY COUNT(*) DESC) AS traffic_rank
FROM
  `analytics-406018.data.table_dbms_transformed`
GROUP BY
  pickup_location,
  dropoff_location
ORDER BY
  traffic_rank;
