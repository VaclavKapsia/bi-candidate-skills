WITH
  distinct_courses AS (
    SELECT DISTINCT -- Data is dirty / see query {SELECT * FROM courses WHERE student_id = 7}
      student_id,
      event_type,
      course_id,
      event_timestamp
    FROM courses
    ),
  intervals AS (
    SELECT
      student_id,
      event_type,
      course_id,
      event_timestamp,
      LEAD(event_type) OVER (PARTITION BY student_id, course_id ORDER BY event_timestamp ASC) AS next_event_type,
      LEAD(event_timestamp) OVER (PARTITION BY student_id, course_id ORDER BY event_timestamp ASC) AS next_event_timestamp
    FROM distinct_courses
    )
SELECT
  student_id,
  SUM(DATE_PART('epoch', next_event_timestamp - event_timestamp)) AS total_seconds
FROM intervals
WHERE event_type = 'start'
  AND next_event_type = 'end'
GROUP BY
  student_id

