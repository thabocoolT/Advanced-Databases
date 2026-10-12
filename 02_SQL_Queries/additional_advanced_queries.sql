
-- ============================================================
-- CMPG321 - Advanced Database Queries
-- Group 36: Data Alchemists
-- Database: cmpg321_data_alchemists
-- DBMS: PostgreSQL
--
-- Purpose:
-- Demonstrate advanced SQL techniques using the existing
-- driver earnings and ride-hailing dataset.
--
-- Techniques:
-- 1. CTE and window functions
-- 2. Ranking and percentage calculations
-- 3. Monthly trends using LAG()
-- 4. Subquery comparison against the overall average
-- ============================================================


-- ============================================================
-- QUERY 1: Platform performance using a CTE and window functions
-- ============================================================
-- Compares completed-trip counts, average fares, and average
-- driver payouts by platform.
-- The window function calculates each platform's share of
-- all completed trips in the result.

WITH platform_summary AS (
    SELECT
        d.platform_affiliation,
        COUNT(t.trip_id) AS completed_trips,
        AVG(f.total_fare_zar) AS avg_total_fare,
        AVG(f.driver_payout_zar) AS avg_driver_payout
    FROM sa_drivers AS d
    INNER JOIN trip_headers AS t
        ON t.driver_id = d.driver_id
    INNER JOIN trip_fare_breakdown AS f
        ON f.trip_id = t.trip_id
    WHERE UPPER(t.trip_status) = 'COMPLETED'
    GROUP BY d.platform_affiliation
)
SELECT
    platform_affiliation,
    completed_trips,
    ROUND(avg_total_fare::numeric, 2)
        AS avg_total_fare_zar,
    ROUND(avg_driver_payout::numeric, 2)
        AS avg_driver_payout_zar,
    ROUND(
        100.0 * completed_trips
        / NULLIF(SUM(completed_trips) OVER (), 0),
        2
    ) AS percentage_of_completed_trips,
    RANK() OVER (
        ORDER BY avg_driver_payout DESC
    ) AS payout_rank
FROM platform_summary
ORDER BY payout_rank;


-- ============================================================
-- QUERY 2: Rank cities by average driver payout
-- ============================================================
-- Uses a CTE and RANK() to identify cities with higher
-- average payouts on completed trips.

WITH city_summary AS (
    SELECT
        d.operating_city,
        COUNT(t.trip_id) AS completed_trips,
        AVG(f.driver_payout_zar) AS avg_driver_payout
    FROM sa_drivers AS d
    INNER JOIN trip_headers AS t
        ON t.driver_id = d.driver_id
    INNER JOIN trip_fare_breakdown AS f
        ON f.trip_id = t.trip_id
    WHERE UPPER(t.trip_status) = 'COMPLETED'
    GROUP BY d.operating_city
)
SELECT
    operating_city,
    completed_trips,
    ROUND(avg_driver_payout::numeric, 2)
        AS avg_driver_payout_zar,
    RANK() OVER (
        ORDER BY avg_driver_payout DESC
    ) AS city_payout_rank
FROM city_summary
ORDER BY city_payout_rank, operating_city;


-- ============================================================
-- QUERY 3: Monthly payout trends using LAG()
-- ============================================================
-- Compares the average driver payout for each month with
-- the previous month and calculates the percentage change.

WITH monthly_summary AS (
    SELECT
        DATE_TRUNC('month', t.request_timestamp)::date
            AS trip_month,
        COUNT(t.trip_id) AS completed_trips,
        AVG(f.driver_payout_zar) AS avg_driver_payout
    FROM trip_headers AS t
    INNER JOIN trip_fare_breakdown AS f
        ON f.trip_id = t.trip_id
    WHERE UPPER(t.trip_status) = 'COMPLETED'
    GROUP BY DATE_TRUNC('month', t.request_timestamp)::date
),
monthly_comparison AS (
    SELECT
        trip_month,
        completed_trips,
        avg_driver_payout,
        LAG(avg_driver_payout) OVER (
            ORDER BY trip_month
        ) AS previous_month_avg_payout
    FROM monthly_summary
)
SELECT
    trip_month,
    completed_trips,
    ROUND(avg_driver_payout::numeric, 2)
        AS avg_driver_payout_zar,
    ROUND(previous_month_avg_payout::numeric, 2)
        AS previous_month_avg_payout_zar,
    ROUND(
        (avg_driver_payout - previous_month_avg_payout)::numeric,
        2
    ) AS payout_change_zar,
    ROUND(
        (
            (avg_driver_payout - previous_month_avg_payout)
            / NULLIF(previous_month_avg_payout, 0) * 100
        )::numeric,
        2
    ) AS payout_change_percentage
FROM monthly_comparison
ORDER BY trip_month;


-- ============================================================
-- QUERY 4: Drivers whose average payout exceeds the overall
-- average completed-trip payout
-- ============================================================
-- Uses a subquery to calculate the overall average payout.
-- Only drivers with at least 30 completed trips are included
-- to avoid ranking drivers based on very small samples.

WITH driver_summary AS (
    SELECT
        d.driver_id,
        d.operating_city,
        d.platform_affiliation,
        COUNT(t.trip_id) AS completed_trips,
        AVG(f.driver_payout_zar) AS avg_driver_payout
    FROM sa_drivers AS d
    INNER JOIN trip_headers AS t
        ON t.driver_id = d.driver_id
    INNER JOIN trip_fare_breakdown AS f
        ON f.trip_id = t.trip_id
    WHERE UPPER(t.trip_status) = 'COMPLETED'
    GROUP BY
        d.driver_id,
        d.operating_city,
        d.platform_affiliation
)
SELECT
    ds.driver_id,
    ds.operating_city,
    ds.platform_affiliation,
    ds.completed_trips,
    ROUND(ds.avg_driver_payout::numeric, 2)
        AS avg_driver_payout_zar
FROM driver_summary AS ds
WHERE ds.completed_trips >= 30
  AND ds.avg_driver_payout > (
      SELECT AVG(f2.driver_payout_zar)
      FROM trip_headers AS t2
      INNER JOIN trip_fare_breakdown AS f2
          ON f2.trip_id = t2.trip_id
      WHERE UPPER(t2.trip_status) = 'COMPLETED'
  )
ORDER BY ds.avg_driver_payout DESC;