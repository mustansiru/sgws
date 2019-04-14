CREATE TYPE [dbo].[dtProperty] AS TABLE (
    [PropertyID] BIGINT        NULL,
    [NodeID]     VARCHAR (250) NULL,
    [Value]      VARCHAR (MAX) NULL,
    [NodeLevel]  INT           NULL);

