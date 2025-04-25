-- dot commands
.databases
.maxrows 20
.tables

-- CLI display options
-- line mode displaying one column per line, useful when table have too many columns
.mode line

-- adds footer of human-readible numbers below raw value (eg. "3 million" for 3,000,000)
.large_number_rendering footer

-- attach external databases
ATTACH 'some_sqlite_database.db' as sqlite_database (type sqlite);
ATTACH 'postgres:dbname=postgresdatabase' AS postgres;
ATTACH 'mysql:user=root database=mysql_db' AS mysql;

-- show all attached databases and their types
SELECT database_name, path, type FROM duckdb_databases;

-- switch current database
USE postgres;

-- statements below are using friendlySQL (no SELECT *)
-- create table from CSV, inferring types and skipping errors
CREATE TABLE GAVIA AS
    FROM read_csv('~/working/datasets/GAVIA/GAVIA_main_data_table.csv', ignore_errors = true);

-- create table from JSON
CREATE TABLE FHIR_test AS
    FROM read_json_auto('~/working/datasets/FHIR_sandbox/fhir.json')

-- create table from Parquet file
CREATE TABLE parquet_test AS
    FROM read_parquet('~/working/datasets/sandbox.parquet')

-- export entire table to CSV
COPY mtcars TO '~/working/_scratch/mtcars.csv' (HEADER, DELIMITER ',');

-- export result of a query to CSV
COPY (FROM mtcars WHERE cyl == 4) TO '~/working/_scratch/mtcars_4cylinders.csv' (HEADER, DELIMITER ',');