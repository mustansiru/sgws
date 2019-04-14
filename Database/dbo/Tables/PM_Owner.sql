CREATE TABLE [dbo].[PM_Owner] (
    [Id]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [PM_Owner] VARCHAR (500) NULL,
    [IsActive] BIT           NULL,
    CONSTRAINT [PK_PM_Owner] PRIMARY KEY CLUSTERED ([Id] ASC)
);

