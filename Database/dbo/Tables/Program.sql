CREATE TABLE [dbo].[Program] (
    [Id]                       BIGINT        IDENTITY (1, 1) NOT NULL,
    [SuperProgramId]           BIGINT        NULL,
    [ProgramTypeName]          VARCHAR (200) NULL,
    [Comment]                  VARCHAR (500) NULL,
    [ProgramStatusId]          INT           NULL,
    [AboveTheLineBelowTheLine] INT           NULL,
    [CreatedDate]              DATETIME      NULL,
    [ModifiedDate]             DATETIME      NULL,
    [ProgramTypeId]            BIGINT        NULL,
    CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Program_Program_ATL_BTL] FOREIGN KEY ([AboveTheLineBelowTheLine]) REFERENCES [dbo].[Program_ATL_BTL] ([Id]),
    CONSTRAINT [FK_Program_ProgramType] FOREIGN KEY ([ProgramTypeId]) REFERENCES [dbo].[ProgramType] ([Id]),
    CONSTRAINT [FK_Program_SuperProgram] FOREIGN KEY ([SuperProgramId]) REFERENCES [dbo].[SuperProgram] ([Id])
);

