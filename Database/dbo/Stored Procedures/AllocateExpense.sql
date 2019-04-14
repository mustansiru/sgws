CREATE proc [dbo].[AllocateExpense]
(
	@ExpenseId bigint=0,
	@ProgramId bigint=0
)
As
Begin
	delete ProgramExpense where ProgramId=@ProgramId and ExpenseId=@ExpenseId

	insert into ProgramExpense (ProgramId,ExpenseId)
	values(@ProgramId,@ExpenseId)
 
End
