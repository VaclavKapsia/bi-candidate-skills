WITH b2c_starts AS (
  SELECT
    s.student_id,
    COUNT(1) AS cnt
  FROM students s
    LEFT JOIN courses c ON c.student_id = s.student_id
  WHERE s.student_type = 'b2c'
    AND c.event_type = 'start'
  GROUP BY
    s.student_id
  )
SELECT AVG(cnt) FROM b2c_starts
