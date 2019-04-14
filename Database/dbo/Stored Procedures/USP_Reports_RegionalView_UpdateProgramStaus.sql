
Create Proc [dbo].[USP_Reports_RegionalView_UpdateProgramStaus]
@ProgramId bigint,
@ProgramStatusId int
As
Begin
 SET NOCOUNT ON;

 Update dbo.Program Set ProgramStatusId = @ProgramStatusId Where Id = @ProgramId
End
