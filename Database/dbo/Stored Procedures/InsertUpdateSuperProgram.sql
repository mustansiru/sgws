CREATE proc [dbo].[InsertUpdateSuperProgram]
(
	@SuperProgramId bigint =0,
	@ProvinceId bigint =0,
	@BusinessTypeId int =0,
	@SuperProgramName varchar(200)=null,
	@SGWSFiscalYear bigint =0,
	@SGWSFiscalPeriod varchar(50) =null,
	@StartDate datetime =null,
	@EndDate datetime =null,
	@FiscalYearByLiquorBoardId bigint =0,
	@GID varchar(50)=null,
	@IsSkuBased bit=0,
	@IsBrandBased bit=0,
	@IsOverrideDate bit=0
)
As
Begin

	declare @_SuperProgramId bigint=0
	declare @_SGWSFiscalId bigint=0
	set @_SGWSFiscalId = (select Id from SGWSFiscal where Year=@SGWSFiscalYear and Period=@SGWSFiscalPeriod)

	if(@SuperProgramId>0) 
	begin
		update SuperProgram set SuperProgramName=@SuperProgramName, SGWSFiscalId=@_SGWSFiscalId, StartDate=@StartDate, EndDate=@EndDate, FiscalYearByLiquorBoardId=@FiscalYearByLiquorBoardId, 
		GID=@GID, IsSkuBased=@IsSkuBased, IsBrandBased=@IsBrandBased, ProvinceId=@ProvinceId, BusinessTypeId=@BusinessTypeId,
		IsOverrideDate=@IsOverrideDate
		where Id=@SuperProgramId	

		set @_SuperProgramId=@SuperProgramId
	end
	else
	begin
		
		insert into SuperProgram (SuperProgramName,SGWSFiscalId, StartDate, EndDate, FiscalYearByLiquorBoardId, GID, IsSkuBased, 
		IsBrandBased, ProvinceId, BusinessTypeId,IsOverrideDate)
		--output inserted.Id
		values (@SuperProgramName,@_SGWSFiscalId,@StartDate,@EndDate,@FiscalYearByLiquorBoardId,@GID,@IsSkuBased,
		@IsBrandBased,@ProvinceId,@BusinessTypeId,@IsOverrideDate)
		
		set @_SuperProgramId=@@IDENTITY;
	end
	select @_SuperProgramId as SuperProgramId
End
