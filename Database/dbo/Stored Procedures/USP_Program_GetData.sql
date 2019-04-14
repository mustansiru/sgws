CREATE proc [dbo].[USP_Program_GetData] --10, 0, 0, 'asc','ON','57BFBECF-5E6F-41DC-B5D5-6599AD5B4DEB' 
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
	Select @sSearch = '  SP.SuperProgramName like ''%' +  @sSearch + '%'''
							+ ' Or FY.Period like ''%' + @sSearch + '%'''
							+ ' Or PV.Code like ''%' + @sSearch + '%'''
							+ @Is_SKU_Brand
							+ ' Or CONVERT(VARCHAR(8), FY.StartDate, 112) like ''%' + @sSearch + '%'''
							+ ' Or CONVERT(VARCHAR(8), FY.EndDate, 112) like ''%' + @sSearch + '%'''
							+ ' Or SP.GID like ''%' + @sSearch + '%'''
							+ ' Or PR.AlternateName like ''%' + @sSearch + '%'''
							+ ' Or SF.Period like ''%' + @sSearch + '%'''
							+ ' Or SF.Year like ''%' + @sSearch + '%'''
	Select @sSearch = ' Where 1=1 And ' + @sSearch	
	
End


Select @iSortCol_0 = @iSortCol_0  - 2
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

declare @iTotalRecords int = 0; 

Set @SQL = 'Select 
			@Total = Count(1)
			From (Select SP.Id
			From	
			dbo.SuperProgram SP With(Nolock) 
			Left Join dbo.SGWSFiscal SF With(Nolock) On SP.SGWSFiscalId = SF.Id
			Left Join dbo.FiscalYearByLiquorBoard FY With(Nolock) On SP.FiscalYearByLiquorBoardId = FY.Id
			Left Join dbo.Province PV With(Nolock) On SP.ProvinceId = PV.Id	
			Left Join dbo.Product PR With(Nolock) On SP.GID = PR.GID ' 
			+ @sSearch + 
			' Group By SP.Id) A '
--Print(@SQL)
Set @ParmDefinition = N'@Total int OUTPUT';			
EXECUTE sp_executesql @SQL,@ParmDefinition, @Total = @iTotalRecords OUTPUT

Set @SQL = 'Select distinct ' + Cast(@iTotalRecords As Varchar(100)) + ' TotalRecords
			,ProvinceCode,Period,StartDate,EndDate,IsSkuBased,GID,AlternateName,SGWS_Calendar_Period,SGWS_Calendar_Year			
			,LiquorBoardPeriod,SuperProgramId,SuperProgramName,IsAccess
From
(
	Select ROW_NUMBER() OVER ( ORDER BY SP.Id ) AS RowNum		
		,PV.Code ProvinceCode		
		,FY.Period		
		,FY.StartDate
		,FY.EndDate
		,Isnull(SP.IsSkuBased,0) As IsSkuBased		
		,SP.GID
		,PR.AlternateName		
		,SF.Period SGWS_Calendar_Period
		,SF.Year SGWS_Calendar_Year
		,FY.Period As LiquorBoardPeriod
		,SP.Id SuperProgramId		
		,SP.SuperProgramName
		,dbo.CheckUserProgramPermission( ''' + Cast(@LoggedInUser As Varchar(100)) + ''',SP.Id)	IsAccess
	From dbo.SuperProgram SP With(Nolock)	
	Left Join dbo.FiscalYearByLiquorBoard FY With(Nolock) On SP.FiscalYearByLiquorBoardId = FY.Id
	Left Join dbo.BusinessType BT With(Nolock) On SP.BusinessTypeId = BT.Id
	Left Join dbo.Province PV With(Nolock) On SP.ProvinceId = PV.Id	
	Left Join dbo.Product PR With(Nolock) On SP.GID = PR.GID
	Left Join dbo.SGWSFiscal SF With(Nolock) On SP.SGWSFiscalId = SF.Id 
	' + @sSearch + 
	'	
) A Where A.RowNum >= ' + Cast((@iDisplayStart + 1) As Varchar(100)) + 
' And A.RowNum <= ' + Cast((@iDisplayStart + @iDisplayLength) As Varchar(100)) + 
' Order By ' + @col + ' ' + @sSortDir_0

--Print(@sql)
exec( @sql)

end


