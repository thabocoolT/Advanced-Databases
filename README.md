# Driver Earnings, Platform Commission & Payout Optimization

**CMPG321 — Advanced Databases | Data Alchemists — Group 36**

This project uses PostgreSQL and SQL analysis to explore driver earnings on Uber and Bolt in South Africa. It examines how platform affiliation and commission, ride category, trip conditions, operating city and estimated fuel costs relate to recorded driver payouts.

> **DBMS:** PostgreSQL · **Database:** `cmpg321_data_alchemists` · **Scope:** Seven South African cities

## Project overview

Ride-hailing drivers' recorded payouts can vary with platform commission, ride category, trip distance and duration, surge pricing and operating location. This project organises the available data in a relational database and applies SQL queries to compare these measures.

The goal is to produce clear, traceable findings from the dataset. Results describe patterns in the available data and should not be treated as proof that any single factor causes a particular outcome.

### Cities covered

Johannesburg · Pretoria · Vanderbijlpark · Cape Town · Durban · Gqeberha · Potchefstroom

## Research questions

| ID | Focus | Analysis |
|---|---|---|
| **RQ1** | Platform differences | Completed-trip counts, average fares, platform commissions and driver payouts by platform affiliation. |
| **RQ2** | Commission and fare retention | How commission rates relate to the share of fare retained by drivers, using total-fare and commissionable-fare measures. |
| **RQ3** | Ride category | Average and median payouts, payout-to-fare measures, distance and duration across ride categories. |
| **RQ4** | Trip conditions | Payout patterns across peak/off-peak periods, surge-pricing bands and trip-distance groups. |
| **RQ5** | City and ride category | Comparisons of driver payouts and trip measures for city-and-category combinations. |
| **RQ6** | Estimated net hourly earnings | Estimated earnings after fuel using trip data, vehicle-consumption assumptions and monthly fuel-price assumptions. |

See the relevant SQL file for each question's filters, definitions and calculations.

## Database design

The database contains seven core tables:

| Table | Purpose |
|---|---|
| `sa_drivers` | Driver details, platform affiliation, commission rate, rating and operating city. |
| `sa_riders` | Rider and account information. |
| `vehicles` | Vehicle details linked to drivers. |
| `pricing_surge_zones` | Operating zones and fare-rate information. |
| `trip_headers` | Trip information, including driver, zone, status, timing and ride category. |
| `trip_fare_breakdown` | Fare components and trip measures such as commission, payout, distance, duration and surge multiplier. |
| `trip_reviews` | Trip review information. |

The ERD and schema scripts define the actual keys, constraints and relationships.

- [ERD image](03_ERD/ERD.png)
- [ERD PDF](03_ERD/ERD.pdf)
- [Database table definitions](01_Databases/02_create_tables.sql)

## Repository structure

```text
.
├── 01_Databases/       # Database setup, schema, backup, validation and indexes
├── 02_SQL_Queries/     # RQ1–RQ6 and additional SQL queries
├── 03_ERD/             # Entity-relationship diagram files
├── 04_Analysis/        # Research-question analysis materials
├── 05_Report/          # Project report
├── 06_Presentation/    # Presentation materials
├── 07_Dataset/         # Source CSV files
└── README.md           # Project overview and setup guide
```

## Getting started

### Requirements

- PostgreSQL
- pgAdmin 4 or another PostgreSQL client
- A local copy of this repository

### Restore the database

The project provides a prepared PostgreSQL backup.

1. Clone or download this repository.
2. In pgAdmin 4, connect to your PostgreSQL server.
3. Create an empty database named `cmpg321_data_alchemists`.
4. Right-click the database and choose **Restore**.
5. Select `01_Databases/cmpg321_data_alchemists_initial.backup`.
6. Run the restore and check that it completes successfully.
7. Open a query tool connected to the restored database.

Restore options can vary by PostgreSQL and pgAdmin version. If restoration fails, review the database scripts and resolve the issue before rebuilding the schema.

### Validate the database

Run [`01_Databases/04_validation.sql`](01_Databases/04_validation.sql) to check record counts for the core tables. The [index script](01_Databases/05_indexes.sql) contains the project's index definitions.

### Run a research query

1. Open the relevant `RQx.sql` file in `02_SQL_Queries/`.
2. Connect to the restored project database.
3. Execute the query in your PostgreSQL client.
4. Review its filters, joins, calculations and result columns.
5. Compare the output with the corresponding materials in `04_Analysis/` and `05_Report/`.

The file `01_Databases/03_load_data.sql` documents the use of the prepared backup. It does not itself import the CSV files. The CSV source data is retained in `07_Dataset/` for verification or rebuilding work when needed.

## Method and interpretation

The project uses relational joins, filters, grouped summaries and aggregate calculations. Depending on the query, it also uses common table expressions, ranking functions and calculated ratios.

When interpreting results:

- Check the query filters, including whether only completed trips are included.
- Distinguish an average of individual trip ratios from a ratio calculated over aggregated totals.
- Keep fares, tips, commissions, payouts and retention percentages separate.
- Label currency as South African rand (ZAR / R).
- Do not confuse percentages with percentage-point differences.
- Treat RQ6 fuel costs and earnings after fuel as estimates based on documented assumptions, not complete driver profit.
- Remember that the fuel estimate does not include every operating cost, such as maintenance, insurance, tyres or depreciation.
- Describe observed differences without claiming causation unless the research design supports it.

For RQ6, check the latest SQL assumptions and outputs before quoting earnings figures because fuel-price assumptions and calculations may be updated.

## Project files

- [Database scripts and backup](01_Databases/)
- [Research-question SQL queries](02_SQL_Queries/)
- [ERD files](03_ERD/)
- [Analysis materials](04_Analysis/)
- [Report](05_Report/README.md)
- [Presentation materials](06_Presentation/README.md)
- [Source CSV data](07_Dataset/)

## Contributing

To keep the database and analysis consistent:

1. Work on the relevant project component or research question.
2. Review the current schema and related SQL before editing.
3. Preserve existing table names, column names and relationships unless a schema change has been discussed and reviewed.
4. Save research-question queries in the appropriate file under `02_SQL_Queries/`.
5. Save supporting analysis in the relevant `04_Analysis/RQx/` folder.
6. Explain the method, key findings and assumptions in the analysis.
7. Test queries against the project database and check that results are reproducible.
8. Commit with a clear, descriptive message.
9. Use a separate branch and open a pull request for review.
10. Describe the change and include relevant validation notes in the pull request.

Avoid committing credentials, temporary database-client files or unrelated generated files. Changes to shared schema definitions or calculation assumptions should be reviewed before adoption.

## Project information

- **Project:** Driver Earnings, Platform Commission & Payout Optimization
- **Course:** CMPG321 Advanced Databases
- **Group:** Data Alchemists — Group 36
- **Database owner recorded in project files:** Thabo Prince Motau

For official submission requirements, consult the course project description and the project's report documentation.

---

*Academic database project exploring ride-hailing driver earnings in South Africa.*
