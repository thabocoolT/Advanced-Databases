-- RQ6: Estimated Net Earnings After Fuel Costs

-- Query 1: Completed trip validation
SELECT
    trip_status,
    COUNT(*) AS trip_count
FROM trip_headers
GROUP BY trip_status
ORDER BY trip_status;
===========================================================================


-- Query 2: Vehicle validation
SELECT
    make,
    model,
    COUNT(*) AS vehicle_count
FROM vehicles
GROUP BY make, model
ORDER BY make, model;
===========================================================================
-- Query 3: Overall RQ6 calculation
WITH vehicle_fuel_rates AS (
    SELECT 'BMW' AS make, '3 Series' AS model, 6.5::NUMERIC AS litres_per_100km
    UNION ALL
    SELECT 'Hyundai', 'Grand i10', 5.5
    UNION ALL
    SELECT 'Kia', 'Picanto', 5.1
    UNION ALL
    SELECT 'Nissan', 'Almera', 6.3
    UNION ALL
    SELECT 'Renault', 'Triber', 5.5
    UNION ALL
    SELECT 'Suzuki', 'Ertiga', 5.5
    UNION ALL
    SELECT 'Toyota', 'Avanza', 7.6
    UNION ALL
    SELECT 'Toyota', 'Corolla Quest', 6.3
    UNION ALL
    SELECT 'Volkswagen', 'Polo Vivo', 5.9
),

completed_trips AS (
    SELECT
        th.trip_id,
        th.driver_id,
        th.request_timestamp,
        sd.operating_city,
        v.make,
        v.model,
        v.year,
        tf.distance_km,
        tf.duration_minutes,
        tf.driver_payout_zar,
        vfr.litres_per_100km,

        CASE
            -- 2025 fuel prices: Inland 95
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 3 THEN 22.34
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 4 THEN 21.62
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 5 THEN 21.40
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 6 THEN 21.35
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 7 THEN 21.87
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 8 THEN 21.59
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 9 THEN 21.55
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 10 THEN 21.63
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 11 THEN 21.63
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 12 THEN 21.63

            -- 2025 fuel prices: Coastal 95
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 3 THEN 21.55
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 4 THEN 20.79
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 5 THEN 20.57
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 6 THEN 20.52
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 7 THEN 21.04
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 8 THEN 20.76
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 9 THEN 20.72
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 10 THEN 20.80
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 11 THEN 20.80
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 12 THEN 20.80

            -- 2026: January
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 1
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha') THEN 20.75
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 1
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha') THEN 19.92

            -- 2026: February
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 2
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha') THEN 20.10
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 2
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha') THEN 19.27

            -- 2026: March
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 3
                 AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha') THEN 20.30
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
                 AND EXTRACT(MONTH FROM th.request_timestamp) = 3
                 AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha') THEN 19.47
        END AS fuel_price_per_litre

    FROM trip_headers th
    INNER JOIN sa_drivers sd
        ON th.driver_id = sd.driver_id
    INNER JOIN vehicles v
        ON th.driver_id = v.driver_id
    INNER JOIN trip_fare_breakdown tf
        ON th.trip_id = tf.trip_id
    INNER JOIN vehicle_fuel_rates vfr
        ON v.make = vfr.make
       AND v.model = vfr.model

    WHERE th.trip_status = 'COMPLETED'
      AND tf.duration_minutes > 0
)

SELECT
    COUNT(*) AS completed_trips,
    ROUND(AVG(driver_payout_zar), 2) AS avg_driver_payout,
    ROUND(AVG(
        distance_km * litres_per_100km / 100
        * fuel_price_per_litre
    ), 2) AS avg_estimated_fuel_cost,
    ROUND(AVG(
        driver_payout_zar -
        (distance_km * litres_per_100km / 100 * fuel_price_per_litre)
    ), 2) AS avg_estimated_net_earnings,
    ROUND(
        SUM(
            driver_payout_zar -
            (distance_km * litres_per_100km / 100 * fuel_price_per_litre)
        )
        /
        SUM(duration_minutes / 60.0),
        2
    ) AS estimated_net_earnings_per_hour,
    30.23 AS minimum_wage_benchmark,
    CASE
        WHEN
            SUM(
                driver_payout_zar -
                (distance_km * litres_per_100km / 100 * fuel_price_per_litre)
            )
            /
            SUM(duration_minutes / 60.0) >= 30.23
        THEN 'MEETS OR EXCEEDS BENCHMARK'
        ELSE 'BELOW BENCHMARK'
    END AS benchmark_result
FROM completed_trips;
===========================================================================
-- RQ6 Query 4: Vehicle Model Comparison

WITH vehicle_fuel_rates AS (
    SELECT 'BMW' AS make, '3 Series' AS model, 6.5::NUMERIC AS litres_per_100km
    UNION ALL SELECT 'Hyundai', 'Grand i10', 5.5
    UNION ALL SELECT 'Kia', 'Picanto', 5.1
    UNION ALL SELECT 'Nissan', 'Almera', 6.3
    UNION ALL SELECT 'Renault', 'Triber', 5.5
    UNION ALL SELECT 'Suzuki', 'Ertiga', 5.5
    UNION ALL SELECT 'Toyota', 'Avanza', 7.6
    UNION ALL SELECT 'Toyota', 'Corolla Quest', 6.3
    UNION ALL SELECT 'Volkswagen', 'Polo Vivo', 5.9
),

completed_trips AS (
    SELECT
        th.trip_id,
        th.driver_id,
        th.request_timestamp,
        sd.operating_city,
        v.make,
        v.model,
        v.year,
        tf.distance_km,
        tf.duration_minutes,
        tf.driver_payout_zar,
        vfr.litres_per_100km,

        CASE
            -- 2025 Inland
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 3 THEN 22.34

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 4 THEN 21.62

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 5 THEN 21.40

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 6 THEN 21.35

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 7 THEN 21.87

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 8 THEN 21.59

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 9 THEN 21.55

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 10 THEN 21.63

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 11 THEN 21.63

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 12 THEN 21.63

            -- 2025 Coastal
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 3 THEN 21.55

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 4 THEN 20.79

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 5 THEN 20.57

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 6 THEN 20.52

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 7 THEN 21.04

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 8 THEN 20.76

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 9 THEN 20.72

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 10 THEN 20.80

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 11 THEN 20.80

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 12 THEN 20.80

            -- 2026 January
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 1
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha') THEN 20.75

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 1
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha') THEN 19.92

            -- 2026 February
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 2
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha') THEN 20.10

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 2
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha') THEN 19.27

            -- 2026 March
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 3
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha') THEN 20.30

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 3
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha') THEN 19.47
        END AS fuel_price_per_litre

    FROM trip_headers th
    INNER JOIN sa_drivers sd
        ON th.driver_id = sd.driver_id
    INNER JOIN vehicles v
        ON th.driver_id = v.driver_id
    INNER JOIN trip_fare_breakdown tf
        ON th.trip_id = tf.trip_id
    INNER JOIN vehicle_fuel_rates vfr
        ON v.make = vfr.make
       AND v.model = vfr.model

    WHERE th.trip_status = 'COMPLETED'
      AND tf.duration_minutes > 0
)

SELECT
    make,
    model,
    COUNT(*) AS completed_trips,

    ROUND(AVG(driver_payout_zar), 2)
        AS avg_driver_payout,

    ROUND(AVG(
        distance_km
        * litres_per_100km
        / 100
        * fuel_price_per_litre
    ), 2) AS avg_fuel_cost,

    ROUND(AVG(
        driver_payout_zar
        -
        (
            distance_km
            * litres_per_100km
            / 100
            * fuel_price_per_litre
        )
    ), 2) AS avg_net_earnings,

    ROUND(
        SUM(
            driver_payout_zar
            -
            (
                distance_km
                * litres_per_100km
                / 100
                * fuel_price_per_litre
            )
        )
        /
        SUM(duration_minutes / 60.0),
        2
    ) AS net_earnings_per_hour

FROM completed_trips

GROUP BY
    make,
    model

ORDER BY
    net_earnings_per_hour DESC;
===========================================================================
-- Query 5: City comparison
WITH vehicle_fuel_rates AS (
    SELECT
        make,
        model,
        CASE
            WHEN make = 'BMW' AND model = '3 Series' THEN 6.5
            WHEN make = 'Hyundai' AND model = 'Grand i10' THEN 5.5
            WHEN make = 'Kia' AND model = 'Picanto' THEN 5.1
            WHEN make = 'Nissan' AND model = 'Almera' THEN 6.3
            WHEN make = 'Renault' AND model = 'Triber' THEN 5.5
            WHEN make = 'Suzuki' AND model = 'Ertiga' THEN 5.5
            WHEN make = 'Toyota' AND model = 'Avanza' THEN 7.6
            WHEN make = 'Toyota' AND model = 'Corolla Quest' THEN 6.3
            WHEN make = 'Volkswagen' AND model = 'Polo Vivo' THEN 5.9
        END AS litres_per_100km
    FROM vehicles
    GROUP BY make, model
),

completed_trips AS (
    SELECT
        th.trip_id,
        d.operating_city,
        tf.distance_km,
        tf.duration_minutes,
        tf.driver_payout_zar,
        vfr.litres_per_100km,

        CASE
            WHEN d.operating_city IN (
                'Johannesburg',
                'Pretoria',
                'Vanderbijlpark',
                'Potchefstroom'
            )
            THEN 22.00
            ELSE 21.50
        END AS fuel_price_per_litre

    FROM trip_headers th

    JOIN sa_drivers d
        ON th.driver_id = d.driver_id

    JOIN trip_fare_breakdown tf
        ON th.trip_id = tf.trip_id

    JOIN vehicles v
        ON d.driver_id = v.driver_id

    JOIN vehicle_fuel_rates vfr
        ON v.make = vfr.make
        AND v.model = vfr.model

    WHERE th.trip_status = 'COMPLETED'
)

SELECT
    operating_city,
    COUNT(*) AS completed_trips,

    ROUND(AVG(driver_payout_zar), 2) AS avg_driver_payout,

    ROUND(
        AVG(
            distance_km *
            litres_per_100km / 100 *
            fuel_price_per_litre
        ),
        2
    ) AS avg_fuel_cost,

    ROUND(
        AVG(
            driver_payout_zar -
            (
                distance_km *
                litres_per_100km / 100 *
                fuel_price_per_litre
            )
        ),
        2
    ) AS avg_net_earnings,

    ROUND(
        SUM(
            driver_payout_zar -
            (
                distance_km *
                litres_per_100km / 100 *
                fuel_price_per_litre
            )
        )
        /
        SUM(duration_minutes / 60.0),
        2
    ) AS net_earnings_per_hour

FROM completed_trips

GROUP BY operating_city

ORDER BY net_earnings_per_hour DESC;