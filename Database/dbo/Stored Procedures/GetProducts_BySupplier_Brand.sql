Create proc [dbo].[GetProducts_BySupplier_Brand] --1,225
(
	@SupplierId bigint=0,
	@BrandId bigint=0
)
As
Begin
--declare @suppliercode varchar(20)=null

--	set @suppliercode = (select SupplierCode from Supplier where Id=@supplierId)
	if(@SupplierId >0 and @BrandId >0)
	begin
		select GID as Id,AlternateName as Value from Product 
		where SupplierId=@SupplierId and BrandId=@BrandId --SupplierCode=@suppliercode
		group by GID,AlternateName order by AlternateName
	end
	else if(@SupplierId >0)
	begin
		select GID as Id,AlternateName--ProductName + ' ('+GID+')' 
		as Value from Product 
		where SupplierId=@SupplierId 
		group by GID,AlternateName order by AlternateName
	end
	else if(@BrandId >0)
	begin
		select GID as Id,AlternateName as Value from Product 
		where BrandId=@BrandId 
		group by GID,AlternateName order by AlternateName
	end
	
End
