USE [dev-promoplan]
GO
/****** Object:  StoredProcedure [dbo].[GetSummaryRollup]    Script Date: 05/04/2019 7:39:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSummaryRollup]
	-- Add the parameters for the stored procedure here
	@iDisplayLength int = 10,
     @iDisplayStart int = 1,
     @iSortCol_0 int = 1,
     @sSortDir_0 varchar(4) = null,
     @sSearch nvarchar(max) = '',
	 @LoggedInUser	uniqueidentifier = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

     Declare @SQL nvarchar(max) = ''
		
	If LEN(@sSearch) > 0 
	Begin
		Select @sSearch = replace(@sSearch,'|RDB:SGWS','')
		Select @sSearch = replace(@sSearch,'|RDB:LIQR','')
		Select @sSearch = replace(@sSearch,'|',' And ')
		Select @sSearch =  replace(@sSearch,':',' = ')
		Select @sSearch =  replace(@sSearch,'SGWS_Calendar_Year','SF.Year')
		Select @sSearch =  replace(@sSearch,'ProvinceCode','PRV.Id')
		--Select @sSearch =  replace(@sSearch,'FiscalYearByLiquorBoardId','FL.Period')
		Select @sSearch =  replace(@sSearch,'SupplierId','PR.SupplierId')
		Select @sSearch =  replace(@sSearch,'BrandId','PR.BrandId')
		Select @sSearch = ' Where 1=1 ' + @sSearch
	End

	-- TotalProgramSpend rollup
Set @SQL = ' Select Sum(PC.TotalProgramSpend) Spend, ATLBTL.Name ATL_BTL, ''PlannedSpend'' SpendType
	From ProgramCost PC
		Inner Join Program P on P.Id = PC.ProgramId
		Inner Join SuperProgram SP on SP.Id = P.SuperProgramId
		Inner Join dbo.FiscalYearByLiquorBoard FL With(Nolock) On SP.FiscalYearByLiquorBoardId = FL.Id
		Inner Join SGWSFiscal SF on SF.Id = SP.FiscalYearByLiquorBoardId
		Inner Join ProgramStatus PS on PS.Id = P.ProgramStatusId
		Inner Join Program_ATL_BTL ATLBTL on ATLBTL.Id = P.AboveTheLineBelowTheLine
		Inner Join dbo.LiquorBoard LB With (Nolock) On LB.Id = FL.LiquorBoardId
		Inner Join dbo.Province PRV With(Nolock) On LB.ProvinceId = PRV.Id
		Inner Join Product PR On SP.GID = PR.GID 		
		' + @sSearch +
		'
			 And PS.Id NOT IN (5, 6) -- REJECTED BOARD / REJECTED STRATEGY
			Group By P.AboveTheLineBelowTheLine,ATLBTL.Name
		
	Union All
	-- Total Actual Spend Rollup
	Select sum(E.Amount_Net) Spend, ATLBTL.Name ATL_BTL, ''ActualSpend'' SpendType
	From ProgramExpense PE
		Inner Join Expense E on E.Id = PE.ExpenseId
		Inner Join Program P on P.Id = PE.ProgramId
		Inner Join SuperProgram SP on SP.Id = P.SuperProgramId
		Inner Join dbo.FiscalYearByLiquorBoard FL With(Nolock) On SP.FiscalYearByLiquorBoardId = FL.Id
		Inner Join SGWSFiscal SF on SF.Id = SP.FiscalYearByLiquorBoardId
		Inner Join ProgramStatus PS on PS.Id = P.ProgramStatusId
		Inner Join Program_ATL_BTL ATLBTL on ATLBTL.Id = P.AboveTheLineBelowTheLine
		Inner Join dbo.LiquorBoard LB With (Nolock) On LB.Id = FL.LiquorBoardId
		Inner Join dbo.Province PRV With(Nolock) On LB.ProvinceId = PRV.Id
		Inner Join Product PR On SP.GID = PR.GID ' + @sSearch +
		'
			 And PS.Id NOT IN (5, 6)  -- REJECTED BOARD / REJECTED STRATEGY
			Group By P.AboveTheLineBelowTheLine,ATLBTL.Name
		'
		Print(@SQL)
		Exec(@SQL)
END --BEGIN
