USE [dev-promoplan]
GO

/****** Object:  StoredProcedure [dbo].[USP_Reports_GetRegionalViewByBrand]    Script Date: 4/11/2019 8:29:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[USP_Reports_GetRegionalViewByBrand] --10, 0, 1, 'desc','|FiscalYearByLiquorBoardId:'P12'' ,'E0E48589-B8C9-46C1-889F-42395C3A1D79'
	 @iDisplayLength int = 10,
     @iDisplayStart int = 1,
     @iSortCol_0 int = 1,
     @sSortDir_0 varchar(4) = null,
     @sSearch nvarchar(max) = null,
	 @LoggedInUser	uniqueidentifier = null
as
begin

SET NOCOUNT ON;

Declare @SQL Nvarchar(Max) = ''
		, @col varchar(50) = 'FL.Period'
		, @Is_SKU_Brand varchar(100) = ''
		, @ParmDefinition nvarchar(500);
		


If LEN(@sSearch) > 0 
Begin
	Select @sSearch = replace(@sSearch,'|',' And ')
	Select @sSearch =  replace(@sSearch,':',' = ')
	Select @sSearch =  replace(@sSearch,'SGWS_Calendar_Year','SF.Year')
	Select @sSearch =  replace(@sSearch,'ProvinceCode','SP.ProvinceId')
	Select @sSearch =  replace(@sSearch,'FiscalYearByLiquorBoardId','FL.Period')
	Select @sSearch =  replace(@sSearch,'SupplierId','PR.SupplierId')
	Select @sSearch =  replace(@sSearch,'BrandId','PR.BrandId')
	Select @sSearch = ' Where 1=1 ' + @sSearch

End
Select @col = 'FL.Period'

--If @iSortCol_0 = 2
--Begin
--	Select @col = 'FL.Period'
--End

--If @iSortCol_0 = 3
--Begin
--	Select @col = 'PC.TotalProgramSpend'
--End

declare @iTotalRecords int = 0; 
	
Set @SQL = 'Select 
			@Total = Count(1)
			From (Select SF.Period
			From dbo.SuperProgram SP With(Nolock) 
			Left Join dbo.FiscalYearByLiquorBoard FL With(Nolock) On SP.FiscalYearByLiquorBoardId = FL.Id
			Left Join dbo.SGWSFiscal SF With(Nolock) On FL.SGWSFiscalId = SF.Id
			Left Join dbo.LiquorBoard LB With (Nolock) On LB.Id = FL.LiquorBoardId
			Left Join dbo.Province PRV With(Nolock) On LB.ProvinceId = PRV.Id
			Left Join dbo.Product PR With(Nolock) On SP.GID = PR.GID  ' 
			+ @sSearch + 
			' Group By SF.Period) A '

Set @ParmDefinition = N'@Total int OUTPUT';			
EXECUTE sp_executesql @SQL,@ParmDefinition, @Total = @iTotalRecords OUTPUT
--Print(@sql)
--Print (@iTotalRecords)

Select @SQL = ''
Set @SQL = '
Select distinct ' + Cast(@iTotalRecords As Varchar(100)) + ' TotalRecords
		,SP.Id SuperProgramId
		,SP.SuperProgramName
		,PV.Code ProvinceCode
		--,FL.Period
		,SF.Period SGWS_Calendar_Period
		,SF.Year SGWS_Calendar_Year
		,FL.Period As LiquorBoardPeriod		
		,FL.StartDate
		,FL.EndDate
		,Isnull(SP.IsSkuBased,0) As IsSkuBased
		,SP.GID
		,PR.AlternateName
		,PD.ContainerVolume
		,PD.Containers_Selling_Unit
		,PD.Selling_Units_Case
		,P.Id As ProgramId
		,P.ProgramTypeName
		,PT.ProgramType
		,AB.[Name] As AboveTheLineBelowTheLineName
		,P.Comment
		,PS.Code As ProgramStatusCode
		,PC.TotalProgramSpend
		,dbo.CheckProgramAllocateExpenseAccess( ''' + Cast(@LoggedInUser As Varchar(100)) + ''',SP.Id)	IsAccess
		,'''' No_Data	
		,PC.Depth
		, PC.ForecastCaseSalesBase
		, PC.ForecastCaseSalesLift
		, PC.ForecastTotalCaseSalesPhysCs
		, PC.ForecastTotalCaseSales9LCsConverted
		, PC.VariableCostPerCase
		, PC.UpforntFees_LTO_BAM
		, PC.RedemptionBAM
		, PC.SpendQuantity
		, PC.SpendPerQuantity
		, PC.OtherFixedCost
	From (
		  Select * From 
		  (
			Select ROW_NUMBER() OVER ( ORDER BY SF.Period) AS RowNum,SF.Id							
			From dbo.SuperProgram SP With(Nolock) 
			Left Join dbo.FiscalYearByLiquorBoard FL With(Nolock) On SP.FiscalYearByLiquorBoardId = FL.Id
			Left Join dbo.SGWSFiscal SF With(Nolock) On FL.SGWSFiscalId = SF.Id
			Left Join dbo.LiquorBoard LB With (Nolock) On LB.Id = FL.LiquorBoardId
			Left Join dbo.Province PRV With(Nolock) On LB.ProvinceId = PRV.Id
			Left Join dbo.Product PR With(Nolock) On SP.GID = PR.GID  ' 
			+ @sSearch + 
		    ' Group By SF.Period,SF.Id
		  ) A Where A.RowNum >= ' + Cast((@iDisplayStart + 1) As Varchar(100)) + ' And A.RowNum <= ' + Cast((@iDisplayStart + @iDisplayLength) As Varchar(100)) + 
	') FY	
	Left Join dbo.SuperProgram SP With(Nolock) On FY.Id = SP.SGWSFiscalId
	Left Join dbo.Program P With(Nolock) On SP.Id = P.SuperProgramId
	Left Join dbo.Program_ATL_BTL AB With(Nolock) On P.AboveTheLineBelowTheLine = AB.Id
	Left Join dbo.ProgramStatus PS With(Nolock) On P.ProgramStatusId = PS.Id
	Left Join dbo.ProgramType PT With(Nolock) On P.ProgramTypeId = PT.Id	
	Left Join dbo.BusinessType BT With(Nolock) On SP.BusinessTypeId = BT.Id
	Left Join dbo.Province PV With(Nolock) On SP.ProvinceId = PV.Id
	Inner Join dbo.ProgramCost PC With(Nolock) On P.Id = PC.ProgramId
	Left Join dbo.Product PR With(Nolock) On SP.GID = PR.GID
	Left Join dbo.ProductDetails PD With(Nolock) On PR.GID = PD.GID
	Left Join dbo.FiscalYearByLiquorBoard FL With(Nolock) On SP.FiscalYearByLiquorBoardId = FL.Id
	Left Join dbo.SGWSFiscal SF With(Nolock) On FL.SGWSFiscalId = SF.Id
	Left Join dbo.LiquorBoard LB With (Nolock) On LB.Id = FL.LiquorBoardId
	
	' 	
	+ @sSearch 
	+ ' Order By ' + @col + ' ' + @sSortDir_0
	
	Print(@sql)
	exec( @sql)
end


GO


