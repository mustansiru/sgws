CREATE TABLE [dbo].[SubCategory] (
    [Id]              BIGINT        IDENTITY (1, 1) NOT NULL,
    [SubCategoryCode] VARCHAR (10)  NOT NULL,
    [SubCategory]     VARCHAR (250) NOT NULL,
    [Description]     VARCHAR (500) NULL,
    [CategoryId]      BIGINT        NULL,
    CONSTRAINT [PK_SubCategory] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_SubCategory_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id])
);

