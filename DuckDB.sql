-- dot commands
.databases
.maxrows 20

-- statements below are using friendlySQL (no SELECT *)
-- create table from CSV, inferring types 
CREATE TABLE mtcars AS
    FROM '~/working/datasets/R_defaults/mtcars.csv';

-- create table from JSON
CREATE TABLE FHIR_test AS
    FROM read_json_auto('~/working/datasets/FHIR_sandbox/fhir.json')

-- export entire table to CSV
COPY mtcars TO '~/working/_scratch/mtcars.csv' (HEADER, DELIMITER ',');

-- export result of a query to CSV
COPY (FROM mtcars WHERE cyl == 4) TO '~/working/_scratch/mtcars_4cylinders.csv' (HEADER, DELIMITER ',');