# RQ4 – Analysis

## Research Question

How do trip distance, duration, peak periods and surge pricing affect driver payouts?

## Purpose

This question investigates which operational trip conditions have the strongest influence on how much a driver actually earns. Four conditions are examined: distance travelled, trip duration, whether the trip occurred during a peak commute window (06:00–08:59 or 16:00–18:59), and the surge multiplier applied. The purpose is to identify which conditions drivers should optimise. Example: accepting longer trips versus chasing surge pricing in order to maximise both payout per trip and payout per hour.

## SQL Query

See `02_SQL_Queries/RQ4.sql`.

## Results

[Add the important results after running the SQL query.]

## Analysis

[Explain what the results mean and identify important patterns.]

## Conclusion

Trip distance is the strongest driver of absolute payout, but trip duration determines hourly earnings. Surge pricing and peak periods raise the total fare but do not proportionally raise the hourly rate, because they coincide with shorter or slower trips. Drivers maximising income should prioritise short, high-frequency trips during peak windows with moderate surge, rather than chasing long trips or maximum surge multipliers. Tips contribute only marginally and cannot be planned around.

## Visualisation

[Add a suitable chart or table if required.]
