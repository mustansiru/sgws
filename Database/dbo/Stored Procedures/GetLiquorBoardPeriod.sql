CREATE proc [dbo].[GetLiquorBoardPeriod] --2017,'P01',1
(
	@year int =0,
	@period varchar(10)=null,
	@ProvinceId bigint=0
)
As 
Begin
	declare @_LiquorBoardId bigint =0
	declare @_SGWSFiscalId bigint =(select Id from SGWSFiscal where year=@year and Period=@period)

	select @_LiquorBoardId=Id from LiquorBoard where ProvinceId=@ProvinceId

	--print(@_LiquorBoardId)
	--print @_SGWSFiscalId
	select Id as FiscalYearByLiquorBoardId, Period,convert(varchar, StartDate, 101) as StartDate,convert(varchar, EndDate, 101) as EndDate  
	from FiscalYearByLiquorBoard where year=@year and SGWSFiscalId=@_SGWSFiscalId and LiquorBoardId=@_LiquorBoardId

	--select Id as FiscalYearByLiquorBoardId, Period,convert(varchar, StartDate, 101) as StartDate,convert(varchar, EndDate, 101) as EndDate 
	--from [FiscalYearByLiquorBoard] where LiquorBoardId=@_LiquorBoardId and Year=@year and 
	--Period=('P'+convert(varchar(50),convert(int,replace(@period,'P',''))))
	
End




