WITH g_fb_table AS (SELECT ad_date, 
spend, value
FROM facebook_ads_basic_daily f
UNION ALL 
SELECT ad_date, 
spend, value
FROM google_ads_basic_daily g)
SELECT ad_date,
sum(spend) AS sum_spend,
sum(value) AS sum_value,
(sum(value)::NUMERIC/sum(spend)::NUMERIC)*100 AS ROMI	
FROM g_fb_table
GROUP BY 1
HAVING sum(spend) > 0
ORDER BY 4 DESC
LIMIT 5;