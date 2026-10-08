SELECT 
    d.platform_affiliation,
    COUNT(t.trip_id) AS total_completed_trips,
    ROUND(AVG(f.total_fare_zar)::numeric, 2) AS avg_total_fare_zar,
    ROUND(AVG(f.platform_commission_zar)::numeric, 2) AS avg_platform_commission_zar,
    ROUND(AVG(f.driver_payout_zar)::numeric, 2) AS avg_driver_payout_zar
FROM sa_drivers d
JOIN trip_headers t ON d.driver_id = t.driver_id
JOIN trip_fare_breakdown f ON t.trip_id = f.trip_id
WHERE UPPER(t.trip_status) = 'COMPLETED'
GROUP BY d.platform_affiliation
ORDER BY avg_total_fare_zar DESC;