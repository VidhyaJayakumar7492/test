CREATE VIEW [dbo].[vw_ADPData]
AS
SELECT 
	[Company Code]
	,[Department]
	,[File Number]
	,[Pay Date]
	,[Pay Code]
	,[Hours]
	,[Dollars]
	,[Description]
	,[Month]
	,[Quarter]
	,[Day]
	,[Status]
	,[Rate]
	,[Doubletime Conversion]
FROM ADPData
