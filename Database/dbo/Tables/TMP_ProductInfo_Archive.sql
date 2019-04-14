CREATE TABLE [dbo].[TMP_ProductInfo_Archive] (
    [Id]             BIGINT           IDENTITY (1, 1) NOT NULL,
    [FileName]       NVARCHAR (1000)  NOT NULL,
    [LoggedInUserId] UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]      DATETIME         NOT NULL,
    CONSTRAINT [PK_TMP_ProductInfo_Archive] PRIMARY KEY CLUSTERED ([Id] ASC)
);

