### RQ1: Average Total Fare, Platform Commission, and Driver Payout by Platform Affiliation

The analysis looked at Uber, Bolt, and Dual-Platform (Both) drivers to see which affiliation gives the highest average total fare, platform commission, and driver payout. We only included completed trips with valid fare breakdowns.

Bolt had the highest average total fare at R467.13 followed by Uber at R461.90 and Dual-Platform at R459.89. Bolt also had the highest average driver payout at R377.56, followed by Dual-Platform at R362.92 and Uber at R351.25. Uber had the highest completed-trip volume with 11,667 trips, followed by Dual-Platform with 10,983 and Bolt with 10,681 trips.

The platform commissions differed significantly. Uber retained the highest average commission at R110.65, followed by Dual-Platform at R96.97 and Bolt with the lowest at R89.57.

Overall, Bolt had a higher average total fare and higher driver payout despite having the lowest trip volume, while Uber had the highest commission and lowest driver payout. Dual-Platform was in the middle for all metrics.

Conclusion: Bolt offers the most favorable per-trip earnings for drivers with the highest average payout (R377.56) due to lower commission, while Uber offers the lowest payout (R351.25) due to higher commission. Platform affiliation has a direct impact on driver earnings, with Bolt being most profitable per trip in this dataset.

### RQ2:

### RQ3: Driver Payout and Payout-to-Fare Ratio by Ride Category

The analysis looked at Budget, Standard, Comfort, and Large Capacity rides to see which category gives drivers the highest average payout and the best payout-to-fare ratio. We only included trips with completed positive fares and used both the average trip ratio and the weighted payout-to-fare ratio.

Standard had the highest average driver payout at R365.11 followed by Large Capacity at R364.43, Budget at R363.46 and Comfort at R361.01. Standard also had the highest completed-trip volume with 8,507 trips and Comfort had the lowest with 8,104 trips.

The payout-to-fare ratios were nearly the same in the categories. The highest average trip ratio was recorded by Standard and Large Capacity at 78.92%, followed by Budget with 78.89% and Comfort with 78.87%. Standard and Budget were highest at 78.54% for the weighted ratio.

Overall, standard category had a higher average driver payout and trip volume, while Budget was equally strong on the weighted payout to fare ratio. However, the differences are very small, suggesting that ride category has limited influence on driver payout.

**Conclusion:** Standard (UberX/Bolt) has the highest average driver payout and completed-trip volume, but there is no significant financial difference between the four categories. Drivers earn roughly the same percentage of the fare no matter what category the ride falls into.

### RQ4:

 How Do Trip Distance, Duration, Peak Periods and Surge Pricing Affect Driver Payouts?

## 4.1 Introduction

This research question investigates how trip distance, trip duration, peak periods and surge pricing relate to driver payouts in the South African ride-hailing dataset. The purpose is to determine whether drivers receive higher payouts for longer trips, whether earnings differ between peak and off-peak periods, and how surge pricing influences the amount drivers receive.

The analysis uses completed trips from the `trip_headers` and `trip_fare_breakdown` tables in the `cmpg321_data_alchemists` PostgreSQL database. Cancelled trips were excluded by filtering for trips with a status of `COMPLETED`. Average driver payouts and payout rates were compared across different categories. Correlation analysis was also conducted to measure the strength and direction of the relationships between selected trip factors and driver payouts.

## 4.2 Peak and Off-Peak Periods

The first analysis compares driver payouts during peak and off-peak periods. Peak periods were defined as 06:00–08:59 and 16:00–18:59, while trips outside these periods were classified as off-peak.

| Measure | Off-Peak | Peak |
|---|---:|---:|
| Completed trips | 25,056 | 8,275 |
| Average distance (km) | 24.62 | 24.91 |
| Average duration (minutes) | 75.8 | 76.3 |
| Average surge multiplier | 1.13 | 1.71 |
| Average driver payout | R324.33 | R482.20 |
| Average payout per hour | R269.05 | R395.86 |

The results show that the average driver payout during peak periods was R482.20, compared with R324.33 during off-peak periods. This represents a difference of R157.87 per trip. The average payout per hour was also higher during peak periods, at R395.86 compared with R269.05 off-peak.

The average trip distance and duration were relatively similar between the two periods. However, the average surge multiplier was considerably higher during peak periods. This suggests that surge pricing may contribute to the higher payouts observed during peak periods. Nevertheless, these results alone cannot establish that peak timing or surge pricing directly causes higher earnings.

## 4.3 Effect of Surge Pricing on Driver Payouts

The second analysis groups completed trips according to their surge multiplier. Trips were classified into four categories: no surge, low surge, medium surge and high surge.

| Surge category | Completed trips | Average fare | Average driver payout | Average payout per hour |
|---|---:|---:|---:|---:|
| No Surge | 22,393 | R366.40 | R288.64 | R240.17 |
| Low (1.01–1.49) | 1,498 | R496.74 | R389.43 | R319.50 |
| Medium (1.50–1.99) | 5,045 | R615.48 | R482.14 | R391.84 |
| High (2.00+) | 4,395 | R767.97 | R600.10 | R496.79 |

The findings show a consistent increase in average driver payout as the surge multiplier increases. Trips without surge pricing had an average payout of R288.64, while trips in the high-surge category had an average payout of R600.10. The difference was R311.46 per trip.

Average payout per hour also increased from R240.17 for trips without surge pricing to R496.79 for trips with a high surge multiplier. This indicates that higher surge categories are associated with higher driver payouts and payout rates in the dataset.

However, the results should be interpreted with care because trips in different surge categories may also differ in other ways, including demand conditions, distance and duration. The analysis identifies an association rather than proving that surge pricing alone explains the difference.

## 4.4 Effect of Trip Distance on Driver Payouts

The third analysis investigates the relationship between trip distance and driver payouts. Completed trips were grouped into four distance categories.

| Distance category | Completed trips | Average driver payout | Average payout per km | Average payout per hour |
|---|---:|---:|---:|---:|
| Short (<5 km) | 2,554 | R93.84 | R30.94 | R358.07 |
| Medium (5–14.99 km) | 7,113 | R179.33 | R18.48 | R313.04 |
| Long (15–29.99 km) | 10,837 | R338.03 | R15.08 | R295.12 |
| Very Long (30+ km) | 12,827 | R540.90 | R13.92 | R286.70 |

The results demonstrate that average driver payout increases as trip distance increases. Short trips generated an average payout of R93.84, whereas very long trips generated an average payout of R540.90.

However, the payout per kilometre decreased as distance increased. Short trips had an average payout of R30.94 per kilometre, compared with R13.92 per kilometre for very long trips. Average payout per hour also declined across the distance categories, from R358.07 for short trips to R286.70 for very long trips.

These findings indicate that longer trips generally provide higher total payouts, but they do not necessarily provide higher earnings relative to the distance travelled or time spent. Therefore, total payout alone may not provide a complete picture of driver earnings efficiency.

## 4.5 Effect of Trip Duration on Driver Payouts

The fourth analysis examines how trip duration relates to driver payouts. Trips were divided into quick, standard, extended and long-duration categories.

| Duration category | Completed trips | Average driver payout | Average payout per hour |
|---|---:|---:|---:|
| Quick (<15 minutes) | 914 | R83.20 | R451.44 |
| Standard (15–29 minutes) | 3,827 | R122.28 | R331.27 |
| Extended (30–59 minutes) | 7,947 | R226.60 | R306.94 |
| Long (60+ minutes) | 20,643 | R473.37 | R285.68 |

The results show that average total payout increased with trip duration. Quick trips generated an average payout of R83.20, while trips lasting 60 minutes or longer generated an average payout of R473.37.

In contrast, average payout per hour decreased as trip duration increased. Quick trips had an average payout rate of R451.44 per hour, compared with R285.68 per hour for long trips.

This suggests that although longer trips generally produce higher total payouts, they may offer lower average hourly payout rates. Short trips may have higher hourly payout rates in this dataset, although the results do not account for all possible factors affecting actual driver profitability, such as waiting time between trips, fuel consumption, maintenance and other operating expenses.

## 4.6 Combined Effect of Peak Periods and Surge Pricing

The fifth analysis combines peak-period classification with surge categories to examine whether the relationship between surge pricing and driver payouts differs between peak and off-peak periods.

| Period | Surge category | Completed trips | Average driver payout | Average payout per hour |
|---|---|---:|---:|---:|
| Off-Peak | No Surge | 21,071 | R288.13 | R240.15 |
| Off-Peak | Low Surge | 527 | R381.15 | R317.48 |
| Off-Peak | Medium Surge | 1,853 | R475.86 | R390.78 |
| Off-Peak | High Surge | 1,605 | R605.92 | R492.00 |
| Peak | No Surge | 1,322 | R296.62 | R240.52 |
| Peak | Low Surge | 971 | R393.93 | R320.59 |
| Peak | Medium Surge | 3,192 | R485.79 | R392.45 |
| Peak | High Surge | 2,790 | R596.76 | R499.55 |

The combined analysis shows that average driver payouts increased as the surge category increased during both peak and off-peak periods. For example, off-peak average payouts rose from R288.13 for trips without surge pricing to R605.92 for high-surge trips. During peak periods, average payouts increased from R296.62 to R596.76 across the same categories.

At the same time, the comparison shows that peak-period trips did not always have the highest average payout within every surge category. For high-surge trips, the off-peak average payout was R605.92, compared with R596.76 during peak periods. However, the average payout per hour was higher during peak periods for this category, at R499.55 compared with R492.00 off-peak.

These differences suggest that both peak-period classification and surge pricing are relevant when examining driver payouts. The results also demonstrate that the relationship is not identical across all categories. Other trip characteristics may contribute to the observed differences.

## 4.7 Correlation Analysis

The final analysis measures the correlation between selected trip factors and driver payouts. Correlation coefficients range from -1 to +1. Values closer to +1 indicate a stronger positive relationship, while values close to zero indicate a weak linear relationship.

| Factor | Correlation with driver payout |
|---|---:|
| Trip distance | 0.754 |
| Trip duration | 0.735 |
| Surge multiplier | 0.527 |
| Tip amount | 0.074 |

Trip distance had the strongest positive correlation with driver payout, with a coefficient of 0.754. Trip duration also had a strong positive correlation of 0.735. These findings support the earlier results showing that longer and more distant trips tend to have higher total payouts.

The surge multiplier had a moderate positive correlation of 0.527, indicating that higher surge multipliers were associated with higher driver payouts. This is consistent with the surge-category analysis.

Tip amount had a very weak positive correlation of 0.074. This indicates that tip amount had little linear association with total driver payout in this dataset compared with distance, duration and surge multiplier.

Correlation does not establish causation. Furthermore, because distance, duration and other trip characteristics may be related to one another, the correlation values should not be interpreted as the independent effect of each factor.

## 4.8 Conclusion

The findings indicate that trip distance, trip duration, peak periods and surge pricing are all relevant when analysing driver payouts in the dataset, although their relationships with earnings differ.

First, peak-period trips had a higher average payout and average payout per hour than off-peak trips. Second, average driver payouts increased consistently across the surge categories, demonstrating a positive association between surge pricing and driver payouts. Third, longer and more distant trips generated higher total payouts, but their average payout per kilometre or per hour was generally lower. Finally, correlation analysis identified trip distance and duration as the factors most strongly correlated with driver payout, followed by the surge multiplier. Tip amount had only a weak positive correlation.

Overall, the results suggest that drivers should not evaluate trips using total payout alone. Payout per kilometre and payout per hour provide additional perspectives on earnings. However, these measures are not equivalent to net profit because the analysis does not deduct all driver operating expenses. Further analysis incorporating fuel costs, vehicle expenses, waiting time and other relevant variables would provide a more complete understanding of driver profitability.

The research question is therefore answered by showing that higher distance, longer duration and higher surge multipliers are associated with higher total driver payouts, while peak periods are associated with higher average payouts in the dataset. These relationships should be interpreted as descriptive findings rather than proof of causation.


### RQ5:

### RQ6: Driver Net Earnings Per Hour After Estimated Fuel Costs

This analysis examined whether estimated driver net earnings per hour meet the South African national minimum-wage benchmark of R30.23 per hour. Only completed trips were included. Estimated fuel costs were deducted from driver payouts using vehicle model fuel-consumption assumptions and monthly Petrol 95 prices based on the trip date and operating region.

A total of 33,331 completed trips were analysed. The average driver payout was R363.53, while the average estimated fuel cost was R31.27. This resulted in average estimated net earnings of R332.26 per completed trip and estimated net earnings of **R262.52 per hour**.

All seven cities exceeded the R30.23 benchmark. Cape Town recorded the highest estimated net earnings per hour at **R333.27**, followed by Johannesburg at **R295.62** and Durban at **R278.29**. Potchefstroom recorded the lowest at **R218.09**, but still remained well above the benchmark.

These results suggest that, after estimated fuel costs, drivers in the dataset earn above the selected minimum-wage benchmark. However, the results represent estimated net earnings rather than actual profit because costs such as maintenance, insurance, depreciation, tyres and vehicle financing were not included.

**Figure:** Estimated Driver Net Earnings Per Hour by City compared with the R30.23 minimum-wage benchmark.
