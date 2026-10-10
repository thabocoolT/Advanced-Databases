# RQ4 – Analysis

## Research Question

How do trip distance, duration, peak periods and surge pricing affect driver payouts?

## Purpose

This question investigates which operational trip conditions have the strongest influence on how much a driver actually earns. Four conditions are examined: distance travelled, trip duration, whether the trip occurred during a peak commute window (06:00–08:59 or 16:00–18:59), and the surge multiplier applied. The purpose is to identify which conditions drivers should optimise. Example: accepting longer trips versus chasing surge pricing in order to maximise both payout per trip and payout per hour.

## SQL Query

See `02_SQL_Queries/RQ4.sql`.

## Results
4A — Peak vs Off-Peak
<img width="1230" height="477" alt="4A RESULTS" src="https://github.com/user-attachments/assets/d358a816-d828-4a1d-a242-9bd815918c09" />

4B — Surge Pricing
<img width="1228" height="487" alt="4B RESULTS" src="https://github.com/user-attachments/assets/cb1459f0-5d0d-4ad8-a543-aff007b93fd7" />

4C — Trip Distance
<img width="1239" height="464" alt="4C RESULS" src="https://github.com/user-attachments/assets/9eb1bff1-b2c8-4771-8e7c-fd8a73ae7f98" />

4D — Trip Duration
<img width="1235" height="475" alt="4D RESULTS" src="https://github.com/user-attachments/assets/f37f1325-1d1a-49b2-8f2c-8d1c4efd9d9b" />

4E — Peak Period × Surge
<img width="1226" height="487" alt="4E RESULTS" src="https://github.com/user-attachments/assets/8c046953-dd76-41ea-ae52-26f7eb93b175" />

4F — Correlation
<img width="1264" height="457" alt="4F RESULTS" src="https://github.com/user-attachments/assets/29a92bc6-5502-4d13-be04-f55903142ddd" />

Overall result
Distance has the strongest positive correlation with driver payout (0.754), followed by duration (0.735) and surge pricing (0.527). Longer trips produce higher total payouts, but shorter trips produce higher payout per kilometre and per hour. Higher surge levels are associated with substantially higher payouts. Peak periods also have higher payouts, largely alongside higher surge multipliers. Tips show almost no correlation with driver payout (0.074).

## Analysis

The results show that trip distance, trip duration and surge pricing are all associated with driver payouts. Trip distance has the strongest positive correlation with driver payout, with a correlation of **0.754**, followed by trip duration at **0.735**. This indicates that longer trips generally result in higher total payouts. The distance analysis supports this, as the average payout increases from **R93.84 for trips shorter than 5 km** to **R540.90 for trips of 30 km or more**. However, the payout per kilometre decreases from **R30.94/km** for short trips to **R13.92/km** for very long trips. This means that although longer trips generate more money per trip, shorter trips provide better payout efficiency per kilometre.

Trip duration shows a similar pattern. Average payout increases from **R83.20 for trips shorter than 15 minutes** to **R473.37 for trips lasting 60 minutes or more**. However, average payout per hour decreases from **R451.44 per hour** for quick trips to **R285.68 per hour** for long trips. Therefore, longer trips provide higher total payouts, but shorter trips are more efficient when payout is considered on an hourly basis.

Surge pricing also has a noticeable relationship with driver payouts, with a correlation of **0.527**. Average payout increases from **R288.64 when there is no surge** to **R600.10 during high surge conditions**. The peak-period analysis also shows that peak trips have a higher average payout of **R482.20**, compared with **R324.33 during off-peak periods**. Peak trips also have a higher average surge multiplier of **1.71**, compared with **1.13 during off-peak periods**. When peak and off-peak trips are compared within the same surge bands, their payouts are relatively similar, suggesting that the higher payouts observed during peak periods are strongly associated with the higher levels of surge pricing.

The correlation between tips and driver payout is only **0.074**, indicating a very weak linear relationship. This suggests that tips contribute little to explaining differences in overall driver payouts in this dataset.

Overall, the analysis indicates that **distance and duration are the strongest factors associated with total driver payouts, while surge pricing provides an additional positive contribution**. However, higher total payouts do not necessarily mean higher earnings efficiency, since shorter trips have higher payout per kilometre and per hour. These results describe relationships in the dataset and should not be interpreted as proof that one factor directly causes changes in driver payouts.

## Conclusion

The analysis shows that **trip distance, duration and surge pricing are important factors associated with driver payouts**. Distance has the strongest relationship with payout, followed by trip duration and surge pricing. Longer trips generally provide higher total payouts, while shorter trips provide better payout efficiency per kilometre and per hour. Higher surge levels are also associated with substantially higher payouts, particularly during peak periods. Overall, the results suggest that drivers can earn more per trip from longer and high-surge trips, but the efficiency of earnings depends on both the time and distance required to complete each trip.

## Visualisation

4A — Peak vs Off-Peak
<img width="2000" height="1000" alt="4A_peak_vs_offpeak" src="https://github.com/user-attachments/assets/4cdb7dc7-94b8-451e-9308-269a9edff56a" />




4B — Surge Pricing

<img width="2200" height="1080" alt="4B_surge_pricing" src="https://github.com/user-attachments/assets/6d39ccaf-2522-4216-a1a4-ddf8e58eeaf8" />




4C — Trip Distance
<img width="2200" height="1040" alt="4C_trip_distance" src="https://github.com/user-attachments/assets/8530e8e2-455e-48dd-9831-ed6ca1cda866" />




4D — Trip Duration
<img width="2200" height="1040" alt="4D_trip_duration" src="https://github.com/user-attachments/assets/25441bff-56c5-4193-ac19-c769e7d00eb9" />



4E — Peak Period × Surge

<img width="2800" height="1120" alt="4E_peak_x_surge" src="https://github.com/user-attachments/assets/df7e2378-48dd-4332-8781-1dadd3ab1fc1" />




4F — Correlation
<img width="1800" height="919" alt="4F_correlation" src="https://github.com/user-attachments/assets/da30b57b-1c38-44b7-807c-a46cbb230202" />



