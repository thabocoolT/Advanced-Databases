### RQ1: Average Total Fare, Platform Commission, and Driver Payout by Platform Affiliation

The analysis looked at Uber, Bolt, and Dual-Platform (Both) drivers to see which affiliation gives the highest average total fare, platform commission, and driver payout. We only included completed trips with valid fare breakdowns.

Bolt had the highest average total fare at R467.13 followed by Uber at R461.90 and Dual-Platform at R459.89. Bolt also had the highest average driver payout at R377.56, followed by Dual-Platform at R362.92 and Uber at R351.25. Uber had the highest completed-trip volume with 11,667 trips, followed by Dual-Platform with 10,983 and Bolt with 10,681 trips.

The platform commissions differed significantly. Uber retained the highest average commission at R110.65, followed by Dual-Platform at R96.97 and Bolt with the lowest at R89.57.

Overall, Bolt had a higher average total fare and higher driver payout despite having the lowest trip volume, while Uber had the highest commission and lowest driver payout. Dual-Platform was in the middle for all metrics.

Conclusion: Bolt offers the most favorable per-trip earnings for drivers with the highest average payout (R377.56) due to lower commission, while Uber offers the lowest payout (R351.25) due to higher commission. Platform affiliation has a direct impact on driver earnings, with Bolt being most profitable per trip in this dataset.

### RQ2:

### RQ3:

### RQ4:

### RQ5:

### RQ6: Driver Net Earnings Per Hour After Estimated Fuel Costs

This analysis examined whether estimated driver net earnings per hour meet the South African national minimum-wage benchmark of R30.23 per hour. Only completed trips were included. Estimated fuel costs were deducted from driver payouts using vehicle model fuel-consumption assumptions and monthly Petrol 95 prices based on the trip date and operating region.

A total of 33,331 completed trips were analysed. The average driver payout was R363.53, while the average estimated fuel cost was R31.27. This resulted in average estimated net earnings of R332.26 per completed trip and estimated net earnings of **R262.52 per hour**.

All seven cities exceeded the R30.23 benchmark. Cape Town recorded the highest estimated net earnings per hour at **R333.27**, followed by Johannesburg at **R295.62** and Durban at **R278.29**. Potchefstroom recorded the lowest at **R218.09**, but still remained well above the benchmark.

These results suggest that, after estimated fuel costs, drivers in the dataset earn above the selected minimum-wage benchmark. However, the results represent estimated net earnings rather than actual profit because costs such as maintenance, insurance, depreciation, tyres and vehicle financing were not included.

**Figure:** Estimated Driver Net Earnings Per Hour by City compared with the R30.23 minimum-wage benchmark.
