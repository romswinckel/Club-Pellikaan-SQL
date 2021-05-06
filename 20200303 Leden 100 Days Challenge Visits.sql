USE
		DWH_Main
SELECT DISTINCT
		dbo.plus2_Members.SiteID
		,dbo.plus2_Members.ID
		,dbo.plus2_Members.FirstNames
		,dbo.plus2_Members.LastName
		,dbo.plus2_Members.BirthDate
		,DATEDIFF(YEAR, dbo.plus2_Members.BirthDate, GETDATE()) as Age
		,dbo.plus2_Members.HomeStreet
		,dbo.plus2_Members.HomePostCode
		,dbo.plus2_Members.HomeTown
		,dbo.plus2_Members.HomeEmail
		,dbo.plus2_Members.HomeTelephone
		,dbo.plus2_Members.MobileTelephone
		,dbo.plus2_Members.StatusID
		,COUNT(dbo.plus2_Attendance.AtDate) Visits
		,MaxDateTable.MaxDate
FROM
		dbo.plus2_Members
		LEFT JOIN dbo.plus2_Attendance 
			ON dbo.plus2_Attendance.MemberId = dbo.plus2_Members.ID 
			AND dbo.plus2_Attendance.DatabaseId = dbo.plus2_Members.DatabaseId
		LEFT JOIN 
			(
				SELECT 
					dbo.plus2_Members.ID
					,MAX(dbo.plus2_Attendance.AtDate) AS MaxDate
				FROM
					dbo.plus2_Members
						LEFT JOIN dbo.plus2_Attendance 
							ON dbo.plus2_Members.ID = dbo.plus2_Attendance.MemberId 
							AND dbo.plus2_Attendance.DatabaseId = dbo.plus2_Members.DatabaseId
				GROUP BY
					dbo.plus2_Members.ID
					
			) AS MaxDateTable
			ON dbo.plus2_Members.ID = MaxDateTable.ID
WHERE
		(
			dbo.plus2_Attendance.AtDate BETWEEN '20190401' AND '20190710'
		)
		AND
		(
			YEAR(GETDATE() - YEAR(dbo.plus2_Members.BirthDate)) > 18
		)
GROUP BY
		dbo.plus2_Members.SiteID
		,dbo.plus2_Members.ID
		,dbo.plus2_Members.FirstNames
		,dbo.plus2_Members.LastName
		,dbo.plus2_Members.BirthDate
		,dbo.plus2_Members.HomeStreet
		,dbo.plus2_Members.HomePostCode
		,dbo.plus2_Members.HomeTown
		,dbo.plus2_Members.HomeEmail
		,dbo.plus2_Members.HomeTelephone
		,dbo.plus2_Members.MobileTelephone
		,dbo.plus2_Members.StatusID
		,dbo.plus2_Attendance.AtDate
		,MaxDateTable.MaxDate