CREATE proc [dbo].[USP_Program_GetprogramSpendData] 	--10, 0, 16, 'desc','On','54B31D3F-2C5D-4B14-ADF4-20C277738747' 
	 @iDisplayLength int = 10,
     @iDisplayStart int = 1,
     @iSortCol_0 int = 1,
     @sSortDir_0 varchar(4) = null,
     @sSearch nvarchar(max) = null,
	 @LoggedInUser	uniqueidentifier = null
as
begin

SET NOCOUNT ON;

Declare @SQL Nvarchar(Max) = '', @col varchar(50) = 'SuperProgramName'
, @Is_SKU_Brand varchar(100) = ''
, @IsAdmin Bit = 0
, @ParmDefinition nvarchar(500);


IF @sSearch = 'sku'
Begin
	Select @Is_SKU_Brand = ' Or SP.IsSkuBased like ''%1%'''
End

IF @sSearch = 'brand'
Begin
	Select @Is_SKU_Brand = ' Or SP.IsSkuBased like ''%0%'''
End


If LEN(@sSearch) > 0 
Begin
	Select @sSearch = ' Where SP.SuperProgramName like ''%' +  @sSearch + '%'''
							+ ' Or FY.Period like ''%' + @sSearch + '%'''
							+ ' Or PV.Code like ''%' + @sSearch + '%'''
							+ @Is_SKU_Brand
							+ ' Or CONVERT(VARCHAR(8), FY.StartDate, 112) like ''%' + @sSearch + '%'''
							+ ' Or CONVERT(VARCHAR(8), FY.EndDate, 112) like ''%' + @sSearch + '%'''
							+ ' Or SP.GID like ''%' + @sSearch + '%'''
							+ ' Or PR.AlternateName like ''%' + @sSearch + '%'''
							+ ' Or SF.Period like ''%' + @sSearch + '%'''
							+ ' Or SF.Year like ''%' + @sSearch + '%'''
							+ ' Or P.ProgramTypeName like ''%' + @sSearch + '%'''
							+ ' Or PT.ProgramType like ''%' + @sSearch + '%'''
							+ ' Or AB.[Name] like ''%' + @sSearch + '%'''
							+ ' Or P.Comment like ''%' + @sSearch + '%'''
							+ ' Or PS.Code like ''%' + @sSearch + '%'''
							+ ' Or PC.TotalProgramSpend like ''%' + @sSearch + '%'''
								
End

--Select @iDisplayStart = @iDisplayStart + 1

If @iSortCol_0 = 1
Begin
	Select @col = 'SuperProgramName'
End

If @iSortCol_0 = 2
Begin
	Select @col = 'ProvinceCode'
End

If @iSortCol_0 = 3
Begin
	Select @col = 'SGWS_Calendar_Year'
End

If @iSortCol_0 = 4
Begin
	Select @col = 'SGWS_Calendar_Period'
End

If @iSortCol_0 = 5
Begin
	Select @col = 'LiquorBoardPeriod'
End

If @iSortCol_0 = 6
Begin
	Select @col = 'StartDate'
End

If @iSortCol_0 = 7
Begin
	Select @col = 'EndDate'
End

If @iSortCol_0 = 8
Begin
	Select @col = 'IsSkuBased'
End

If @iSortCol_0 = 9
Begin
	Select @col = 'GID'
End

If @iSortCol_0 = 10
Begin
	Select @col = 'AlternateName'
End

If @iSortCol_0 = 11
Begin
	Select @col = 'ProgramTypeName'
End

If @iSortCol_0 = 12
Begin
	Select @col = 'ProgramType'
End

If @iSortCol_0 = 13
Begin
	Select @col = 'AboveTheLineBelowTheLineName'
End

If @iSortCol_0 = 14
Begin
	Select @col = 'Comment'
End

If @iSortCol_0 = 15
Begin
	Select @col = 'ProgramStatusCode'
End

If @iSortCol_0 = 16
Begin
	Select @col = 'TotalProgramSpend'
End

declare @iTotalRecords int = 0; 

Set @SQL = 'Select 
			@Total = Count(1)
			From (Select SP.Id				
			From dbo.Program P With(Nolock)
			Left Join dbo.SuperProgram SP With(Nolock) On P.SuperProgramId = SP.Id
			Left Join dbo.Program_ATL_BTL AB With(Nolock) On P.AboveTheLineBelowTheLine = AB.Id
			Left Join dbo.ProgramStatus PS With(Nolock) On P.ProgramStatusId = PS.Id
			Left Join dbo.ProgramType PT With(Nolock) On P.ProgramTypeId = PT.Id
			Left Join dbo.FiscalYearByLiquorBoard FY With(Nolock) On SP.FiscalYearByLiquorBoardId = FY.Id
			Left Join dbo.BusinessType BT With(Nolock) On SP.BusinessTypeId = BT.Id
			Left Join dbo.Province PV With(Nolock) On SP.ProvinceId = PV.Id
			Inner Join dbo.ProgramCost PC With(Nolock) On P.Id = PC.ProgramId
			Left Join dbo.Product PR With(Nolock) On SP.GID = PR.GID
			Left Join dbo.SGWSFiscal SF With(Nolock) On SP.SGWSFiscalId = SF.Id  ' 
			+ @sSearch + 
			') A '

Set @ParmDefinition = N'@Total int OUTPUT';			
EXECUTE sp_executesql @SQL,@ParmDefinition, @Total = @iTotalRecords OUTPUT

--Print (@SQL)

Set @SQL = 'Select distinct ' + Cast(@iTotalRecords As Varchar(100)) + ' TotalRecords
,SuperProgramId,SuperProgramName,ProvinceCode,Period,SGWS_Calendar_Period,SGWS_Calendar_Year,LiquorBoardPeriod
,StartDate,EndDate,IsSkuBased,GID,AlternateName,ProgramId,ProgramTypeName,ProgramType,AboveTheLineBelowTheLineName
,Comment,ProgramStatusCode,TotalProgramSpend
From
(
	Select ROW_NUMBER() OVER ( ORDER BY P.Id ) AS RowNum
		,SP.Id SuperProgramId
		,SP.SuperProgramName
		,PV.Code ProvinceCode
		,FY.Period
		,SF.Period SGWS_Calendar_Period
		,SF.Year SGWS_Calendar_Year
		,FY.Period As LiquorBoardPeriod		
		,FY.StartDate
		,FY.EndDate
		,Isnull(SP.IsSkuBased,0) As IsSkuBased
		,SP.GID
		,PR.AlternateName
		,P.Id As ProgramId
		,P.ProgramTypeName
		,PT.ProgramType
		,AB.[Name] As AboveTheLineBelowTheLineName
		,P.Comment
		,PS.Code As ProgramStatusCode
		,PC.TotalProgramSpend
	From dbo.Program P With(Nolock)
	Left Join dbo.SuperProgram SP With(Nolock) On P.SuperProgramId = SP.Id
	Left Join dbo.Program_ATL_BTL AB With(Nolock) On P.AboveTheLineBelowTheLine = AB.Id
	Left Join dbo.ProgramStatus PS With(Nolock) On P.ProgramStatusId = PS.Id
	Left Join dbo.ProgramType PT With(Nolock) On P.ProgramTypeId = PT.Id
	Left Join dbo.FiscalYearByLiquorBoard FY With(Nolock) On SP.FiscalYearByLiquorBoardId = FY.Id
	Left Join dbo.BusinessType BT With(Nolock) On SP.BusinessTypeId = BT.Id
	Left Join dbo.Province PV With(Nolock) On SP.ProvinceId = PV.Id
	Inner Join dbo.ProgramCost PC With(Nolock) On P.Id = PC.ProgramId
	Left Join dbo.Product PR With(Nolock) On SP.GID = PR.GID
	Left Join dbo.SGWSFiscal SF With(Nolock) On SP.SGWSFiscalId = SF.Id 	
	' 	
	+ @sSearch + 
	'	
) A Where A.RowNum >= ' + Cast((@iDisplayStart + 1) As Varchar(100)) + ' And A.RowNum <= ' + Cast((@iDisplayStart + @iDisplayLength) As Varchar(100)) + 
' Order By ' + @col + ' ' + @sSortDir_0

--Print(@sql)
exec( @sql)

end




