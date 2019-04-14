CREATE proc [dbo].[GetProgramDetailsByProgramId] --98
(
	@ProgramId bigint =0
)
As
Begin
	select P.*,PC.*,
	S.SuperProgramName,S.SGWSFiscalId,convert(varchar, S.StartDate, 101) as StartDate,convert(varchar, S.EndDate, 101) as EndDate,S.FiscalYearByLiquorBoardId,
	S.GID,S.IsSkuBased,S.IsBrandBased,S.ProvinceId,S.BusinessTypeId,S.IsOverrideDate,F.Period as LiquorBoardPPeriod
	,SGWS.Period as SGWSPeriod,SGWS.Year as SGWSYear,Prod.SupplierId,Prod.BrandId,Prod.AlternateName
	from Program P 
	inner join ProgramCost PC on PC.ProgramId=P.Id
	inner join SuperProgram S on S.Id=P.SuperprogramId
	inner join SGWSFiscal SGWS on SGWS.Id=S.SGWSFiscalId
	inner join Product Prod on Prod.GID = S.GID
	inner join FiscalYearByLiquorBoard F on F.Id=S.FiscalYearByLiquorBoardId
	where P.Id=@ProgramId

	select P.Id as ProgramId,T.ProgramType,P.ProgramTypeName,A.Name as ATL_BTL,S.Code as ProgramStatus
	from Program P 
	inner join ProgramType T on T.Id=P.ProgramTypeId
	inner join Program_ATL_BTL A on A.Id=P.AboveTheLineBelowTheLine
	inner join ProgramStatus S on S.Id=P.ProgramStatusId
	where P.SuperProgramId= (select SuperProgramId from Program where Id=@ProgramId)
End
