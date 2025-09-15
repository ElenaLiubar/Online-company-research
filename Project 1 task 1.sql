WITH g_fb_table AS (SELECT ad_date, 
'facebook' AS media_sourse,
spend, impressions, reach, clicks, leads, value
FROM facebook_ads_basic_daily f
UNION ALL 
SELECT ad_date, 
'google' AS media_sourse,
spend, impressions, reach, clicks, leads, value
FROM google_ads_basic_daily g)
SELECT ad_date,
media_sourse,
avg(spend) AS avg_spend,
max(spend) AS max_spend,
min(spend) AS min_spend,
avg(impressions) AS avg_impres,
max(impressions) AS max_impres,
min(impressions) AS min_impres,
avg(reach) AS avg_reach,
max(reach) AS max_reach,
min(reach) AS min_reach,
avg(clicks) AS avg_clicks,
max(clicks) AS max_clicks,
min(clicks) AS min_clicks,
avg(leads) AS avg_leads,
max(leads) AS max_leads,
min(leads) AS min_leads,
avg(value) AS avg_value,
max(value) AS max_value,
min(value) AS min_value
FROM  g_fb_table
GROUP BY 1,2
ORDER BY 1; 