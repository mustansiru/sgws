CREATE TABLE [dbo].[Users] (
    [UserId]       UNIQUEIDENTIFIER NOT NULL,
    [CompanyID]    BIGINT           NULL,
    [FirstName]    NVARCHAR (100)   NULL,
    [LastName]     NVARCHAR (100)   NULL,
    [PhoneNo]      VARCHAR (50)     NULL,
    [ProfileImage] NVARCHAR (500)   NULL,
    [CreatedOn]    DATETIME         NULL,
    [CreatedBy]    VARCHAR (50)     NULL,
    [ModifiedOn]   DATETIME         NULL,
    [ModifiedBy]   VARCHAR (50)     NULL,
    [IsDeleted]    BIT              NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId] ASC)
);

