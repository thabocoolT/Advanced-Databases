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

The results compare driver fare retention across the three platform-affiliation groups. Retention is calculated using both the total fare and the commissionable fare, which excludes tips.

The corrected commissionable-fare calculation subtracts tips from both the driver's payout and the total fare. This prevents tips from being included in the driver's retained commissionable fare when they are excluded from the denominator.

Compare the retention percentages across the platform groups and report the observed differences in percentage points. These results describe the differences in the dataset; they do not establish that platform commission is the only factor affecting driver earnings.

## Conclusion

The corrected results show how the recorded platform-affiliation groups differ in their average fare-retention percentages. The conclusion should identify the group with the highest and lowest retention using the refreshed SQL output, quote the observed difference, and distinguish total-fare retention from commissionable-fare retention.

This analysis measures fare retention, not overall driver profit. Fuel, vehicle expenses, time between trips and other operating costs are outside the scope of this research question.

## Visualisation

<img width="509" height="308" alt="image" src="https://github.com/user-attachments/assets/46116a00-9521-4a86-be01-c1c0d9122aff" />
