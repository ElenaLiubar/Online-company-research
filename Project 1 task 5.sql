WITH g_fb_table AS (SELECT f.ad_date, 
fa.adset_name ,
f.spend, f.impressions, f.reach, f.clicks, f.leads, f.value
FROM facebook_ads_basic_daily f
LEFT JOIN facebook_adset fa
ON fa.adset_id = f.adset_id 
UNION ALL 
SELECT ad_date, 
adset_name,
spend, impressions, reach, clicks, leads, value
FROM google_ads_basic_daily g),
grouped_table AS (SELECT ad_date, adset_name,
ROW_NUMBER () over(PARTITION BY adset_name ORDER BY ad_date) AS row_numb,
ad_date - INTERVAL '1 day'* (ROW_NUMBER () over(PARTITION BY adset_name ORDER BY ad_date)) AS countin_group
FROM g_fb_table
GROUP BY 1,2)
SELECT adset_name, countin_group,
min (ad_date) AS start_impress,
max(ad_date) AS end_impress,
count(ad_date) AS duration_impress
FROM grouped_table
GROUP BY 1,2
ORDER BY 5 DESC
LIMIT 1;
