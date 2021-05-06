USE
		CPGL_Members
SELECT DISTINCT
		Members.ID
		,Members.TitleID
		,Members.LastName
		,Members.FirstNames
		,CAST(Members.BirthDate AS DATE) BirthDate
		,Members.HomeStreet
		,Members.HomePostCode
		,Members.HomeTown
		,Members.HomeEmail
		,Members.StatusID
		,Members.PriceLevelID
		,Members.CorporateID
		,Subscriptions.SubTypeID
		,SubscriptionTypesProducts.ProductID
		,SubscriptionTypes.[Description]
		,CAST(Subscriptions.StartDate AS DATE) StartDate
		,CAST(Subscriptions.EndDate AS DATE) EndDate
		,ProductPrices.Price
		,Products.DepartmentID
		,COUNT(Attendance.MemberID)/2 VisitsGoirle
FROM 
		Members
		LEFT JOIN Attendance
			ON Attendance.MemberID = Members.ID
		LEFT JOIN Subscriptions 
			ON Subscriptions.MemberID = Members.ID
		LEFT JOIN SubscriptionTypes 
			ON SubscriptionTypes.ID = Subscriptions.SubTypeID
		LEFT JOIN SubscriptionTypesProducts 
			ON SubscriptionTypesProducts.SubTypeID = SubscriptionTypes.ID
		LEFT JOIN ProductPrices 
			ON ProductPrices.ProductID = SubscriptionTypesProducts.ProductID
		LEFT JOIN Products 
			ON Products.ID = SubscriptionTypesProducts.ProductID
WHERE
		(
			Members.StatusID IN ('CURR','FROZ','SUSP','SUS','RELA','PROSP')
		)
		AND
		(
			Subscriptions.EndDate > GETDATE()
		)
		AND
		(
			Subscriptions.SubTypeID like 'TILB'
		)
		--AND
		--(
		--	Attendance.AtDate > '20140101'
		--)
GROUP BY
		Members.ID
		,Members.TitleID
		,Members.FirstNames
		,Members.LastName
		,Members.BirthDate
		,Members.HomeStreet
		,Members.HomePostCode
		,Members.HomeTown
		,Members.HomeEmail
		,Members.StatusID
		,Members.PriceLevelID
		--,Attendance.SwipeID
		,Members.CorporateID
		,Subscriptions.SubTypeID
		,SubscriptionTypesProducts.ProductID
		,SubscriptionTypes.[Description]
		,Subscriptions.StartDate
		,Subscriptions.EndDate
		,ProductPrices.Price
		,Products.DepartmentID