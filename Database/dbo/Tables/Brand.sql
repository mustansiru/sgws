CREATE TABLE [dbo].[Brand] (
    [Id]           BIGINT           IDENTITY (1, 1) NOT NULL,
    [BrandName]    VARCHAR (500)    NOT NULL,
    [BrandCode]    VARCHAR (10)     NOT NULL,
    [Description]  VARCHAR (500)    NULL,
    [OwnerId]      UNIQUEIDENTIFIER NULL,
    [SupplierCode] VARCHAR (10)     NULL,
    CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED ([Id] ASC)
);

