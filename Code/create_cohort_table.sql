
USE @cdmDatabaseSchema;


INSERT INTO @cohortDatabaseSchema.@cohortTable (
    cohort_definition_id,
    cohort_start_date,
    cohort_end_date,
    subject_id
    )
SELECT 1, cohort_start_date, cohort_end_date, subject_id
FROM  @ohdsiSchema.cohort
WHERE cohort_definition_id = @cohort_id_1;


INSERT INTO @cohortDatabaseSchema.@cohortTable (
    cohort_definition_id,
    cohort_start_date,
    cohort_end_date,
    subject_id
    )
SELECT 2, cohort_start_date, cohort_end_date, subject_id
FROM  @ohdsiSchema.cohort
WHERE cohort_definition_id = @cohort_id_2;


