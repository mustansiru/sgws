CREATE TABLE [dbo].[Supplier] (
    [Id]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [SupplierCode] VARCHAR (10)  NOT NULL,
    [SupplierName] VARCHAR (255) NOT NULL,
    [LegalName]    VARCHAR (255) NOT NULL,
    [Active]       BIT           NOT NULL,
    CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED ([Id] ASC)
);

