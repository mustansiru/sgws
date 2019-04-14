CREATE TABLE [dbo].[Shipping] (
    [Id]                  BIGINT        IDENTITY (1, 1) NOT NULL,
    [GID]                 VARCHAR (50)  NOT NULL,
    [Lead_Time]           INT           NULL,
    [Shipping_Term]       VARCHAR (50)  NULL,
    [Product_Designation] VARCHAR (100) NULL,
    CONSTRAINT [PK_Shipping] PRIMARY KEY CLUSTERED ([Id] ASC)
);

