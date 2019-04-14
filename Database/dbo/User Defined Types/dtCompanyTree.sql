CREATE TYPE [dbo].[dtCompanyTree] AS TABLE (
    [NodeID]       VARCHAR (100) NULL,
    [EquipmentID]  BIGINT        NULL,
    [Name]         VARCHAR (250) NULL,
    [NodeLevel]    INT           NULL,
    [ParentNodeID] VARCHAR (100) NULL);

