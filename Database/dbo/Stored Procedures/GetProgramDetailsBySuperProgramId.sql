CREATE proc [dbo].[GetProgramDetailsBySuperProgramId] --61
(
	@SuperProgramId bigint =0
)
As
Begin

	--select 
	--S.SuperProgramName,S.SGWSFiscalId,convert(varchar, S.StartDate, 101) as StartDate,convert(varchar, S.EndDate, 101) as EndDate,S.FiscalYearByLiquorBoardId,
	--S.GID,S.IsSkuBased,S.IsBrandBased,S.ProvinceId,S.BusinessTypeId,S.IsOverrideDate,F.Period as LiquorBoardPPeriod
	--,SGWS.Period as SGWSPeriod,SGWS.Year as SGWSYear,Prod.SupplierId,Prod.BrandId,Prod.AlternateName,
	--P.ProgramTypeName,P.SuperProgramId,P.Comment,P.ProgramStatusId,P.AboveTheLineBelowTheLine,P.ProgramTypeId,
	--PC.Depth,PC.ForecastCaseSalesBase,PC.ForecastCaseSalesLift,PC.ForecastTotalCaseSales9LCsConverted,PC.ForecastTotalCaseSalesPhysCs,PC.OtherFixedCost
	--,PC.ProgramId,PC.RedemptionBAM,PC.SpendPerQuantity,PC.SpendQuantity,PC.TotalProgramSpend,PC.UpforntFees_LTO_BAM,PC.VariableCostPerCase
	--from Program P 
	--inner join ProgramCost PC on PC.ProgramId=P.Id
	--inner join SuperProgram S on S.Id=P.SuperprogramId and S.Id=@SuperProgramId
	--inner join SGWSFiscal SGWS on SGWS.Id=S.SGWSFiscalId
	--inner join Product Prod on Prod.GID = S.GID
	--inner join FiscalYearByLiquorBoard F on F.Id=S.FiscalYearByLiquorBoardId
	--where P.SuperProgramId=@SuperProgramId

	
	select S.ID as SuperProgramId, S.SuperProgramName,S.SGWSFiscalId,convert(varchar, S.StartDate, 101) as StartDate,convert(varchar, S.EndDate, 101) as EndDate,S.FiscalYearByLiquorBoardId,
	S.GID,S.IsSkuBased,S.IsBrandBased,S.ProvinceId,S.BusinessTypeId,S.IsOverrideDate --, P.*,PC.*
	,SGWS.Period as SGWSPeriod,SGWS.Year as SGWSYear,Prod.SupplierId,Prod.BrandId,Prod.AlternateName,F.Period as LiquorBoardPPeriod

	--TotalProgramSpend
	--(PC.Depth+PC.ForecastCaseSalesBase+PC.ForecastCaseSalesLift+PC.ForecastTotalCaseSalesPhysCs+PC.ForecastTotalCaseSales9LCsConverted+PC.VariableCostPerCase+
	--PC.UpforntFees_LTO_BAM+PC. RedemptionBAM+PC. SpendQuantity+PC. SpendPerQuantity+PC. OtherFixedCost) as TotalProgramSpend
	from --Program P inner join 
	SuperProgram S --on S.Id=P.SuperProgramId
	inner join Product Prod on Prod.GID = S.GID
	--inner join ProgramCost PC on PC.ProgramId=P.Id
	inner join SGWSFiscal SGWS on SGWS.Id=S.SGWSFiscalId
	inner join FiscalYearByLiquorBoard F on F.Id=S.FiscalYearByLiquorBoardId
	where S.Id=@SuperProgramId
	--order by P.Id desc

	--select P.Id as ProgramId, P.ProgramTypeName,PT.ProgramType,AB.Name as ATL_BTL,S.Code as ProgramStatus,P.Comment
	--,PC.Depth,Pc.ForecastCaseSalesBase,Pc.ForecastCaseSalesLift,Pc.ForecastTotalCaseSalesPhysCs,Pc.ForecastTotalCaseSales9LCsConverted
	--,PC.VariableCostPerCase,Pc.UpforntFees_LTO_BAM,Pc.RedemptionBAM,Pc.SpendQuantity,PC.SpendPerQuantity,PC.OtherFixedCost,
	--PC.TotalProgramSpend
	--from Program P inner join ProgramType PT on PT.Id=P.ProgramTypeId 
	--inner join ProgramStatus S on S.id =P.ProgramStatusId 
	--inner join ProgramCost PC on PC.ProgramId=P.Id
	--left outer join Program_ATL_BTL AB on AB.Id=P.AboveTheLineBelowTheLine
	--where SuperProgramId=@SuperProgramId


	select P.Id as ProgramId,T.ProgramType,P.ProgramTypeName,A.Name as ATL_BTL,P.Comment--,S.Code as ProgramStatus
	from Program P 
	inner join ProgramType T on T.Id=P.ProgramTypeId
	inner join Program_ATL_BTL A on A.Id=P.AboveTheLineBelowTheLine
	--inner join ProgramStatus S on S.Id=P.ProgramStatusId
	where P.SuperProgramId= @SuperProgramId
	 
End
