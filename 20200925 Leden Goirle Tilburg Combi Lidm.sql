USE PELL_Members

SELECT
		m.ID
		,m.FirstNames
		,m.LastName
		,m.HomeEmail
		,m.StatusID
		,mu.Val
FROM 
		MemberUserFields mu
		LEFT JOIN Members m 
			ON m.ID = mu.MemberID

WHERE 
		mu.UserFieldID = 7
		--AND
		--m.StatusID in ('CURR','FROZ','SUSP','COMBI')


USE CPGL_Members

SELECT
		m.ID
		,m.FirstNames
		,m.LastName
		,m.HomeEmail
		,m.StatusID
		,mu.Val
FROM 
		MemberUserFields mu
		LEFT JOIN Members m 
			ON m.ID = mu.MemberID

WHERE 
		mu.UserFieldID = 21
		--AND
		--m.StatusID in ('CURR','FROZ','SUSP','COMBI')