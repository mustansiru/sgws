CREATE TABLE [dbo].[SupplierContact] (
    [Id]                       BIGINT          IDENTITY (1, 1) NOT NULL,
    [SupplierId]               BIGINT          NOT NULL,
    [HQ_Contact_Name]          VARCHAR (100)   NULL,
    [HQ_Contact_Name_Position] VARCHAR (50)    NULL,
    [HQ_Address]               NVARCHAR (1000) NULL,
    [HQ_City]                  VARCHAR (100)   NULL,
    [HQ_Postal_Code]           VARCHAR (50)    NULL,
    [HQ_Country]               VARCHAR (100)   NULL,
    [HQ_Phone_Number]          VARCHAR (50)    NULL,
    [HQ_Email]                 NVARCHAR (256)  NULL,
    CONSTRAINT [PK_SupplierContact] PRIMARY KEY CLUSTERED ([Id] ASC)
);

