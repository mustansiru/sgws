CREATE TABLE [dbo].[ProgramExpense] (
    [Id]        BIGINT IDENTITY (1, 1) NOT NULL,
    [ProgramId] BIGINT NULL,
    [ExpenseId] BIGINT NULL,
    CONSTRAINT [PK_ProgramExpense] PRIMARY KEY CLUSTERED ([Id] ASC)
);

