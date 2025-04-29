-- configuration
SELECT * FROM duckdb_settings();
SET memory_limit = '10GB';
SET threads TO 1;
SET enable_progress_bar = true;

-- dot commands
.databases
.maxrows 20
.tables

-- CLI display options
-- line mode displaying one column per line, useful when table have too many columns
.mode line

-- adds footer of human-readible numbers below raw value (eg. "3 million" for 3,000,000)
.large_number_rendering footer

-- extensions
INSTALL httpfs;

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

-- IMPORTING DATA
-- create table from JSON
CREATE TABLE FHIR_test AS
    FROM read_json_auto('~/working/datasets/FHIR_sandbox/fhir.json');

-- create table from local Parquet file
CREATE TABLE parquet_test AS
    FROM read_parquet('~/working/datasets/sandbox.parquet');

-- create table for Parquet file on S3
LOAD httpfs;
CREATE SECRET (
    TYPE s3,
    KEY_ID 'AKIAIOSFODNN7EXAMPLE',
    SECRET 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY',
    REGION 'us-east-1'
);
SELECT * FROM read_parquet('s3://my_bucket/my_file.parquet');

-- QUERYING
-- perform query on remote CSV via HTTP
LOAD httpsfs;
SELECT * FROM read_parquet('https://domain/path/to/file.parquet');

-- select random rows using reproducible seed
SELECT * FROM mtcars USING SAMPLE 10% REPEATABLE (31337);

-- EXPORTING DATA
-- export result of a query to CSV
COPY (FROM mtcars WHERE cyl == 4) TO '~/working/_scratch/mtcars_4cylinders.csv' (HEADER, DELIMITER ',');

-- export entire table to CSV
COPY mtcars TO '~/working/_scratch/mtcars.csv' (HEADER, DELIMITER ',');

-- export entire table to local Parquet
COPY mtcars TO '~/working/_scratch/mtcars.parquet' (FORMAT parquet);

-- export entire table to Excel, using column names as first row
COPY mtcars TO '~/working/_scratch/mtcars.xlsx' WITH (FORMAT xlsx, HEADER true, SHEET 'mtcars');