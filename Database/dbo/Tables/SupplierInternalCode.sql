CREATE TABLE [dbo].[SupplierInternalCode] (
    [Id]                      BIGINT       IDENTITY (1, 1) NOT NULL,
    [SupplierId]              BIGINT       NOT NULL,
    [Supplier_Internal_Code]  VARCHAR (50) NULL,
    [Supplier_Internal_Code2] VARCHAR (50) NULL,
    [Supplier_Internal_Code3] VARCHAR (50) NULL,
    CONSTRAINT [PK_SupplierInternalCode] PRIMARY KEY CLUSTERED ([Id] ASC)
);

