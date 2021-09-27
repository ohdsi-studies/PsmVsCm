
IF OBJECT_ID('@cohort_database_schema.@cohortTable', 'U') IS NOT NULL
  DROP TABLE @cohort_database_schema.@cohortTable;


CREATE TABLE @cohort_database_schema.@cohortTable(
    cohort_definition_id BIGINT,
    cohort_start_date DATE,
    cohort_end_date DATE,
    subject_id BIGINT
);

    
