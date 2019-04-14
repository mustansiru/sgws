Create proc [dbo].[GetProgramPopupDropdowns]
As
Begin
	select Id,ProgramType as Value from programtype where IsActive=1
	select Id,Name as Value from Program_ATL_BTL
	select Id,Code as Value from ProgramStatus
End
