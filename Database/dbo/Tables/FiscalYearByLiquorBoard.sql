CREATE TABLE [dbo].[FiscalYearByLiquorBoard] (
    [Id]            BIGINT       IDENTITY (1, 1) NOT NULL,
    [LiquorBoardId] INT          NULL,
    [Year]          VARCHAR (50) NULL,
    [Period]        VARCHAR (50) NULL,
    [StartDate]     DATETIME     NULL,
    [EndDate]       DATETIME     NULL,
    [SGWSFiscalId]  BIGINT       NULL,
    CONSTRAINT [PK_FiscalYearByLiquorBoard] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_FiscalYearByLiquorBoard_SGWSFiscal] FOREIGN KEY ([SGWSFiscalId]) REFERENCES [dbo].[SGWSFiscal] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
);

