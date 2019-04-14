create proc [dbo].[GetProductDetailsBy_GID_Province] --6,0,'',6,43,'100',1
(
	@GID varchar(200)=null,
	@ProvinceId bigint =0
)
As
Begin
	select P.GID,Category,SupplierName,BrandName,P.AlternateName as ProductDescription,ContainerVolume as Size,Containers_Selling_Unit as UnitsPerPk,
	Selling_Units_Case as Units, CSPC_Code
	from [dbo].Product P
	inner join ProductDetails PD on PD.GID=P.GID
	inner join Category C on C.Id=P.CategoryId
	inner join Supplier Sp on Sp.Id=P.SupplierId
	inner join Brand B on B.Id=P.BrandId
	inner join [CSPC_ACD] CSPC on CSPC.GID=P.GID and CSPC.ProvinceId=@ProvinceId
	where P.GID=@GID and CSPC.ProvinceId=@ProvinceId
	
	
End
