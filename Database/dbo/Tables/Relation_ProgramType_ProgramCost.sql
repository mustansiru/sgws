CREATE TABLE [dbo].[Relation_ProgramType_ProgramCost] (
    [Id]                                  BIGINT IDENTITY (1, 1) NOT NULL,
    [ProgramTypeId]                       BIGINT NULL,
    [Depth]                               BIT    NULL,
    [ForecastCaseSalesBase]               BIT    NULL,
    [ForecastCaseSalesLift]               BIT    NULL,
    [ForecastTotalCaseSalesPhysCs]        BIT    NULL,
    [ForecastTotalCaseSales9LCsConverted] BIT    NULL,
    [VariableCostPerCase]                 BIT    NULL,
    [UpforntFees_LTO_BAM]                 BIT    NULL,
    [RedemptionBAM]                       BIT    NULL,
    [SpendQuantity]                       BIT    NULL,
    [SpendPerQuantity]                    BIT    NULL,
    [OtherFixedCost]                      BIT    NULL,
    CONSTRAINT [PK_Relation_ProgramType_ProgramCost] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Relation_ProgramType_ProgramCost_ProgramType] FOREIGN KEY ([ProgramTypeId]) REFERENCES [dbo].[ProgramType] ([Id])
);

