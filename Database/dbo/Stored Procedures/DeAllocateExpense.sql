CREATE proc [dbo].[DeAllocateExpense]
(
	@ExpenseId bigint=0,
	@ProgramId bigint=0
)
As
Begin
	delete ProgramExpense where ProgramId=@ProgramId and ExpenseId=@ExpenseId	
End
