
IF OBJECT_ID('@cohort_database_schema.@cohort_attribute_table', 'U') IS NOT NULL
  DROP TABLE @cohort_database_schema.@cohort_attribute_table;

IF OBJECT_ID('@cohort_database_schema.@attribute_definition_table', 'U') IS NOT NULL
  DROP TABLE @cohort_database_schema.@attribute_definition_table;

CREATE TABLE @cohort_database_schema.@cohort_attribute_table(
   cohort_definition_id INT,
   subject_id BIGINT,
   cohort_start_date DATE,
   attribute_definition_id INT,
   value_as_number INT
);

CREATE TABLE @cohort_database_schema.@attribute_definition_table(
  attribute_definition_id INT,
  attribute_name VARCHAR(255)
);
