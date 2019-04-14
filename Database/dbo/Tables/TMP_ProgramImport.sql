﻿CREATE TABLE [dbo].[TMP_ProgramImport] (
    [Id]                                  BIGINT         IDENTITY (1, 1) NOT NULL,
    [ProvinceCode]                        VARCHAR (50)   NULL,
    [SGWS_Calendar_Year]                  VARCHAR (10)   NULL,
    [SGWS_Calendar_Period]                VARCHAR (50)   NULL,
    [Liquor_Board_Period]                 VARCHAR (50)   NULL,
    [Start_Date]                          VARCHAR (10)   NULL,
    [End_Date]                            VARCHAR (10)   NULL,
    [GID]                                 VARCHAR (50)   NULL,
    [Is_SKU_Brand]                        VARCHAR (50)   NULL,
    [CSPC]                                VARCHAR (50)   NULL,
    [ProgramType]                         VARCHAR (50)   NULL,
    [Comments]                            VARCHAR (1000) NULL,
    [ATL_BTL]                             VARCHAR (50)   NULL,
    [Program_Status]                      VARCHAR (50)   NULL,
    [Depth]                               VARCHAR (50)   NULL,
    [ForecastCaseSalesBase]               VARCHAR (50)   NULL,
    [ForecastCaseSalesLift]               VARCHAR (50)   NULL,
    [ForecastTotalCaseSalesPhysCs]        VARCHAR (50)   NULL,
    [ForecastTotalCaseSales9LCsConverted] VARCHAR (50)   NULL,
    [VariableCostPerCase]                 VARCHAR (50)   NULL,
    [UpforntFees_LTO_BAM]                 VARCHAR (50)   NULL,
    [RedemptionBAM]                       VARCHAR (50)   NULL,
    [SpendQuantity]                       VARCHAR (50)   NULL,
    [SpendPerQuantity]                    VARCHAR (50)   NULL,
    [OtherFixedCost]                      VARCHAR (50)   NULL,
    [TotalProgramSpend]                   VARCHAR (50)   NULL,
    [Actual_Spend]                        VARCHAR (50)   NULL,
    [Actual_Volume]                       VARCHAR (50)   NULL,
    [UniqueID]                            VARCHAR (50)   NULL,
    CONSTRAINT [PK_TMP_ProgramImport] PRIMARY KEY CLUSTERED ([Id] ASC)
);
