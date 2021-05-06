USE 
		PELL_Members
SELECT 
		Attendance.MemberID
		,CASE Attendance.SiteID
			WHEN 'ALM' THEN 'Almere'
			WHEN 'TIL' THEN 'Tilburg'
		END AS Club
		,Count(Attendance.MemberID) AS Visits
FROM 
		Attendance
		INNER JOIN Members 
			ON Attendance.MemberID = Members.ID
WHERE 
		(
			Attendance.AtDate BETWEEN '2019-01-01' AND '2020-01-01'
		)
		AND 
		(
			Attendance.SiteID = 'TIL'
		)
GROUP BY 
		Attendance.SiteID
		,Attendance.MemberID
ORDER BY
		Attendance.SiteID
			,Attendance.MemberID
;