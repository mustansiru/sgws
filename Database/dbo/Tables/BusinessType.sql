CREATE TABLE [dbo].[BusinessType] (
    [Id]           INT           NOT NULL,
    [BusinessType] VARCHAR (100) NULL,
    [Description]  VARCHAR (500) NULL,
    [IsActive]     BIT           NULL,
    CONSTRAINT [PK_BusinessType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

