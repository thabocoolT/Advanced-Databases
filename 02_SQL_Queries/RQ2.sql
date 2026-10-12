
-- RQ2: Effect of platform commission on driver fare retention
-- Tips are excluded from the commissionable fare.
-- Retention on commissionable fare excludes tips from both numerator
-- and denominator. Total-fare retention includes the full payout and fare.

WITH completed_trips AS (
    SELECT
        d.platform_affiliation,
        d.platform_commission_pct,
        f.total_fare_zar,
        f.tip_zar,
        f.platform_commission_zar,
        f.driver_payout_zar,
        f.total_fare_zar - f.tip_zar AS commissionable_fare,
        f.driver_payout_zar - f.tip_zar AS payout_excluding_tip
    FROM trip_headers AS h
    INNER JOIN trip_fare_breakdown AS f
        ON f.trip_id = h.trip_id
    INNER JOIN sa_drivers AS d
        ON d.driver_id = h.driver_id
    WHERE h.trip_status = 'COMPLETED'
      AND f.total_fare_zar > 0
      AND f.tip_zar >= 0
      AND f.driver_payout_zar >= f.tip_zar
      AND f.total_fare_zar - f.tip_zar > 0
),
commission_summary AS (
    SELECT
        platform_affiliation,
        platform_commission_pct,
        COUNT(*) AS trip_count,
        ROUND(AVG(total_fare_zar), 2) AS avg_total_fare_zar,
        ROUND(AVG(tip_zar), 2) AS avg_tip_zar,
        ROUND(AVG(platform_commission_zar), 2) AS avg_commission_zar,
        ROUND(AVG(driver_payout_zar), 2) AS avg_driver_payout_zar,
        ROUND(
            AVG(
                driver_payout_zar / NULLIF(total_fare_zar, 0)
            ) * 100, 2
        ) AS avg_retention_pct_of_total_fare,
        ROUND(
            AVG(
                payout_excluding_tip
                / NULLIF(commissionable_fare, 0)
            ) * 100, 2
        ) AS avg_retention_pct_of_commissionable_fare
    FROM completed_trips
    GROUP BY platform_affiliation, platform_commission_pct
)
SELECT
    platform_affiliation,
    platform_commission_pct,
    trip_count,
    avg_total_fare_zar,
    avg_tip_zar,
    avg_commission_zar,
    avg_driver_payout_zar,
    avg_retention_pct_of_total_fare,
    avg_retention_pct_of_commissionable_fare,
    RANK() OVER (
        ORDER BY avg_retention_pct_of_commissionable_fare DESC
    ) AS retention_rank,
    ROUND(
        avg_retention_pct_of_commissionable_fare
        - AVG(avg_retention_pct_of_commissionable_fare) OVER (),
        2
    ) AS difference_from_platform_average_pp
FROM commission_summary
ORDER BY platform_commission_pct;