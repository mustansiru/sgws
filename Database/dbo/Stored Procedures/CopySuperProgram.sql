CREATE proc [dbo].[CopySuperProgram] --61
(
	@SuperProgramId bigint=0
)
As
Begin
	declare @NewSuperProgramId bigint=0

	--add in super program
	insert into SuperProgram (SuperProgramName, SGWSFiscalId, StartDate, EndDate, FiscalYearByLiquorBoardId, GID, IsSkuBased, IsBrandBased, ProvinceId, BusinessTypeId,IsOverrideDate)
	select null, null, null, null, null, GID, IsSkuBased, IsBrandBased, ProvinceId, BusinessTypeId,IsOverrideDate
	from SuperProgram where Id=@SuperProgramId
	
	set @NewSuperProgramId=@@IDENTITY;
	--print(@NewSuperProgramId)
	
	--add in program and programcost

	DECLARE @Id bigint
	DECLARE @NewProgramId bigint=0
	DECLARE cur_program CURSOR
	STATIC FOR 
	SELECT Id--,ProgramTypeName,Comment,ProgramStatusId,AboveTheLineBelowTheLine,GETDATE(),ProgramTypeId
	from Program where SuperProgramId=@SuperProgramId
	OPEN cur_program
	IF @@CURSOR_ROWS > 0
	 BEGIN 
	 FETCH NEXT FROM cur_program INTO @Id
	 WHILE @@Fetch_status = 0
	 BEGIN

		--add in program
		insert into Program (SuperProgramId,ProgramTypeName,Comment,ProgramStatusId,AboveTheLineBelowTheLine,CreatedDate,ProgramTypeId)
		--output inserted.Id
		select @NewSuperProgramId,ProgramTypeName,Comment,ProgramStatusId,AboveTheLineBelowTheLine,GETDATE(),ProgramTypeId
		from Program where Id=@Id

		set @NewProgramId=@@IDENTITY

		--add in programcost
		insert into ProgramCost (ProgramId, Depth, ForecastCaseSalesBase, ForecastCaseSalesLift, ForecastTotalCaseSalesPhysCs, 
		ForecastTotalCaseSales9LCsConverted, VariableCostPerCase, UpforntFees_LTO_BAM, RedemptionBAM, SpendQuantity, SpendPerQuantity, 
		OtherFixedCost,TotalProgramSpend)
		select @NewProgramId, Depth, ForecastCaseSalesBase, ForecastCaseSalesLift, ForecastTotalCaseSalesPhysCs, 
		ForecastTotalCaseSales9LCsConverted, VariableCostPerCase, UpforntFees_LTO_BAM, RedemptionBAM, SpendQuantity, SpendPerQuantity, 
		OtherFixedCost,TotalProgramSpend 
		from ProgramCost 
		where ProgramId = @Id

	 FETCH NEXT FROM cur_program INTO @Id
	 END
	END
	CLOSE cur_program
	DEALLOCATE cur_program

	--select  @NewSuperProgramId as SuperProgramId

	select S.ID as SuperProgramId, S.SuperProgramName,S.SGWSFiscalId,convert(varchar, S.StartDate, 101) as StartDate,convert(varchar, S.EndDate, 101) as EndDate,S.FiscalYearByLiquorBoardId,
	S.GID,S.IsSkuBased,S.IsBrandBased,S.ProvinceId,S.BusinessTypeId,S.IsOverrideDate ,Prod.SupplierId,Prod.BrandId,Prod.AlternateName
	--,SGWS.Period as SGWSPeriod,SGWS.Year as SGWSYear,F.Period as LiquorBoardPPeriod
	from SuperProgram S 
	inner join Product Prod on Prod.GID = S.GID
	--inner join SGWSFiscal SGWS on SGWS.Id=S.SGWSFiscalId
	--inner join FiscalYearByLiquorBoard F on F.Id=S.FiscalYearByLiquorBoardId
	where S.Id=@NewSuperProgramId

	select P.Id as ProgramId,T.ProgramType,P.ProgramTypeName,A.Name as ATL_BTL,P.Comment--,S.Code as ProgramStatus
	from Program P 
	inner join ProgramType T on T.Id=P.ProgramTypeId
	inner join Program_ATL_BTL A on A.Id=P.AboveTheLineBelowTheLine
	--inner join ProgramStatus S on S.Id=P.ProgramStatusId
	where P.SuperProgramId= @NewSuperProgramId


	----add in program
	--insert into Program (SuperProgramId,ProgramTypeName,Comment,ProgramStatusId,AboveTheLineBelowTheLine,CreatedDate,ProgramTypeId)
	--output inserted.Id
	--select @NewSuperProgramId,ProgramTypeName,Comment,ProgramStatusId,AboveTheLineBelowTheLine,GETDATE(),ProgramTypeId
	--from Program where SuperProgramId=@SuperProgramId

	--insert into ProgramCost (ProgramId, Depth, ForecastCaseSalesBase, ForecastCaseSalesLift, ForecastTotalCaseSalesPhysCs, 
	--ForecastTotalCaseSales9LCsConverted, VariableCostPerCase, UpforntFees_LTO_BAM, RedemptionBAM, SpendQuantity, SpendPerQuantity, 
	--OtherFixedCost,TotalProgramSpend)
	--select ProgramId, Depth, ForecastCaseSalesBase, ForecastCaseSalesLift, ForecastTotalCaseSalesPhysCs, 
	--ForecastTotalCaseSales9LCsConverted, VariableCostPerCase, UpforntFees_LTO_BAM, RedemptionBAM, SpendQuantity, SpendPerQuantity, 
	--OtherFixedCost,TotalProgramSpend 
	--from ProgramCost C inner join Program P 
	--where ProgramId in (select Id from Program where SuperProgramId=@SuperProgramId)

	
End
