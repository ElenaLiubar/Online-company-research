WITH g_fb_table AS (SELECT f.ad_date, 
'facebook' AS media_sourse, 
fc.campaign_name,
 f.value 
FROM facebook_ads_basic_daily f
LEFT JOIN facebook_campaign fc 
ON fc.campaign_id = f.campaign_id 
UNION ALL 
SELECT ad_date, 
'google' AS media_sourse,
campaign_name, 
g. value
FROM google_ads_basic_daily g)
SELECT CAST (date_trunc ('week', ad_date) AS date) AS week_start,
campaign_name,
sum(value) AS sum_value
FROM g_fb_table
GROUP BY 1,2
HAVING campaign_name IS NOT null
ORDER BY 3 DESC
LIMIT 1;