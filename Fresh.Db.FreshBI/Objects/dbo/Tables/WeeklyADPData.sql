CREATE TABLE [dbo].[WeeklyADPData] (
    Sno            INT NOT NULL IDENTITY(1,1),
    [Company Code] VARCHAR (50) NULL,
    [Department]   VARCHAR (50) NULL,
    [File Number]  VARCHAR (50) NULL,
    [Pay Date]     VARCHAR (50) NULL,
    [Pay Code]     VARCHAR (50) NULL,
    [Hours]        VARCHAR (50) NULL,
    [Dollars]      VARCHAR (50) NULL,
    [Description]  VARCHAR (50) NULL, 
    [WeeklyFileName] VARCHAR(MAX) NULL,
    [LoadDateTime]     DATETIME NOT NULL DEFAULT (GETDATE())
);

