
select distinct 
		Members.ID
		,Members.TitleID
		,Members.FirstNames
		,Members.LastName
		,Members.HomeStreet
		,Members.HomePostCode
		,Members.HomeTown
		,Members.HomeEmail
		,Members.StatusID
		,Members.PriceLevelID
		,Members.CorporateID
		,Subscriptions.SubTypeID
		,SubscriptionTypes.[Description]
		,cast(Subscriptions.StartDate as date) as StartDate
		,cast(Subscriptions.EndDate as date) as EndDate
		,ProductPrices.Price
		--,Products.DepartmentID
		--,SubscriptionTypesProducts.ProductID
		--,SalesInvoiceProducts.ProductID
		--,SalesInvoices.TypeInd
		,SalesInvoices.Total
		,cast(SalesInvoices.DueDate as date) as DueDate
from 
		Members
		join Subscriptions on Subscriptions.MemberID = Members.ID
		join SubscriptionTypes on SubscriptionTypes.ID = Subscriptions.SubTypeID
		join SubscriptionTypesProducts on SubscriptionTypesProducts.SubTypeID = SubscriptionTypes.ID
		join ProductPrices on ProductPrices.ProductID = SubscriptionTypesProducts.ProductID
		join SalesInvoices on SalesInvoices.MemberID = Members.ID
		join SalesInvoiceProducts on SalesInvoiceProducts.ProductID = SubscriptionTypesProducts.ProductID
		join Products on Products.ID = SubscriptionTypesProducts.ProductID
where
		(
			Members.StatusID in ('RELA','PROSP')
		)
		and
		(
			SalesInvoices.TypeInd = 1 
		)
		and
		(
			SalesInvoices.DueDate between '2020-02-01' and '2020-02-29'
		)
		and
		(
			SalesInvoices.AccountTypeInd = '0'
		)
		and
		(
			Products.DepartmentID in ('1150000','8800','88000','880000')
		)
		and
		(
			Subscriptions.EndDate > getdate()
		)
order by
		Members.ID
