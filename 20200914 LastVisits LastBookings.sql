SELECT DISTINCT
		CASE plus2_Attendance.SiteID
			WHEN 'ALM' THEN 'Almere'
			WHEN 'AME' THEN 'Amersfoort'
			WHEN 'APE' THEN 'Apeldoorn'
			WHEN 'BRE' THEN 'Breda'
			WHEN 'GOI' THEN 'Goirle'
			WHEN 'MAA' THEN 'Maastricht'
			WHEN 'TIL' THEN 'Tilburg'
		END AS SiteID
		,plus2_Attendance.MemberId
		,plus2_Members.FirstNames
		,plus2_Members.LastName
		,plus2_Members.HomeEmail
		,plus2_Members.MobileTelephone
		,plus2_Members.HomeTelephone
		,LastAttendance.LastVisit
		,LastBooked.LastB AS BookingDate
		,MAX(CAST(plus2_Bookings.StartDateTime AS DATE)) AS BookingStart
		,plus2_Members.StatusID 
FROM
		plus2_Attendance
		LEFT JOIN plus2_Members
			ON plus2_Members.ID = plus2_Attendance.MemberId
			AND plus2_Members.SiteID = plus2_Attendance.SiteID
		LEFT JOIN plus2_BookingMembers
			ON plus2_BookingMembers.MemberID = plus2_Members.ID
			AND plus2_BookingMembers.SiteID = plus2_Members.SiteID
		LEFT JOIN plus2_Bookings
			ON plus2_Bookings.ID = plus2_BookingMembers.BookingID
			AND plus2_Bookings.SiteID = plus2_BookingMembers.SiteID
	    INNER JOIN (
			SELECT
				MAX(plus2_BookingMembers.BookedDate) LastB
				,plus2_BookingMembers.MemberID
				,plus2_BookingMembers.SiteID
			FROM
				plus2_BookingMembers
			GROUP BY
				plus2_BookingMembers.MemberID
				,plus2_BookingMembers.SiteID
		) AS LastBooked
			ON plus2_BookingMembers.MemberID = LastBooked.MemberID
			AND plus2_BookingMembers.SiteID = LastBooked.SiteID
			AND plus2_BookingMembers.BookedDate = LastBooked.LastB
		INNER JOIN(
			SELECT
				MAX(plus2_Attendance.AtDate) AS LastVisit
				,plus2_Attendance.MemberID
				,plus2_Attendance.SiteID
			FROM
				plus2_Attendance
			GROUP BY
				plus2_Attendance.MemberID
				,plus2_Attendance.SiteID) AS LastAttendance
			ON plus2_Attendance.MemberID = LastAttendance.MemberID
			AND plus2_Attendance.SiteID = LastAttendance.SiteID
			AND plus2_Attendance.AtDate = LastAttendance.LastVisit			
WHERE
		(
			plus2_Members.StatusID IN ('CURR','FROZ','SUSP','SUS')
		)
		AND
		(
			LastBooked.LastB < LastAttendance.LastVisit
		)
		AND
		(
			LastAttendance.LastVisit < '20200901'
		)
GROUP BY
	plus2_Attendance.MemberId
	,plus2_Members.FirstNames
	,plus2_Members.LastName
	,plus2_Members.HomeEmail
	,plus2_Members.MobileTelephone
	,plus2_Members.HomeTelephone
	,LastAttendance.LastVisit
	,LastBooked.LastB
	,plus2_Members.StatusID 
	,plus2_Attendance.SiteID