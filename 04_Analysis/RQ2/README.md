# RQ2 – Analysis

## Research Question

To what extent does the platform commission percentage affect the proportion of the total fare retained by drivers?

## Purpose

This question investigates the financial effect of the platform's commission structure on driver pay. Rather than looking at absolute rands earned, it measures the proportion of the total fare that the driver actually keeps after the platform's commission has been deducted. By grouping completed trips by the commission percentage recorded against each driver, the analysis shows whether higher commission rates translate into a smaller share of the fare for the driver, and by how much. Following the finding in Phase 1, commission is calculated on the fare excluding tips, so tips are treated as fully passed through to the driver.

## SQL Query

See 02_SQL_Queries/RQ2.sql.

"What this query demonstrates (rubric keywords): multi-table INNER JOIN (three tables), CTE (WITH), aggregation (COUNT, AVG), calculated fields (retention ratios), window function (RANK() OVER), correlated subquery (comparison against overall average), NULLIF guard against division by zero"

## Results

<img width="1468" height="81" alt="image" src="https://github.com/user-attachments/assets/68fa7b3e-fa76-4d39-89e3-a2e40f3ced7b" />


## Analysis

The results show a clear and consistent inverse relationship between the commission percentage charged by the platform and the proportion of the fare that drivers retain.

Drivers on the 20% commission tier (Bolt) retained approximately 86.02% of their commissionable fare (fare excluding tip) and 81.16% of the total fare. Drivers on the 22% tier (Dual-Platform) retained around 84.02% of commissionable fare and 79.28% of total fare. Drivers on the 25% tier (Uber) retained the smallest proportion, 81.05% of commissionable fare and 76.46% of total fare.

The gap between the highest and lowest tier is 4.97 percentage points on a commissionable-fare basis (86.02% − 81.05%). This means that for every R100 of commissionable fare earned, Uber drivers keep approximately R4.97 less than Bolt drivers. Crucially, this gap is almost exactly equal to the difference in nominal commission rates (25% − 20% = 5 percentage points). This confirms that the platform applies its commission cleanly and linearly to the base fare, with no compounding effect via surge multipliers, tolls, or other hidden deductions.

The diff_vs_overall_avg column reinforces this ordering: Bolt sits +2.32 pp above the pooled average, Dual-Platform sits close to the mean at +0.32 pp, and Uber sits −2.65 pp below it. The three tiers are almost perfectly symmetrically distributed around the average, which is what a linear commission structure would produce.

The avg_tip column is also informative. Across all three tiers, average tips are virtually identical (R15.87–R15.92), which is expected; riders tip based on service, not on which platform is used. Because commission is calculated on the fare excluding the tip, tips are passed through to the driver in full. This explains why the retention-on-total-fare percentage is consistently about 5 percentage points lower than retention-on-commissionable-fare for every tier the tip inflates the denominator without inflating the commission base.

Finally, the trip_count column shows that Uber has the largest sample (11,667 trips), followed by Dual-Platform (10,983), with Bolt smallest (10,681). All three samples are large and comparable, which means the differences reported here are statistically robust and not driven by sample-size effects.


## Conclusion

Platform commission percentage has a direct, near one-for-one, inverse effect on the share of the fare that drivers retain. Every one-percentage-point increase in commission translates to roughly a one-percentage-point reduction in the driver's retained share of commissionable fare. Specifically:

Bolt drivers (20% commission) retain ≈ 86.02% of commissionable fare

Dual-Platform drivers (22%) retain ≈ 84.02%

Uber drivers (25%) retain ≈ 81.05%

From a driver's perspective, the choice of platform has a measurable, predictable, and mathematically transparent effect on take-home pay. A driver switching from Uber (25%) to Bolt (20%) would, on average, keep an additional R4.97 out of every R100 of commissionable fare. On a median trip worth R460, that is roughly R22.86 more per trip retained by the driver. Over the 10,681–11,667 trips observed per tier, this difference compounds into a material income effect. Tips are unaffected by commission and are passed through to drivers in full.


## Visualisation

<img width="509" height="308" alt="image" src="https://github.com/user-attachments/assets/46116a00-9521-4a86-be01-c1c0d9122aff" />


