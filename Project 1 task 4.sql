WITH g_fb_table AS (SELECT f.ad_date, 
fc.campaign_name,
f.reach
FROM facebook_ads_basic_daily f
LEFT JOIN facebook_campaign fc 
ON fc.campaign_id = f.campaign_id 
UNION ALL 
SELECT ad_date, campaign_name , reach
FROM google_ads_basic_daily g),
month_table AS (SELECT CAST(date_trunc ('month', ad_date) AS date) AS ad_month,
campaign_name,
sum(reach) AS sum_reach
FROM g_fb_table
WHERE campaign_name IS NOT null
GROUP BY ad_month, campaign_name)
SELECT ad_month, campaign_name, sum_reach,
COALESCE (lag(sum_reach,1) OVER (partition BY campaign_name ORDER BY ad_month),0) AS prev_reach,
ABS (sum_reach::numeric - (COALESCE (lag(sum_reach,1) OVER (partition BY campaign_name ORDER BY ad_month),0))::numeric) AS diff_reach
FROM month_table
ORDER BY diff_reach DESC
LIMIT 1;