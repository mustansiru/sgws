CREATE TABLE [dbo].[Province] (
    [Id]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [Code]     VARCHAR (10)  NOT NULL,
    [Province] VARCHAR (100) NOT NULL,
    [Region]   VARCHAR (100) NULL,
    CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED ([Id] ASC)
);

