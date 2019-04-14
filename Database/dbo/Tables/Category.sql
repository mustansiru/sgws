CREATE TABLE [dbo].[Category] (
    [Id]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [CategoryCode] VARCHAR (10)  NOT NULL,
    [Category]     VARCHAR (250) NOT NULL,
    [Description]  VARCHAR (500) NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([Id] ASC)
);

