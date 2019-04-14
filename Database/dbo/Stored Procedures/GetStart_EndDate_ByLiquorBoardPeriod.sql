CREATE proc [dbo].[GetStart_EndDate_ByLiquorBoardPeriod] --14,'P1'
(
	@Id bigint =0,
	@Period varchar(50)=0
)
As 
Begin
	
	select top 1 convert(varchar, StartDate, 101) as StartDate,convert(varchar, EndDate, 101) as EndDate from [FiscalYearByLiquorBoard] 
	where Id=@Id --and Period=@Period
End
