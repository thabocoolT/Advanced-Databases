# RQ5 – Analysis

## Research Question

Which operating city and ride-category combination produces the highest average driver payout per completed trip?

## Purpose

This question combines two dimensions, the city where the trip took place and the ride category booked, to identify which combinations deliver the strongest average driver payout per completed trip. The city is taken from the trip's zone (pricing_surge_zones.city) rather than the driver's home city, because the analysis is about where the trip happened, not where the driver is registered. Tiny combinations (fewer than 30 completed trips) are excluded to prevent single outliers from distorting the ranking. The payout_per_km and payout_per_hour columns allow the analysis to distinguish between combinations that pay the most in absolute terms versus those that pay most efficiently per unit of distance or time.

## SQL Query

See `02_SQL_Queries/RQ5.sql`.

## Results

These are the results from the sql script for research question 5

<img width="1216" height="421" alt="image" src="https://github.com/user-attachments/assets/037f484a-ea96-4a56-af07-3b11e6431dd8" />




## Analysis

Three clear patterns emerge from the results.

1. City effect dominates category effect. Cape Town occupies the entire top four positions. The gap between Cape Town's weakest combination (Comfort, R442.38) and Johannesburg's strongest (Standard, R419.39) is R22.99, larger than the gap between the best and worst categories within Cape Town (R14.03). This means the choice of city affects driver payout more than the choice of ride category. The city-level ordering is: Cape Town > Johannesburg > Durban > Pretoria > Gqeberha > Vanderbijlpark, which mirrors the tariff structure in pricing_surge_zones (Cape Town Waterfront at R12.00/km and R1.60/min vs Potchefstroom's R8.00/km and R1.00/min).

2. Category effect is inconsistent and small. Across cities, the "best" category varies:

Cape Town → Budget wins on raw payout (R456.41), but Large Capacity wins on payout_per_km (R20.71) and payout_per_hour (R375.86)

Johannesburg → Standard wins on raw payout, but Comfort wins on payout_per_km (R19.23) and payout_per_hour (R347.97)

Durban → Standard wins on raw payout, but Large Capacity wins slightly on payout_per_km (R17.51)

Pretoria → Large Capacity wins on payout, Budget wins on payout_per_km and payout_per_hour

This confirms that raw payout and payout efficiency are not the same ranking. A driver choosing a category based on absolute rand per trip would pick differently than a driver optimising for rand per kilometre driven.

3. Averages are tightly clustered. Within every city, the spread between the best and worst category is small, under R15 in Cape Town, under R20 in Johannesburg, under R17 in Durban, under R18 in Pretoria. Trip characteristics (distance and duration) are nearly identical across all combinations (24–26 km, 73–79 minutes), which explains why category differences are modest. The categories appear to reflect vehicle class, not dramatically different trip profiles.

4. Sample sizes are robust. Every combination has between 945 and 1,341 completed trips. The HAVING COUNT(*) >= 30 filter successfully excluded any noisy combinations, and no result shown is driven by an outlier sample.

5. Efficiency anomaly in Johannesburg. Johannesburg's Comfort category has the third-highest payout_per_hour (R347.97) but the third-lowest raw payout (R402.89) within the city. This happens because Comfort trips in Johannesburg have the shortest average duration (73.44 min) but the highest per-km rate (R19.23). Drivers optimising for hourly earnings should favour Comfort in Johannesburg; drivers optimising for total payout per trip should favour Standard.

## Conclusion

The highest-paying city–category combination for average driver payout per completed trip is Cape Town – Budget (Uber Go / Bolt Go), delivering an average of R456.41 per completed trip across 1,297 trips.

However, the answer depends on how "best" is defined:

By raw payout per trip → Cape Town – Budget (R456.41)

By payout per kilometre → Cape Town – Large Capacity (R20.71/km)

By payout per hour → Cape Town – Large Capacity (R375.86/hr)

The primary driver of payout is the city, with Cape Town consistently out-earning all other metros across every category. Ride category acts as a secondary, inconsistent multiplier whose effect is smaller than the city effect and varies by location. A strategic driver would prioritise operating in Cape Town, and choose category based on whether they are optimising for total earnings per trip or earnings per unit of time and distance.

## Visualisation


1. Horizontal bar, top 10 combinations
  <img width="944" height="462" alt="image" src="https://github.com/user-attachments/assets/ed4fc15b-9179-44fa-9870-3b2b0db0dc0c" />

2. Heatmap, city × category
    <img width="422" height="140" alt="image" src="https://github.com/user-attachments/assets/66db2a50-bb54-403e-b30c-c1f34fb3d78f" />




