CREATE TABLE [dbo].[FileInfo] (
    [Id]          BIGINT           IDENTITY (1, 1) NOT NULL,
    [FileName]    NVARCHAR (500)   NOT NULL,
    [UserName]    UNIQUEIDENTIFIER NOT NULL,
    [CreatedDate] DATETIME         NOT NULL,
    [IsSync]      BIT              NOT NULL,
    CONSTRAINT [PK_FileInfo] PRIMARY KEY CLUSTERED ([Id] ASC)
);

