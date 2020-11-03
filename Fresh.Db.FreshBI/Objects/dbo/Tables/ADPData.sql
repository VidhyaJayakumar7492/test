CREATE TABLE [dbo].[ADPData] (
    Sno                     INT NOT NULL IDENTITY,
    [Company Code]          VARCHAR (255) NULL,
    [Department]            VARCHAR (255) NULL,
    [File Number]           VARCHAR (255)     NULL,
    [Pay Date]              DATE       NULL,
    [Pay Code]              VARCHAR (255) NULL,
    [Hours]                 VARCHAR (255)     NULL,
    [Dollars]               VARCHAR (255)     NULL,
    [Description]           VARCHAR (255) NULL,
    [Month]                 VARCHAR (255) NULL,
    [Quarter]               VARCHAR (255) NULL,
    [Day]                   VARCHAR (255) NULL,
    [Status]                VARCHAR (255) NULL,
    [Rate]                  VARCHAR (255)     NULL,
    [Doubletime conversion] VARCHAR (255) NULL, 
    [DataFileName]          VARCHAR(MAX) NULL,
    [LoadDateTime]          DATETIME NOT NULL DEFAULT (GETDATE()),
    [LoadStatus]            NCHAR(10) NOT NULL DEFAULT ('I'),
    CONSTRAINT PK_ADPData PRIMARY KEY (Sno)
);

