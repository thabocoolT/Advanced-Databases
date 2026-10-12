# RQ6 Analysis – Driver Net Earnings Per Hour After Estimated Fuel Costs

## Research Question

After estimating fuel costs, does average driver net earnings per hour meet the South African national minimum-wage benchmark of R30.23 per hour?

## Purpose

This analysis compares estimated driver earnings after fuel costs with the selected hourly benchmark. The benchmark comparison is descriptive: the calculated measure is not a complete measure of take-home pay and does not establish legal minimum-wage compliance.

## Method

Only completed trips with valid positive trip durations were included. Cancelled trips were excluded.

The calculation uses the recorded driver payout and estimates fuel costs from trip distance, assumed fuel consumption for the driver's recorded vehicle model, and the monthly Petrol 95 price applicable to the trip date and operating region.

**Estimated Fuel Cost = Distance (km) × Fuel Consumption (L/100 km) ÷ 100 × Fuel Price (R/L)**

**Estimated Net Earnings After Fuel = Driver Payout − Estimated Fuel Cost**

**Estimated Net Earnings Per Hour = Total Estimated Net Earnings After Fuel ÷ Total Trip Duration in Hours**

Monthly Petrol 95 prices were matched to each trip's month. Inland prices were applied to Johannesburg, Pretoria, Vanderbijlpark and Potchefstroom; coastal prices were applied to Cape Town, Durban and Gqeberha. Vehicle fuel-consumption rates are model-level assumptions, not measurements of actual fuel consumed on each trip.

The hourly calculation uses recorded trip duration. It does not include unpaid waiting time or time between trips, and it does not deduct maintenance, insurance, depreciation, tyres, finance costs or other operating expenses.

## Data Validation

The validation checks returned the following results:

| Validation check                                                |          Result |
| --------------------------------------------------------------- | --------------: |
| Completed trip headers                                          |          33,331 |
| Trips represented in the RQ6 estimates                          |          33,331 |
| Drivers with vehicle records                                    |             800 |
| Drivers with exactly one vehicle record                         |             800 |
| Drivers with multiple vehicle records                           | 0 rows returned |
| Trips without a matching supported vehicle fuel-rate assumption | 0 rows returned |

The number of trips in the RQ6 estimates matches the number of completed trip headers. Each of the 800 drivers with a vehicle record has exactly one vehicle record, and the unsupported-model validation returned no rows. These checks support the coverage and consistency of the current estimate table; they do not remove the uncertainty inherent in the fuel-consumption assumptions.

## Overall Results

The results cover 33,331 completed trips in two periods. The benchmark used is R28.79 per hour for March 2025–February 2026 and R30.23 per hour for March 2026.

| Measure                                            | March 2025 – February 2026 |                 March 2026 |
| -------------------------------------------------- | -------------------------: | -------------------------: |
| Completed trips                                    |                     30,623 |                      2,708 |
| Average driver payout per trip                     |                    R363.71 |                    R361.44 |
| Average estimated fuel cost per trip               |                     R31.42 |                     R29.57 |
| Average estimated net earnings after fuel per trip |                    R332.29 |                    R331.87 |
| Estimated net earnings after fuel per hour         |                    R262.51 |                    R262.56 |
| Hourly benchmark                                   |                     R28.79 |                     R30.23 |
| Result                                             | Meets or exceeds benchmark | Meets or exceeds benchmark |

Estimated net earnings after fuel were above the selected hourly benchmark in both periods. The estimated hourly rate was R262.51 for March 2025–February 2026 and R262.56 for March 2026. These are estimates based on trip-level data and the assumptions described above, not complete driver profit or proof of legal compliance.

## Results by Vehicle Model

| Make       | Model         | Completed trips | Average driver payout | Average estimated fuel cost | Average estimated net earnings after fuel | Estimated net earnings after fuel per hour |
| ---------- | ------------- | --------------: | --------------------: | --------------------------: | ----------------------------------------: | -----------------------------------------: |
| Hyundai    | Grand i10     |           3,381 |               R367.83 |                      R27.92 |                                   R339.91 |                                    R273.03 |
| Volkswagen | Polo Vivo     |           3,656 |               R366.77 |                      R30.10 |                                   R336.67 |                                    R268.70 |
| Renault    | Triber        |           4,170 |               R367.17 |                      R28.99 |                                   R338.18 |                                    R263.13 |
| Nissan     | Almera        |           3,332 |               R363.04 |                      R32.46 |                                   R330.58 |                                    R262.38 |
| Kia        | Picanto       |           3,519 |               R361.24 |                      R26.61 |                                   R334.63 |                                    R262.12 |
| Suzuki     | Ertiga        |           3,472 |               R357.76 |                      R28.44 |                                   R329.32 |                                    R260.93 |
| Toyota     | Corolla Quest |           3,849 |               R368.13 |                      R33.33 |                                   R334.80 |                                    R259.38 |
| BMW        | 3 Series      |           3,943 |               R355.73 |                      R33.11 |                                   R322.62 |                                    R258.72 |
| Toyota     | Avanza        |           4,009 |               R363.79 |                      R39.28 |                                   R324.51 |                                    R256.16 |

The Hyundai Grand i10 had the highest estimated net earnings after fuel per hour at R273.03, followed by the Volkswagen Polo Vivo at R268.70. The Toyota Avanza had the lowest estimated hourly amount among the listed models at R256.16 and the highest average estimated fuel cost per trip at R39.28. The BMW 3 Series had the lowest average estimated net earnings after fuel per trip at R322.62.

These comparisons should be interpreted cautiously. Vehicle models may be associated with different trips, distances, durations, operating locations and payouts. The results do not show that vehicle model alone caused the differences.

## Results by City

| Operating city | Completed trips | Average driver payout | Average estimated fuel cost | Average estimated net earnings after fuel | Estimated net earnings after fuel per hour |
| -------------- | --------------: | --------------------: | --------------------------: | ----------------------------------------: | -----------------------------------------: |
| Cape Town      |           5,126 |               R448.00 |                      R30.23 |                                   R417.77 |                                    R333.27 |
| Johannesburg   |           4,107 |               R408.13 |                      R31.71 |                                   R376.41 |                                    R295.62 |
| Durban         |           4,671 |               R384.23 |                      R31.01 |                                   R353.23 |                                    R278.29 |
| Pretoria       |           4,651 |               R356.85 |                      R31.81 |                                   R325.04 |                                    R255.46 |
| Gqeberha       |           4,597 |               R324.93 |                      R30.25 |                                   R294.68 |                                    R233.51 |
| Vanderbijlpark |           4,908 |               R323.33 |                      R32.24 |                                   R291.10 |                                    R227.83 |
| Potchefstroom  |           5,271 |               R305.24 |                      R31.66 |                                   R273.58 |                                    R218.09 |

Cape Town recorded the highest estimated net earnings after fuel per hour at R333.27, followed by Johannesburg at R295.62 and Durban at R278.29. Potchefstroom recorded the lowest estimated hourly amount at R218.09. All seven cities were above the selected R30.23-per-hour benchmark when that benchmark is used as a common reference for the city comparison.

The city differences appear alongside differences in average payouts and trip durations. Average estimated fuel costs were relatively close across the cities, ranging from R30.23 in Cape Town to R32.24 in Vanderbijlpark. The results are descriptive and should not be interpreted as evidence that location alone determines earnings.

## Overall Interpretation

The period comparison indicates that estimated driver net earnings after fuel exceeded the selected hourly benchmark in both periods. The vehicle-model comparison ranges from R256.16 to R273.03 per hour, while the city comparison ranges from R218.09 to R333.27 per hour. Each city and vehicle model listed is above R30.23 per hour in this estimate.

The benchmark comparison does not account for all time spent working or all costs incurred by drivers. Consequently, the results should be described as estimated net earnings after fuel costs, not profit, take-home pay, or confirmation of compliance with minimum-wage law.

## Conclusion

The answer to RQ6 is **yes, for the estimated trip-duration-based earnings measure used in this analysis**. Estimated net earnings after fuel were R262.51 per hour from March 2025 to February 2026 and R262.56 per hour in March 2026, exceeding the respective selected benchmarks of R28.79 and R30.23 per hour.

Cape Town had the highest estimated hourly amount among the cities at R333.27, while Potchefstroom had the lowest at R218.09. By vehicle model, the Hyundai Grand i10 had the highest estimate at R273.03 per hour and the Toyota Avanza had the lowest at R256.16 per hour.

This conclusion is limited to the assumptions and costs included in the calculation. It does not demonstrate actual profit or establish legal minimum-wage compliance.

## Limitations

- Fuel costs are estimates based on model-level fuel-consumption assumptions and monthly Petrol 95 prices; actual fuel use and prices paid by individual drivers may differ.
- Maintenance, insurance, depreciation, tyres, vehicle finance and other operating costs are not deducted.
- The hourly calculation uses recorded trip duration and excludes waiting time and time between trips.
- Differences between cities and vehicle models may reflect trip mix, trip duration, distance, payout and other factors; the comparisons do not establish causation.
- The benchmark comparison is descriptive and should not be treated as a legal determination of minimum-wage compliance.

## Suggested Visualisations

1. **Estimated Net Earnings After Fuel Per Hour by City:** a bar chart showing each city's estimated hourly amount and a horizontal R30.23 reference line.
2. **Estimated Net Earnings After Fuel Per Hour by Vehicle Model:** a bar chart comparing the nine vehicle models, with the same R30.23 reference line.
3. **Period Comparison:** a bar chart comparing the two period-level hourly estimates (R262.51 and R262.56) with their applicable benchmark values.
