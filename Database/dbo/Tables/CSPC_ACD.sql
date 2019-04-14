CREATE TABLE [dbo].[CSPC_ACD] (
    [Id]         BIGINT       IDENTITY (1, 1) NOT NULL,
    [CSPC_Code]  VARCHAR (50) NULL,
    [ACD_Code]   VARCHAR (50) NULL,
    [ProvinceId] BIGINT       NOT NULL,
    [GID]        VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_CSPC] PRIMARY KEY CLUSTERED ([Id] ASC)
);

