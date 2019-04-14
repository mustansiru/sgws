CREATE TABLE [dbo].[SuperProgram] (
    [Id]                        BIGINT        IDENTITY (1, 1) NOT NULL,
    [SGWSFiscalId]              BIGINT        NULL,
    [StartDate]                 DATETIME      NULL,
    [EndDate]                   DATETIME      NULL,
    [FiscalYearByLiquorBoardId] BIGINT        NULL,
    [GID]                       VARCHAR (200) NULL,
    [IsSkuBased]                BIT           NULL,
    [IsBrandBased]              BIT           NULL,
    [ProvinceId]                BIGINT        NULL,
    [BusinessTypeId]            INT           NULL,
    [SuperProgramName]          VARCHAR (200) NULL,
    [IsOverrideDate]            BIT           NULL,
    CONSTRAINT [PK_SuperProgram] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_SuperProgram_BusinessType] FOREIGN KEY ([BusinessTypeId]) REFERENCES [dbo].[BusinessType] ([Id]),
    CONSTRAINT [FK_SuperProgram_FiscalYearByLiquorBoard] FOREIGN KEY ([FiscalYearByLiquorBoardId]) REFERENCES [dbo].[FiscalYearByLiquorBoard] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_SuperProgram_Province] FOREIGN KEY ([ProvinceId]) REFERENCES [dbo].[Province] ([Id])
);

