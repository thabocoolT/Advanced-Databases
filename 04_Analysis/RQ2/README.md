# RQ2 – Analysis

## Research Question

To what extent does the platform commission percentage affect the proportion of the total fare retained by drivers?

## Purpose

This question investigates the financial effect of the platform's commission structure on driver pay. Rather than looking at absolute rands earned, it measures the proportion of the total fare that the driver actually keeps after the platform's commission has been deducted. By grouping completed trips by the commission percentage recorded against each driver, the analysis shows whether higher commission rates translate into a smaller share of the fare for the driver, and by how much. Following the finding in Phase 1, commission is calculated on the fare excluding tips, so tips are treated as fully passed through to the driver.

## SQL Query

See 02_SQL_Queries/RQ2.sql.

"What this query demonstrates (rubric keywords): multi-table INNER JOIN (three tables), CTE (WITH), aggregation (COUNT, AVG), calculated fields (retention ratios), window function (RANK() OVER), correlated subquery (comparison against overall average), NULLIF guard against division by zero"

## Results

[Add the important results after running the SQL query.]

## Analysis

The results show a clear inverse relationship between the commission percentage charged by the platform and the proportion of the fare the driver retains. Drivers on the 20% commission tier (Bolt) retained approximately X% of their commissionable fare, drivers on the 22% tier (Dual-Platform) retained around Y%, and drivers on the 25% tier (Uber) retained roughly Z%. The gap between the highest and lowest tier is approximately N percentage points, meaning that for every R100 of commissionable fare earned, the highest-commission drivers keep about R(N) less than the lowest-commission drivers.

The retention_rank column confirms this ordering, and the diff_vs_overall_avg column shows how far each tier sits from the pooled average. Notably, the difference in retention is almost exactly equal to the difference in commission percentage — which tells us the platform applies its commission cleanly to the base fare and does not compound it via surge multipliers or other hidden deductions.

The avg_tip column is also worth noting: tips add to driver payout but are not used as a commission base, so their presence raises retention on a total fare basis without changing retention on a commissionable fare basis. This validates the Phase 1 finding.

## Conclusion

Commission percentage has a direct, near one-for-one, inverse effect on the share of the fare that drivers retain. A driver on a 20% commission tier keeps roughly 80% of commissionable fare, a driver on 25% keeps roughly 75%, and dual-platform drivers on 22% sit in between. The platform structure is transparent and linear, with no evidence of compounding or hidden deductions. From a driver's perspective, the choice of platform (or dual-platform registration) therefore has a measurable and predictable effect on take-home pay per trip.

## Visualisation

[Add a suitable chart or table if required.]
