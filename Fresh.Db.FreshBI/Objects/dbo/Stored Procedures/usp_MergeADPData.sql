CREATE PROCEDURE [dbo].[usp_MergeADPData]
AS
BEGIN


	;WITH CTE_WeeklyData AS (
		SELECT 
			[Company Code], 
			[Department],
			[File Number],
			CONVERT(DATE,[Pay Date]) AS [Pay Date],
			LEFT(DATENAME(MONTH, CONVERT(DATE,[Pay Date])), 3) AS [Month],
			CONCAT('Q', DATENAME(QUARTER, CONVERT(DATE,[Pay Date]))) AS [Quarter],
			LEFT(DATENAME(WEEKDAY, CONVERT(DATE,[Pay Date])), 3) AS [Day],
			CASE WHEN [File Number] <> '' THEN 'OK' ELSE 'Missing' END AS [Status],
			[Pay Code],
			Hours,
			Dollars,
			Description,
			CONVERT(NUMERIC(18,2), 
				CONVERT(NUMERIC(18,2), [Dollars]) /CONVERT(NUMERIC(18,2), [Hours])
			) AS Rate,
			CASE
				WHEN [Pay Code] IN ('DBLTME', 'OVERTIME') THEN 'OVERTIME'
				ELSE [Pay Code] 
			END AS [Doubletime Conversion],
			WeeklyFileName AS DataFileName
		FROM dbo.WeeklyADPData
	)

	MERGE dbo.ADPData AS Tgt 
	USING (
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
			,CASE WHEN [Doubletime Conversion] = 'REGULAR' THEN CAST([Rate] AS VARCHAR(10)) ELSE '' END AS [Rate]
			,[Doubletime Conversion]
			,DataFileName
		FROM CTE_WeeklyData
	
	) AS Src ON (
		Src.[Company Code]		= Tgt.[Company Code]
		AND Src.[Department]	= Tgt.[Department]
		AND Src.[File Number]	= Tgt.[File Number]
		AND Src.[Pay Date]		= Tgt.[Pay Date]
		AND Src.[Pay Code]		= Tgt.[Pay Code]
	)
	WHEN MATCHED THEN 
		UPDATE
			SET 
				Tgt.[Hours]						= Src.[Hours]
				,Tgt.[Dollars]					= Src.[Dollars]
				,Tgt.[Description]				= Src.[Description]
				,Tgt.[Month]					= Src.[Month]
				,Tgt.[Quarter]					= Src.[Quarter]
				,Tgt.[Day]						= Src.[Day]
				,Tgt.[Status]					= Src.[Status]
				,Tgt.[Rate]						= Src.[Rate]
				,Tgt.[Doubletime conversion]	= Src.[Doubletime Conversion]
				,Tgt.[DataFileName]				= Src.DataFileName
				,Tgt.[LoadStatus]				= 'U'
				,Tgt.[LoadDateTime]				= GETDATE()

	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (
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
			,[DataFileName]
			,[LoadStatus]
		
		)
		VALUES (
			 Src.[Company Code]
			,Src.[Department]
			,Src.[File Number]
			,Src.[Pay Date]
			,Src.[Pay Code]
			,Src.[Hours]
			,Src.[Dollars]
			,Src.[Description]
			,Src.[Month]
			,Src.[Quarter]
			,Src.[Day]
			,Src.[Status]
			,Src.[Rate]
			,Src.[Doubletime Conversion]
			,Src.DataFileName
			,'I'
		);

END
GO
/*
EXEC [uspMergeADPData]

Truncate table dbo.ADPData
SELECT * FROM dbo.ADPData


*/