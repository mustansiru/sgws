CREATE TABLE [dbo].[Tmp_ParseError] (
    [Id]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [RecordId]    BIGINT         NOT NULL,
    [ColumnName]  VARCHAR (50)   NOT NULL,
    [ColumnValue] NVARCHAR (500) NOT NULL,
    [ErrroMsg]    NVARCHAR (500) NOT NULL,
    [GID]         VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_Tmp_ParseError] PRIMARY KEY CLUSTERED ([Id] ASC)
);

