CREATE TABLE [dbo].[ProgramCost] (
    [Id]                                  BIGINT IDENTITY (1, 1) NOT NULL,
    [ProgramId]                           BIGINT NULL,
    [Depth]                               MONEY  NULL,
    [ForecastCaseSalesBase]               MONEY  NULL,
    [ForecastCaseSalesLift]               MONEY  NULL,
    [ForecastTotalCaseSalesPhysCs]        MONEY  NULL,
    [ForecastTotalCaseSales9LCsConverted] MONEY  NULL,
    [VariableCostPerCase]                 MONEY  NULL,
    [UpforntFees_LTO_BAM]                 MONEY  NULL,
    [RedemptionBAM]                       MONEY  NULL,
    [SpendQuantity]                       MONEY  NULL,
    [SpendPerQuantity]                    MONEY  NULL,
    [OtherFixedCost]                      MONEY  NULL,
    [TotalProgramSpend]                   MONEY  NULL,
    CONSTRAINT [PK_ProgramCost] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ProgramCost_Program] FOREIGN KEY ([ProgramId]) REFERENCES [dbo].[Program] ([Id])
);

