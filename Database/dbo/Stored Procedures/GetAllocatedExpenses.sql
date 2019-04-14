CREATE proc [dbo].[GetAllocatedExpenses]-- 100
(
	@ProgramId bigint=0
)
As
Begin
	declare @Startdate date =null
	declare @Enddate date =null
	declare @ProvinceId bigint =null

	select @Startdate=FORMAT(S.StartDate,'MM-dd-yyyy'),@Enddate=FORMAT(S.EndDate,'MM-dd-yyyy'),@ProvinceId=S.ProvinceId
	from Program P
	inner join SuperProgram S on S.Id=P.SuperProgramId 
	where P.Id=@ProgramId
	print(@provinceId)

	--Program
	select P.Id,ProgramTypeName,Pr.Province,Pr.Code,SG.Year,SG.Period,convert(varchar, S.StartDate, 110) as StartDate,
	convert(varchar, S.EndDate, 110) as EndDate,S.GID,Prod.AlternateName,F.Period as LiquorBoardPeriod
	from Program P
	inner join SuperProgram S on S.Id=P.SuperProgramId 
	inner join Province Pr on Pr.Id=S.ProvinceId
	inner join SGWSFiscal SG on SG.Id=S.SGWSFiscalId
	inner join Product Prod on Prod.GID=S.GID
	inner join FiscalYearByLiquorBoard F on F.Id=S.FiscalYearByLiquorBoardId
	where P.Id=@ProgramId

	--allocated
	select E.Id as ExpenseId, E.Record,FORMAT([Date],'MM-dd-yyyy') as [Date], B.BrandName, S.LegalName as SupplierName,PT.ProgramType,
	[InvoiceNo], [InvoiceDescription],[Employee],P.Code
	from ProgramExpense PE 
	inner join Expense as E on Pe.ExpenseId=E.Id
	inner join Province P on P.Id=E.ProvinceId and P.Id=@ProvinceId
	left Join (select Id,LegalName from  dbo.Supplier  group by Id,LegalName) S On S.Id=E.SupplierId 		
	left outer  join Brand B on B.Id=E.BrandId
	left outer join ProgramType PT on PT.id=E.ProgramTypeId
	where PE.ProgramId=@ProgramId and FORMAT([Date],'MM-dd-yyyy') >= @Startdate and FORMAT([Date],'MM-dd-yyyy') <= @Enddate


	--Not Allocated
	select E.Id as ExpenseId,E.Record,FORMAT([Date],'MM-dd-yyyy') as [Date], B.BrandName, S.LegalName as SupplierName,PT.ProgramType,
	[InvoiceNo], [InvoiceDescription],[Employee],P.Code
	from Expense E
	inner join Province P on P.Id=E.ProvinceId and P.Id=@ProvinceId
	left Join (select Id,LegalName from  dbo.Supplier  group by Id,LegalName) S On S.Id=E.SupplierId 		
	left outer  join Brand B on B.Id=E.BrandId
	left outer join ProgramType PT on PT.id=E.ProgramTypeId
	where (FORMAT([Date],'MM-dd-yyyy') >= @Startdate and FORMAT([Date],'MM-dd-yyyy') <= @Enddate) and E.Id not in
	(select ExpenseId from ProgramExpense where ProgramId=@ProgramId)

End



