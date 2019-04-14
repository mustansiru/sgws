CREATE proc [dbo].[GetProgramDropdowns]
As
Begin
	select Id,BusinessType from BusinessType where IsActive=1
	select ID,Province from Province
	select Year from SGWSFiscal group by Year
	select top 13 Period from SGWSFiscal --group by Period
	select Id,Name from ProgramSKU_BrandBased
	select Id,ProgramType from programtype where IsActive=1
	select Id,Name from Program_ATL_BTL
	select Id,Code from ProgramStatus

	select Id,BrandName from Brand order by BrandName
	select GID from Product group by GID order by GID
	select Id,SupplierName from Supplier where Active=1 
	group by Id,SupplierName

	--select P.GID,P.AlternateName as ProductDescription,ContainerVolume as Size,Containers_Selling_Unit as UnitsPerPk,
	--Selling_Units_Case as Units, P.ProductName
	--from [dbo].Product P
	--inner join ProductDetails PD on PD.GID=P.GID
	--group by P.GID,P.AlternateName ,ContainerVolume,Containers_Selling_Unit,Selling_Units_Case, P.ProductName
	select GID as Id,AlternateName as Value from Product group by GID,AlternateName
End
