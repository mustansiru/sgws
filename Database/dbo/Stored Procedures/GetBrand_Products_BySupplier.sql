Create proc [dbo].[GetBrand_Products_BySupplier]-- 1
(
	@SupplierId bigint=0
)
As
Begin
		
	if(@SupplierId>0)
	begin
		select B.Id,BrandName as Value from Brand B 
		inner join Supplier S on S.SupplierCode=B.SupplierCode and S.Id=@SupplierId
		where Active=1 
		group by B.Id,BrandName


		select GID as Id,AlternateName as Value from Product where SupplierId=@SupplierId 
		group by GID,AlternateName order by AlternateName
	end
	
	--select GID,ProductName from Product group by GID,ProductName
End
