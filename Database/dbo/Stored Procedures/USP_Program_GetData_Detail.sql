
CREATE proc [dbo].[USP_Program_GetData_Detail]
	@SuperProgramId bigint,
	@LoggedInUserId Uniqueidentifier
As
Begin
	Select 
			P.Id As ProgramId
			,P.ProgramTypeName		
			,PS.Code As ProgramStatusCode		
			,PT.ProgramType
			,AB.[Name] As AboveTheLineBelowTheLineName
			,P.Comment
			,dbo.CheckUserProgramPermission(@LoggedInUserId,SP.Id) IsAccess	
			--,P.ProgramStatusId
			--,AB.Id ATL_BTL_Id		
		From dbo.Program P With(Nolock)
		Left Join dbo.SuperProgram SP On P.SuperProgramId = SP.Id
		Left Join dbo.Program_ATL_BTL AB On P.AboveTheLineBelowTheLine = AB.Id
		Left Join dbo.ProgramStatus PS On P.ProgramStatusId = PS.Id
		Left Join dbo.ProgramType PT On P.ProgramTypeId = PT.Id	
		Where SP.Id = @SuperProgramId
	
End

