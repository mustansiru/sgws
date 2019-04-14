CREATE proc [dbo].[GetGID]  --'2',0,'0','RumChata Coffee Vap 6x1x750',1
(
	@SupplierCode varchar(10)=null, --its supplierid
	@Brand bigint =0,
	@SGID varchar(10)=null,
	@ProductName varchar(100)=null,
	@ProvinceId bigint =0
)
As
Begin
declare @sqlQuery varchar(max)=''
declare @sqlWhere varchar(max)=''
--Category,CSPC_Code, inner join Category C on C.Id=P.CategoryId
set @sqlQuery='
	select P.GID,SupplierName,BrandName,P.AlternateName as ProductDescription,ContainerVolume as Size,Containers_Selling_Unit as UnitsPerPk,
	Selling_Units_Case as Units, P.ProductName
	from [dbo].Product P
	inner join ProductDetails PD on PD.GID=P.GID
	
	inner join Supplier Sp on Sp.Id=P.SupplierId
	inner join Brand B on B.Id=P.BrandId
	inner join [CSPC_ACD] CSPC on CSPC.GID=P.GID '
	
	if(@ProvinceId >0)
	begin
		set @sqlQuery=@sqlQuery+' and CSPC.ProvinceId='+Convert(varchar(50),@ProvinceId)

		if(@sqlWhere ='')
		begin
			set @sqlWhere=' where CSPC.ProvinceId='+Convert(varchar(50),@ProvinceId)
		end
		else
		begin
			set @sqlWhere=@sqlWhere+' and CSPC.ProvinceId='+Convert(varchar(50),@ProvinceId)
		end
	end

	if(@SupplierCode <>'0')
	begin
		if(@sqlWhere ='')
		begin
			set @sqlWhere=' where SupplierId ='+Convert(varchar(50),@SupplierCode) --+')' --(select Id from Supplier where SupplierCode=
		end
		else
		begin
			set @sqlWhere=@sqlWhere+' and SupplierId ='+Convert(varchar(50),@SupplierCode) --+')' --select Id from Supplier where SupplierCode=
		end
	end

	if(@Brand >0)
	begin
		if(@sqlWhere ='')
		begin
			set @sqlWhere=' where B.Id='+Convert(varchar(50),@Brand)
		end
		else
		begin
			set @sqlWhere=@sqlWhere+' and B.Id='+Convert(varchar(50),@Brand)
		end
	end
	
	if(@SGID <> '0')
	begin
		if(@sqlWhere ='')
		begin
			set @sqlWhere=' where P.GID='+Convert(varchar(50),@SGID)
		end
		else
		begin
			set @sqlWhere=@sqlWhere+' and P.GID='''+Convert(varchar(50),@SGID)+''''
		end
	end
	
	--if(@ProductName <> '' and @ProductName <> '0')
	--begin
	--	if(@sqlWhere ='')
	--	begin
	--		set @sqlWhere=' where P.AlternateName ='''+Convert(varchar(100),@ProductName)+ '''' --'%''' --like ''%'+Convert(varchar(100),@ProductName)+'%'''
	--	end
	--	else
	--	begin
	--		set @sqlWhere=@sqlWhere+' and P.AlternateName ='''+Convert(varchar(100),@ProductName)+ ''''
	--	end
	--end
	

	set @sqlQuery = @sqlQuery+@sqlWhere

	print(@sqlQuery)
	execute(@sqlQuery)
End
