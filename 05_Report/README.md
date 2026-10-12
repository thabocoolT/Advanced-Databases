### RQ1: Average Total Fare, Platform Commission, and Driver Payout by Platform Affiliation

The analysis looked at Uber, Bolt, and Dual-Platform (Both) drivers to see which affiliation gives the highest average total fare, platform commission, and driver payout. We only included completed trips with valid fare breakdowns.

Bolt had the highest average total fare at R467.13 followed by Uber at R461.90 and Dual-Platform at R459.89. Bolt also had the highest average driver payout at R377.56, followed by Dual-Platform at R362.92 and Uber at R351.25. Uber had the highest completed-trip volume with 11,667 trips, followed by Dual-Platform with 10,983 and Bolt with 10,681 trips.

The platform commissions differed significantly. Uber retained the highest average commission at R110.65, followed by Dual-Platform at R96.97 and Bolt with the lowest at R89.57.

Overall, Bolt had a higher average total fare and higher driver payout despite having the lowest trip volume, while Uber had the highest commission and lowest driver payout. Dual-Platform was in the middle for all metrics.

Conclusion: Bolt offers the most favorable per-trip earnings for drivers with the highest average payout (R377.56) due to lower commission, while Uber offers the lowest payout (R351.25) due to higher commission. Platform affiliation has a direct impact on driver earnings, with Bolt being most profitable per trip in this dataset.

### RQ2: Platform Commission and Driver Fare Retention

This research question examined how platform commission rates relate to the share of trip fares retained by drivers on Bolt, Dual-Platform and Uber. The analysis used completed trips with valid fare information and compared retention based on both total fare and commissionable fare.

| Platform affiliation | Commission rate | Completed trips | Average retention of total fare | Average retention of commissionable fare |
| -------------------- | --------------: | --------------: | ------------------------------: | ---------------------------------------: |
| Bolt                 |             20% |          10,681 |                          81.16% |                                   80.20% |
| Dual-Platform (Both) |             22% |          10,983 |                          79.28% |                                   78.22% |
| Uber                 |             25% |          11,667 |                          76.46% |                                   75.26% |

Bolt recorded the highest average retention of commissionable fare at 80.20%, while Uber recorded the lowest at 75.26%. This represents a difference of 4.94 percentage points. The total-fare retention results show a similar pattern, with Bolt at 81.16% and Uber at 76.46%.

Commissionable-fare retention excludes tips from both the payout and fare, while total-fare retention includes the full recorded payout and fare. The two measures therefore describe different aspects of driver fare retention.

### Conclusion:

In this dataset, Bolt drivers retained the highest average share of commissionable fare, while Uber drivers retained the lowest. The results show an association between recorded platform commission rates and driver fare retention, but other factors may also affect the amounts drivers receive.

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

| Measure                    | Off-Peak |    Peak |
| -------------------------- | -------: | ------: |
| Completed trips            |   25,056 |   8,275 |
| Average distance (km)      |    24.62 |   24.91 |
| Average duration (minutes) |     75.8 |    76.3 |
| Average surge multiplier   |     1.13 |    1.71 |
| Average driver payout      |  R324.33 | R482.20 |
| Average payout per hour    |  R269.05 | R395.86 |

The results show that the average driver payout during peak periods was R482.20, compared with R324.33 during off-peak periods. This represents a difference of R157.87 per trip. The average payout per hour was also higher during peak periods, at R395.86 compared with R269.05 off-peak.

The average trip distance and duration were relatively similar between the two periods. However, the average surge multiplier was considerably higher during peak periods. This suggests that surge pricing may contribute to the higher payouts observed during peak periods. Nevertheless, these results alone cannot establish that peak timing or surge pricing directly causes higher earnings.

## 4.3 Effect of Surge Pricing on Driver Payouts

The second analysis groups completed trips according to their surge multiplier. Trips were classified into four categories: no surge, low surge, medium surge and high surge.

| Surge category     | Completed trips | Average fare | Average driver payout | Average payout per hour |
| ------------------ | --------------: | -----------: | --------------------: | ----------------------: |
| No Surge           |          22,393 |      R366.40 |               R288.64 |                 R240.17 |
| Low (1.01–1.49)    |           1,498 |      R496.74 |               R389.43 |                 R319.50 |
| Medium (1.50–1.99) |           5,045 |      R615.48 |               R482.14 |                 R391.84 |
| High (2.00+)       |           4,395 |      R767.97 |               R600.10 |                 R496.79 |

The findings show a consistent increase in average driver payout as the surge multiplier increases. Trips without surge pricing had an average payout of R288.64, while trips in the high-surge category had an average payout of R600.10. The difference was R311.46 per trip.

Average payout per hour also increased from R240.17 for trips without surge pricing to R496.79 for trips with a high surge multiplier. This indicates that higher surge categories are associated with higher driver payouts and payout rates in the dataset.

However, the results should be interpreted with care because trips in different surge categories may also differ in other ways, including demand conditions, distance and duration. The analysis identifies an association rather than proving that surge pricing alone explains the difference.

## 4.4 Effect of Trip Distance on Driver Payouts

The third analysis investigates the relationship between trip distance and driver payouts. Completed trips were grouped into four distance categories.

| Distance category   | Completed trips | Average driver payout | Average payout per km | Average payout per hour |
| ------------------- | --------------: | --------------------: | --------------------: | ----------------------: |
| Short (<5 km)       |           2,554 |                R93.84 |                R30.94 |                 R358.07 |
| Medium (5–14.99 km) |           7,113 |               R179.33 |                R18.48 |                 R313.04 |
| Long (15–29.99 km)  |          10,837 |               R338.03 |                R15.08 |                 R295.12 |
| Very Long (30+ km)  |          12,827 |               R540.90 |                R13.92 |                 R286.70 |

The results demonstrate that average driver payout increases as trip distance increases. Short trips generated an average payout of R93.84, whereas very long trips generated an average payout of R540.90.

However, the payout per kilometre decreased as distance increased. Short trips had an average payout of R30.94 per kilometre, compared with R13.92 per kilometre for very long trips. Average payout per hour also declined across the distance categories, from R358.07 for short trips to R286.70 for very long trips.

These findings indicate that longer trips generally provide higher total payouts, but they do not necessarily provide higher earnings relative to the distance travelled or time spent. Therefore, total payout alone may not provide a complete picture of driver earnings efficiency.

## 4.5 Effect of Trip Duration on Driver Payouts

The fourth analysis examines how trip duration relates to driver payouts. Trips were divided into quick, standard, extended and long-duration categories.

| Duration category        | Completed trips | Average driver payout | Average payout per hour |
| ------------------------ | --------------: | --------------------: | ----------------------: |
| Quick (<15 minutes)      |             914 |                R83.20 |                 R451.44 |
| Standard (15–29 minutes) |           3,827 |               R122.28 |                 R331.27 |
| Extended (30–59 minutes) |           7,947 |               R226.60 |                 R306.94 |
| Long (60+ minutes)       |          20,643 |               R473.37 |                 R285.68 |

The results show that average total payout increased with trip duration. Quick trips generated an average payout of R83.20, while trips lasting 60 minutes or longer generated an average payout of R473.37.

In contrast, average payout per hour decreased as trip duration increased. Quick trips had an average payout rate of R451.44 per hour, compared with R285.68 per hour for long trips.

This suggests that although longer trips generally produce higher total payouts, they may offer lower average hourly payout rates. Short trips may have higher hourly payout rates in this dataset, although the results do not account for all possible factors affecting actual driver profitability, such as waiting time between trips, fuel consumption, maintenance and other operating expenses.

## 4.6 Combined Effect of Peak Periods and Surge Pricing

The fifth analysis combines peak-period classification with surge categories to examine whether the relationship between surge pricing and driver payouts differs between peak and off-peak periods.

| Period   | Surge category | Completed trips | Average driver payout | Average payout per hour |
| -------- | -------------- | --------------: | --------------------: | ----------------------: |
| Off-Peak | No Surge       |          21,071 |               R288.13 |                 R240.15 |
| Off-Peak | Low Surge      |             527 |               R381.15 |                 R317.48 |
| Off-Peak | Medium Surge   |           1,853 |               R475.86 |                 R390.78 |
| Off-Peak | High Surge     |           1,605 |               R605.92 |                 R492.00 |
| Peak     | No Surge       |           1,322 |               R296.62 |                 R240.52 |
| Peak     | Low Surge      |             971 |               R393.93 |                 R320.59 |
| Peak     | Medium Surge   |           3,192 |               R485.79 |                 R392.45 |
| Peak     | High Surge     |           2,790 |               R596.76 |                 R499.55 |

The combined analysis shows that average driver payouts increased as the surge category increased during both peak and off-peak periods. For example, off-peak average payouts rose from R288.13 for trips without surge pricing to R605.92 for high-surge trips. During peak periods, average payouts increased from R296.62 to R596.76 across the same categories.

At the same time, the comparison shows that peak-period trips did not always have the highest average payout within every surge category. For high-surge trips, the off-peak average payout was R605.92, compared with R596.76 during peak periods. However, the average payout per hour was higher during peak periods for this category, at R499.55 compared with R492.00 off-peak.

These differences suggest that both peak-period classification and surge pricing are relevant when examining driver payouts. The results also demonstrate that the relationship is not identical across all categories. Other trip characteristics may contribute to the observed differences.

## 4.7 Correlation Analysis

The final analysis measures the correlation between selected trip factors and driver payouts. Correlation coefficients range from -1 to +1. Values closer to +1 indicate a stronger positive relationship, while values close to zero indicate a weak linear relationship.

| Factor           | Correlation with driver payout |
| ---------------- | -----------------------------: |
| Trip distance    |                          0.754 |
| Trip duration    |                          0.735 |
| Surge multiplier |                          0.527 |
| Tip amount       |                          0.074 |

Trip distance had the strongest positive correlation with driver payout, with a coefficient of 0.754. Trip duration also had a strong positive correlation of 0.735. These findings support the earlier results showing that longer and more distant trips tend to have higher total payouts.

The surge multiplier had a moderate positive correlation of 0.527, indicating that higher surge multipliers were associated with higher driver payouts. This is consistent with the surge-category analysis.

Tip amount had a very weak positive correlation of 0.074. This indicates that tip amount had little linear association with total driver payout in this dataset compared with distance, duration and surge multiplier.

Correlation does not establish causation. Furthermore, because distance, duration and other trip characteristics may be related to one another, the correlation values should not be interpreted as the independent effect of each factor.

## 4.8 Conclusion

The findings indicate that trip distance, trip duration, peak periods and surge pricing are all relevant when analysing driver payouts in the dataset, although their relationships with earnings differ.

First, peak-period trips had a higher average payout and average payout per hour than off-peak trips. Second, average driver payouts increased consistently across the surge categories, demonstrating a positive association between surge pricing and driver payouts. Third, longer and more distant trips generated higher total payouts, but their average payout per kilometre or per hour was generally lower. Finally, correlation analysis identified trip distance and duration as the factors most strongly correlated with driver payout, followed by the surge multiplier. Tip amount had only a weak positive correlation.

Overall, the results suggest that drivers should not evaluate trips using total payout alone. Payout per kilometre and payout per hour provide additional perspectives on earnings. However, these measures are not equivalent to net profit because the analysis does not deduct all driver operating expenses. Further analysis incorporating fuel costs, vehicle expenses, waiting time and other relevant variables would provide a more complete understanding of driver profitability.

The research question is therefore answered by showing that higher distance, longer duration and higher surge multipliers are associated with higher total driver payouts, while peak periods are associated with higher average payouts in the dataset. These relationships should be interpreted as descriptive findings rather than proof of causation.

### RQ5: Highest-Paying City and Ride-Category Combination

This research question compared completed trips by operating city and ride category to identify which combination produced the highest average driver payout per trip. Combinations with fewer than 30 completed trips were excluded from the analysis.

Cape Town – Budget (Uber Go/Bolt Go) recorded the highest average payout per completed trip at **R456.41**, based on 1,297 trips. However, Cape Town – Large Capacity recorded the highest payout per kilometre at **R20.71** and the highest payout per hour at **R375.86**.

The results show that the operating city had a stronger influence on average payout than the ride category in this dataset. Cape Town combinations occupied the top four positions in the average-payout ranking. Differences between ride categories within the same city were relatively small.

The best ride category also depended on the measure used. A category with the highest total payout per trip did not always have the highest payout per kilometre or per hour.

**Conclusion:** Cape Town – Budget produced the highest average payout per completed trip, while Cape Town – Large Capacity performed best in payout per kilometre and per hour. Drivers should consider both operating location and earnings efficiency when comparing ride categories.

### RQ6: Driver Net Earnings Per Hour After Estimated Fuel Costs

This analysis examined whether estimated driver net earnings per hour after fuel costs exceeded the selected South African national minimum-wage benchmarks. Only completed trips with valid positive trip durations were included. Fuel costs were estimated using each driver's recorded vehicle model, assumed model-level fuel consumption, trip distance, and the monthly Petrol 95 price applicable to the trip date and operating region.

The validation checks confirmed that the RQ6 estimates include all 33,331 completed trip headers. The 800 drivers with vehicle records each had exactly one vehicle record, and the validation query returned no rows for multiple vehicle records or unsupported vehicle fuel-rate assumptions.

#### Overall period comparison

| Measure                                            | March 2025 – February 2026 |                 March 2026 |
| -------------------------------------------------- | -------------------------: | -------------------------: |
| Completed trips                                    |                     30,623 |                      2,708 |
| Average driver payout per trip                     |                    R363.71 |                    R361.44 |
| Average estimated fuel cost per trip               |                     R31.42 |                     R29.57 |
| Average estimated net earnings after fuel per trip |                    R332.29 |                    R331.87 |
| Estimated net earnings after fuel per hour         |                    R262.51 |                    R262.56 |
| Hourly benchmark                                   |                     R28.79 |                     R30.23 |
| Result                                             | Meets or exceeds benchmark | Meets or exceeds benchmark |

For March 2025 to February 2026, estimated net earnings after fuel were R262.51 per hour, above the selected benchmark of R28.79. In March 2026, the estimated rate was R262.56 per hour, above the R30.23 benchmark. These figures are based on recorded trip duration and estimated fuel costs.

#### Comparison by city

| Operating city | Completed trips | Average driver payout | Average estimated fuel cost | Average estimated net earnings after fuel | Estimated net earnings after fuel per hour |
| -------------- | --------------: | --------------------: | --------------------------: | ----------------------------------------: | -----------------------------------------: |
| Cape Town      |           5,126 |               R448.00 |                      R30.23 |                                   R417.77 |                                    R333.27 |
| Johannesburg   |           4,107 |               R408.13 |                      R31.71 |                                   R376.41 |                                    R295.62 |
| Durban         |           4,671 |               R384.23 |                      R31.01 |                                   R353.23 |                                    R278.29 |
| Pretoria       |           4,651 |               R356.85 |                      R31.81 |                                   R325.04 |                                    R255.46 |
| Gqeberha       |           4,597 |               R324.93 |                      R30.25 |                                   R294.68 |                                    R233.51 |
| Vanderbijlpark |           4,908 |               R323.33 |                      R32.24 |                                   R291.10 |                                    R227.83 |
| Potchefstroom  |           5,271 |               R305.24 |                      R31.66 |                                   R273.58 |                                    R218.09 |

Cape Town recorded the highest estimated net earnings after fuel per hour at R333.27, followed by Johannesburg at R295.62 and Durban at R278.29. Potchefstroom recorded the lowest at R218.09 per hour. All seven cities were above the selected R30.23-per-hour benchmark when it is used as a common reference for this comparison.

#### Comparison by vehicle model

| Make and model       | Completed trips | Average driver payout | Average estimated fuel cost | Average estimated net earnings after fuel | Estimated net earnings after fuel per hour |
| -------------------- | --------------: | --------------------: | --------------------------: | ----------------------------------------: | -----------------------------------------: |
| Hyundai Grand i10    |           3,381 |               R367.83 |                      R27.92 |                                   R339.91 |                                    R273.03 |
| Volkswagen Polo Vivo |           3,656 |               R366.77 |                      R30.10 |                                   R336.67 |                                    R268.70 |
| Renault Triber       |           4,170 |               R367.17 |                      R28.99 |                                   R338.18 |                                    R263.13 |
| Nissan Almera        |           3,332 |               R363.04 |                      R32.46 |                                   R330.58 |                                    R262.38 |
| Kia Picanto          |           3,519 |               R361.24 |                      R26.61 |                                   R334.63 |                                    R262.12 |
| Suzuki Ertiga        |           3,472 |               R357.76 |                      R28.44 |                                   R329.32 |                                    R260.93 |
| Toyota Corolla Quest |           3,849 |               R368.13 |                      R33.33 |                                   R334.80 |                                    R259.38 |
| BMW 3 Series         |           3,943 |               R355.73 |                      R33.11 |                                   R322.62 |                                    R258.72 |
| Toyota Avanza        |           4,009 |               R363.79 |                      R39.28 |                                   R324.51 |                                    R256.16 |

The Hyundai Grand i10 had the highest estimated net earnings after fuel per hour at R273.03, while the Toyota Avanza had the lowest at R256.16. The Avanza also had the highest average estimated fuel cost per trip at R39.28. These are descriptive comparisons and do not show that vehicle model alone caused the differences.

#### Conclusion and limitations

The results answer RQ6 positively for the estimated measure used: both period-level hourly estimates and all city and vehicle-model estimates exceeded the selected R30.23-per-hour reference. The results should nevertheless be interpreted as **estimated net earnings after fuel costs**, not actual profit or take-home pay. The calculation does not deduct maintenance, insurance, depreciation, tyres, financing or other operating costs, and recorded trip duration does not include waiting time or time between trips. Fuel consumption is based on model-level assumptions rather than measured consumption for each trip. Therefore, the analysis is descriptive and is not proof of legal minimum-wage compliance.

**Suggested figure:** Estimated Driver Net Earnings After Fuel Per Hour by City, with a horizontal R30.23 benchmark line.
