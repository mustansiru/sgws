CREATE TABLE [dbo].[Product] (
    [Id]            BIGINT        IDENTITY (1, 1) NOT NULL,
    [GID]           VARCHAR (50)  NOT NULL,
    [ItemCode]      VARCHAR (50)  NULL,
    [ProductName]   VARCHAR (100) NOT NULL,
    [AlternateName] VARCHAR (100) NULL,
    [UPC_EAN_13]    VARCHAR (50)  NULL,
    [SCC_14]        VARCHAR (50)  NULL,
    [ProductStatus] VARCHAR (50)  NULL,
    [SupplierId]    BIGINT        NOT NULL,
    [BrandId]       BIGINT        NOT NULL,
    [CategoryId]    BIGINT        NOT NULL,
    [SubCategoryId] BIGINT        NOT NULL,
    [SupplierCode]  VARCHAR (10)  NULL,
    [PM_Owner_Id]   BIGINT        NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([Id] ASC)
);

