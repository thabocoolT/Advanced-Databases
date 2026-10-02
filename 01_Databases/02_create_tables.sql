-- =========================================================
-- CMPG321 DATA ALCHEMISTS - DATABASE TABLES
-- DBMS: PostgreSQL
-- =========================================================


-- =========================================================
-- 1. SA_DRIVERS
-- =========================================================

CREATE TABLE sa_drivers (
    driver_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    operating_city VARCHAR(100) NOT NULL,
    platform_affiliation VARCHAR(30) NOT NULL,
    platform_commission_pct NUMERIC(5,4) NOT NULL,
    driver_rating NUMERIC(3,2),
    total_lifetime_trips INTEGER NOT NULL,
    onboarding_date DATE NOT NULL,

    CONSTRAINT chk_driver_platform
        CHECK (
            platform_affiliation IN
            ('Uber', 'Bolt', 'Dual-Platform (Both)')
        ),

    CONSTRAINT chk_commission_pct
        CHECK (
            platform_commission_pct >= 0
            AND platform_commission_pct <= 1
        ),

    CONSTRAINT chk_driver_rating
        CHECK (
            driver_rating >= 0
            AND driver_rating <= 5
        ),

    CONSTRAINT chk_lifetime_trips
        CHECK (
            total_lifetime_trips >= 0
        )
);


-- =========================================================
-- 2. SA_RIDERS
-- =========================================================

CREATE TABLE sa_riders (
    rider_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    mobile_number VARCHAR(30),
    home_city VARCHAR(100),
    province VARCHAR(100),
    preferred_payment VARCHAR(30),
    account_created_date DATE
);


-- =========================================================
-- 3. VEHICLES
-- =========================================================

CREATE TABLE vehicles (
    vehicle_id VARCHAR(20) PRIMARY KEY,
    driver_id VARCHAR(20) NOT NULL,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    year INTEGER NOT NULL,
    license_plate VARCHAR(30) UNIQUE,
    category_type VARCHAR(50),

    CONSTRAINT fk_vehicle_driver
        FOREIGN KEY (driver_id)
        REFERENCES sa_drivers(driver_id),

    CONSTRAINT chk_vehicle_year
        CHECK (year >= 1900)
);


-- =========================================================
-- 4. PRICING_SURGE_ZONES
-- =========================================================

CREATE TABLE pricing_surge_zones (
    zone_id VARCHAR(50) PRIMARY KEY,
    zone_name VARCHAR(150) NOT NULL,
    city VARCHAR(100) NOT NULL,
    base_fare_zar NUMERIC(10,2) NOT NULL,
    per_km_rate_zar NUMERIC(10,2) NOT NULL,
    per_min_rate_zar NUMERIC(10,2) NOT NULL,

    CONSTRAINT chk_zone_base_fare
        CHECK (base_fare_zar >= 0),

    CONSTRAINT chk_zone_km_rate
        CHECK (per_km_rate_zar >= 0),

    CONSTRAINT chk_zone_min_rate
        CHECK (per_min_rate_zar >= 0)
);


-- =========================================================
-- 5. TRIP_HEADERS
-- =========================================================

CREATE TABLE trip_headers (
    trip_id VARCHAR(30) PRIMARY KEY,
    rider_id VARCHAR(20) NOT NULL,
    driver_id VARCHAR(20) NOT NULL,
    zone_id VARCHAR(50) NOT NULL,
    ride_category VARCHAR(50) NOT NULL,
    request_timestamp TIMESTAMP NOT NULL,
    trip_status VARCHAR(30) NOT NULL,
    cancellation_reason VARCHAR(50),

    CONSTRAINT fk_trip_rider
        FOREIGN KEY (rider_id)
        REFERENCES sa_riders(rider_id),

    CONSTRAINT fk_trip_driver
        FOREIGN KEY (driver_id)
        REFERENCES sa_drivers(driver_id),

    CONSTRAINT fk_trip_zone
        FOREIGN KEY (zone_id)
        REFERENCES pricing_surge_zones(zone_id),

    CONSTRAINT chk_trip_category
        CHECK (
            ride_category IN (
                'Budget (Uber Go/Bolt Go)',
                'Standard (UberX/Bolt)',
                'Comfort (Uber Comfort)',
                'Large Capacity (UberXL/Bolt XL)'
            )
        ),

    CONSTRAINT chk_trip_status
        CHECK (
            trip_status IN (
                'COMPLETED',
                'CANCELLED_BY_RIDER',
                'CANCELLED_BY_DRIVER'
            )
        )
);


-- =========================================================
-- 6. TRIP_FARE_BREAKDOWN
-- =========================================================

CREATE TABLE trip_fare_breakdown (
    trip_id VARCHAR(30) PRIMARY KEY,
    distance_km NUMERIC(10,2) NOT NULL,
    duration_minutes INTEGER NOT NULL,
    surge_multiplier NUMERIC(4,2) NOT NULL,
    base_fare_zar NUMERIC(10,2) NOT NULL,
    tolls_zar NUMERIC(10,2) NOT NULL,
    tip_zar NUMERIC(10,2) NOT NULL,
    total_fare_zar NUMERIC(10,2) NOT NULL,
    platform_commission_zar NUMERIC(10,2) NOT NULL,
    driver_payout_zar NUMERIC(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,

    CONSTRAINT fk_fare_trip
        FOREIGN KEY (trip_id)
        REFERENCES trip_headers(trip_id),

    CONSTRAINT chk_distance
        CHECK (distance_km >= 0),

    CONSTRAINT chk_duration
        CHECK (duration_minutes >= 0),

    CONSTRAINT chk_surge
        CHECK (surge_multiplier >= 0),

    CONSTRAINT chk_base_fare
        CHECK (base_fare_zar >= 0),

    CONSTRAINT chk_tolls
        CHECK (tolls_zar >= 0),

    CONSTRAINT chk_tip
        CHECK (tip_zar >= 0),

    CONSTRAINT chk_total_fare
        CHECK (total_fare_zar >= 0),

    CONSTRAINT chk_commission
        CHECK (platform_commission_zar >= 0),

    CONSTRAINT chk_driver_payout
        CHECK (driver_payout_zar >= 0),

    CONSTRAINT chk_payment_method
        CHECK (
            payment_method IN (
                'CASH',
                'CREDIT_CARD',
                'DEBIT_CARD',
                'EFT_OZOW',
                'IN_APP_WALLET'
            )
        )
);


-- =========================================================
-- 7. TRIP_REVIEWS
-- =========================================================

CREATE TABLE trip_reviews (
    review_id VARCHAR(30) PRIMARY KEY,
    trip_id VARCHAR(30) NOT NULL,
    rider_rating_of_driver INTEGER,
    driver_rating_of_rider INTEGER,
    feedback_comment TEXT,

    CONSTRAINT fk_review_trip
        FOREIGN KEY (trip_id)
        REFERENCES trip_headers(trip_id),

    CONSTRAINT chk_rider_rating
        CHECK (
            rider_rating_of_driver BETWEEN 1 AND 5
        ),

    CONSTRAINT chk_driver_rating
        CHECK (
            driver_rating_of_rider BETWEEN 1 AND 5
        )
);