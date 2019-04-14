
CREATE proc [dbo].[GetBAMCostAndProductByProgram] --102
(
	@ProgramId bigint =0
)
As
Begin
	declare @SuperProgramId bigint=0
	select @SuperProgramId=SuperProgramId from Program where Id=@ProgramId

	select BAMCost from [dbo].[Province_BAMCost] where ProvinceId=(select ProvinceId from SuperProgram where Id=@SuperProgramId)

	select S.ProvinceId,PD.ContainerVolume as Size,Containers_Selling_Unit as UnitsPerPk,
	Selling_Units_Case as Units
	from SuperProgram S 
	inner join Program P on P.SuperProgramId=S.Id and P.Id=@ProgramId
	left outer join ProductDetails PD on PD.GID=S.GID
	where P.Id=@ProgramId
End
