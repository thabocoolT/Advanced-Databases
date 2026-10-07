# RQ3 – Ride-category payout analysis

## Research Question

Which ride category provides drivers with the highest average payout and the
most favorable payout to fare ratio?

## Purpose and method

This research question compares Budget, Standard, Comfort, and Large Capacity rides using completed trips. 
It measures the average driver payout per trip and the share of the fare paid to the driver. 
Cancelled and zero fare trips are excluded because they do not represent completed paid rides and a payout to fare ratio is undefined when the fare is zero.
The purpose is to determine whether any ride category provides drivers with a more favorable payout compared to the total fare paid for the trip.

The trip-level ratio is:

`driver_payout_zar / total_fare_zar`

Two category ratios are reported to make the weighting explicit:

- **Average trip ratio:** the arithmetic mean (average) of the individual trip ratios,
  each trip has equal weight.
- **Weighted ratio:** total driver payout divided by total fare for that category, higher-fare trips have more influence.

The analysis uses `trip_headers` joined to `trip_fare_breakdown`. The SQL also uses a left-join `sa_drivers` to count distinct drivers without dropping a trip if a driver record is absent. The read-only transaction protects the database while the report queries run.

## SQL queries

See [`02_SQL_Queries/RQ3.sql`](../../02_SQL_Queries/RQ3.sql). 
It includes:

1. A category summary with trip and driver counts, average and median payout,
   average fare, both payout to fare measures, average commission, distance,
   and duration. Window `RANK()` functions rank categories by average payout,
   average trip ratio, and weighted ratio.
2. A `HAVING` clause with a scalar sub-query to identify categories whose mean
   trip payout is above the overall completed-trip average.

The queries use `NULLIF` to guard division, and apply the completed-trip and
positive-fare filters before aggregation.

## Results

The data shows that there were 8,507 total trips completed in the Standard (UberX/Bolt) category this is the most of any category. Following the Standard category was Budget (Uber Go/Bolt Go), which had 8,386 total trips completed. Third, Large Capacity (UberXL/Bolt XL) completed 8,334 total trips. Finally, Comfort completed 8,104 total trips, making it the least popular category.

Standard had the highest average driver payout of R365.11, with Large Capacity at R364.43 and Budget at R363.46 close behind. Comfort had the lowest average driver payout of R361,01. Median payouts followed a slightly different pattern, with Budget having the highest median payout of R332.18, compared with R331.58 for Standard, R328.79 for Large Capacity and R324.26 for Comfort.

The average trip payout-to-fare percentage was similar across all four categories. Standard and Large Capacity both reached 78.92%, Budget was 78.89% and Comfort was 78.87%. The weighted payout-to-fare percentages were also closely grouped, ranging from 78.51% to 78.54%.

## Analysis

The results indicate that the differences between the ride categories are quite small.
This is a difference of just R4.10 per completed trip and illustrates that the ride category does not have a major impact on the average amount paid to drivers.

The payout-to-fare percentages are also quite consistent across the categories. The highest average payout-to-fare percentage was recorded by Standard and Large Capacity at 78.92%, while the lowest was recorded by Comfort at 78.87%. The difference is so small that it shows that drivers get a similar portion of the total fare, no matter the category of ride.

The results also reveal that Standard had the largest number of completed trips.
But the fact that it has the highest trip volume, doesn’t mean that it has the highest payout percentage. For example, Budget’s weighted payout-to-fare percentage was the highest, although the driver payout was lower than Standard and Large Capacity.

Another important observation was that the average total fare was relatively similar across the categories, with the fare ranging from R459.85 for Comfort to R464.87 for Standard. The average platform fee was also comparable, ranging from R98.84 to R99.77. This consistency is consistent with the finding that there are no large differences in financial outcomes across the ride categories.

Overall, the results indicate that Standard performs slightly better when considering average driver payout and trip volume, while Budget performs slightly better when considering the weighted payout-to-fare percentage. But the differences between the two is small and it does not indicate any major financial advantage of one category over the others.

## Conclusion

In conclusion, the results show that the Standard (UberX/Bolt) category provides the highest average driver payout and the highest number of completed trips. However, the differences between driver payouts and payout-to-fare percentages across all four ride categories are relatively small. Therefore, the analysis suggests that ride category has only a limited to small effect on driver payout, with Standard showing a slight advantage in overall driver earnings and trip volume.

## Visualization

[View Excel Results](04_Analysis/RQ3/RQ3_SQL_RESULTS_1.xlsx)

[View Excel Results](04_Analysis/RQ3/RQ3_SQL_RESULTS_2.xlsx)
