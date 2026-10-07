-- RQ2: Effect of platform commission percentage on driver-retained fare share
-- Base = (total_fare_zar - tip_zar), per Phase 1 §3.10
WITH completed_trips AS (
    SELECT
        d.platform_affiliation,
        d.platform_commission_pct,
        f.total_fare_zar,
        f.tip_zar,
        f.platform_commission_zar,
        f.driver_payout_zar,
        (f.total_fare_zar - f.tip_zar) AS commissionable_fare
    FROM trip_headers h
    INNER JOIN trip_fare_breakdown f ON f.trip_id = h.trip_id
    INNER JOIN sa_drivers d          ON d.driver_id = h.driver_id
    WHERE h.trip_status = 'COMPLETED'
      AND f.total_fare_zar > 0
      AND (f.total_fare_zar - f.tip_zar) > 0
),
commission_summary AS (
    SELECT
        platform_commission_pct,
        COUNT(*)                                          AS trip_count,
        ROUND(AVG(total_fare_zar), 2)                     AS avg_total_fare,
        ROUND(AVG(tip_zar), 2)                            AS avg_tip,
        ROUND(AVG(platform_commission_zar), 2)            AS avg_commission_zar,
        ROUND(AVG(driver_payout_zar), 2)                  AS avg_driver_payout,
        ROUND(AVG(driver_payout_zar / NULLIF(total_fare_zar, 0)) * 100, 2)
                                                          AS avg_retention_pct_of_total_fare,
        ROUND(AVG(driver_payout_zar / NULLIF(commissionable_fare, 0)) * 100, 2)
                                                          AS avg_retention_pct_of_commissionable_fare
    FROM completed_trips
    GROUP BY platform_commission_pct
)
SELECT
    platform_commission_pct,
    trip_count,
    avg_total_fare,
    avg_tip,
    avg_commission_zar,
    avg_driver_payout,
    avg_retention_pct_of_total_fare,
    avg_retention_pct_of_commissionable_fare,
    RANK() OVER (ORDER BY avg_retention_pct_of_commissionable_fare DESC) AS retention_rank,
    ROUND(avg_retention_pct_of_commissionable_fare
          - (SELECT AVG(avg_retention_pct_of_commissionable_fare)
             FROM commission_summary), 2) AS diff_vs_overall_avg
FROM commission_summary
ORDER BY platform_commission_pct;
