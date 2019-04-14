CREATE TABLE [dbo].[ProgramType] (
    [Id]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [ProgramType] VARCHAR (200) NULL,
    [Description] VARCHAR (500) NULL,
    [IsActive]    BIT           NULL,
    CONSTRAINT [PK_ProgramType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

