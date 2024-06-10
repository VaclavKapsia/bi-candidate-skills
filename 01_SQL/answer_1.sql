WITH b2b_active_finishes AS (
  SELECT
    s.student_id,
    COUNT(1) AS cnt
  FROM students s
    LEFT JOIN courses c ON c.student_id = s.student_id
  WHERE s.is_active = True
    AND s.student_type = 'b2b'
    AND c.event_type = 'finished'
  GROUP BY
    s.student_id
  )
SELECT AVG(cnt) FROM b2b_active_finishes
