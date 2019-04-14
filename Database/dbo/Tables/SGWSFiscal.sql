CREATE TABLE [dbo].[SGWSFiscal] (
    [Id]        BIGINT       IDENTITY (1, 1) NOT NULL,
    [Year]      INT          NULL,
    [Period]    VARCHAR (50) NULL,
    [StartDate] DATETIME     NULL,
    [EndDate]   DATETIME     NULL,
    CONSTRAINT [PK_SGWSFiscal] PRIMARY KEY CLUSTERED ([Id] ASC)
);

