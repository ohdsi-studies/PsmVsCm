

INSERT INTO @cohortDatabaseSchema.@cohortJointTable (
    cohort_definition_id,
    cohort_start_date,
    cohort_end_date,
    subject_id
    )
SELECT cohort_definition_id, cohort_start_date, cohort_end_date, subject_id
FROM @cohortDatabaseSchema.@cohortTable;


