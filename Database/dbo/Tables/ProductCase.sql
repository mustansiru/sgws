CREATE TABLE [dbo].[ProductCase] (
    [Id]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [GID]         VARCHAR (50)    NOT NULL,
    [Case_Height] DECIMAL (10, 2) NULL,
    [Case_Width]  DECIMAL (10, 2) NULL,
    [Case_Length] DECIMAL (10, 2) NULL,
    [Case_Weight] DECIMAL (10, 2) NULL,
    CONSTRAINT [PK_ProductCase] PRIMARY KEY CLUSTERED ([Id] ASC)
);

