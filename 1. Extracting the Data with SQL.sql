SELECT ROW_NUMBER() OVER (ORDER BY student_id, E.track_id) AS student_track_id, student_id, track_name, date_enrolled,
	CASE 
        WHEN date_completed IS NULL THEN 0
        ELSE 1
    END AS track_completed, 
	DATEDIFF(day,date_enrolled, date_completed) as days_for_completion,
	
	CASE 
        WHEN DATEDIFF(day,date_enrolled, date_completed) = 0 THEN 'Same day'
        WHEN DATEDIFF(day,date_enrolled, date_completed) BETWEEN 1 AND 7 THEN '1 to 7 days'
        WHEN DATEDIFF(day,date_enrolled, date_completed) BETWEEN 8 AND 30 THEN '8 to 30 days'
        WHEN DATEDIFF(day,date_enrolled, date_completed) BETWEEN 31 AND 60 THEN '31 to 60 days'
        WHEN DATEDIFF(day,date_enrolled, date_completed) BETWEEN 61 AND 90 THEN '61 to 90 days'
        WHEN DATEDIFF(day,date_enrolled, date_completed) BETWEEN 91 AND 365 THEN '91 to 365 days'
        WHEN DATEDIFF(day,date_enrolled, date_completed) > 365 THEN '366+ days'
        ELSE 'Not Completed'
    END AS completion_bucket
  FROM [sql_and_tableau].[dbo].[career_track_student_enrollments] E
  JOIN [sql_and_tableau].[dbo].[career_track_info] I ON E.[track_id] = I.[track_id]
