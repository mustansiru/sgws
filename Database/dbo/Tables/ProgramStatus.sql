CREATE TABLE [dbo].[ProgramStatus] (
    [Id]          BIGINT        NOT NULL,
    [Code]        VARCHAR (200) NULL,
    [Description] VARCHAR (500) NULL,
    CONSTRAINT [PK_ProgramStatus] PRIMARY KEY CLUSTERED ([Id] ASC)
);

