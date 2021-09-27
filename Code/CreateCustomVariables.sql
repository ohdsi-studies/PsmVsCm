
INSERT INTO @cohort_database_schema.@cohort_attribute_table (
   cohort_definition_id,
   subject_id,
   cohort_start_date,
   attribute_definition_id,
   value_as_number
)
SELECT cohort_definition_id,
       subject_id,
       cohort_start_date,
       @attribute_definition_id AS attribute_definition_id,
       CASE WHEN value_1 > 0 THEN 1 ELSE 0 END AS value_as_number
FROM (
  SELECT *
  FROM @cohort_database_schema.@cohort_table
  WHERE cohort_definition_id IN (@cohort_definition_ids)
  ) cohort1
LEFT JOIN (
  SELECT cohort_definition_id AS cohort_definition_id_1,
         subject_id AS subject_id_1,
         COUNT(*) AS value_1
  FROM (
    SELECT *
    FROM @cohort_database_schema.@cohort_table
    WHERE cohort_definition_id IN (@cohort_definition_ids)
  ) cohort2
  INNER JOIN @cdm_database_schema.condition_occurrence x2
    ON x2.person_id = cohort2.subject_id
  WHERE condition_source_concept_id IN (@source_concept_ids)
    AND condition_start_date <= cohort_start_date
    AND condition_start_date >= DATEADD(DAY, -@lookback_period, cohort_start_date)
  GROUP BY cohort_definition_id, subject_id
) x1
ON x1.subject_id_1 = cohort1.subject_id AND x1.cohort_definition_id_1 = cohort1.cohort_definition_id
; 

INSERT INTO @cohort_database_schema.@attribute_definition_table(
  attribute_definition_id,
  attribute_name
)
SELECT @attribute_definition_id AS attribute_definition_id,
       @attribute_name AS attribute_name
;
