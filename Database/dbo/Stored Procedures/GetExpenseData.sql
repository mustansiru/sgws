CREATE proc [dbo].[GetExpenseData] --2017,'2,4,6,9','1,2,3'
(
	@year int =0,
	@province varchar(50)=null,
	@suppliers varchar(100)=null,
	@UserId uniqueidentifier =null
)
As
Begin
--declare @IsSupplierPresent int =(select isnull(count(SupplierId),0) from UserSupplier where UserId=@UserId)
--declare @IsProvincePresent int =(select isnull(count(ProvinceId),0) from UserProvince where UserId=@UserId)
declare @sqlQuery varchar(8000)=''

set @sqlQuery=
	'select E.Id,[Record], FORMAT([Date],''MM-dd-yyyy'') as [Date],E.BrandId,E.SupplierId,E.ProvinceId, B.BrandName, 
	S.SupplierName,E.ProgramTypeId, PT.ProgramType, [Amount_Net], [Tax], [Total],
	[Month], P.Code as Province, [Vendor], [InvoiceNo], [InvoiceDescription], [RemyClassification], [Patron_GL_Account], 
	(case when [Grant_Applicable]=1 then ''Yes'' else '''' end ) as [Grant_Applicable], 
	[Supplier_Coding], [Bill_Back], [IsA_P], [IsStructure], [Employee],E.SupplierVendorName
	from Expense E 
	left outer  join Brand B on B.Id=E.BrandId 
	left outer join ProgramType PT on PT.id=E.ProgramTypeId '
	--if(@IsSupplierPresent >0 and @IsProvincePresent >0)
	--begin
		if(@province is not null and @province <> '')
		begin
			set @sqlQuery += ' inner join Province P on P.Id=E.ProvinceId and E.ProvinceId in (Select Item from dbo.SplitString('''+@province+''','','')) '
						   --inner join UserProvince up on P.Id=up.ProvinceId and up.ProvinceId in (Select Item from dbo.SplitString('''+@province+''','',''))'
		end
		else
		begin
			set @sqlQuery += ' left outer join Province P on P.Id=E.ProvinceId '
						   --inner join UserProvince up on P.Id=up.ProvinceId '
		end
		if(@suppliers is not null and @suppliers <> '')
		begin
			set @sqlQuery += ' inner Join (select Id,LegalName,SupplierName from dbo.Supplier where Id  
			in (Select Item from dbo.SplitString('''+@suppliers+''','','')) group by Id,LegalName,SupplierName) S On S.Id=E.SupplierId '
			--inner join UserSupplier us on us.SupplierId=s.Id and us.SupplierId in (Select Item from dbo.SplitString('''+@suppliers+''','',''))'
		end
		else
		begin
			set @sqlQuery += ' left outer Join (select Id,LegalName,SupplierName from dbo.Supplier group by Id,LegalName,SupplierName) S On S.Id=E.SupplierId '
						   --inner join UserSupplier us on us.SupplierId=s.Id '
		end
	--end
	--else if(@IsSupplierPresent > 0 and @IsProvincePresent =0)
	--begin
		--set @sqlQuery += ' left join Province P on P.Id=E.ProvinceId '

		--if(@suppliers is not null and @suppliers <> '')
		--begin
		--	set @sqlQuery += ' inner Join (select Id,LegalName,SupplierName from dbo.Supplier where Id  
		--	in (Select Item from dbo.SplitString('''+@suppliers+''','','')) group by Id,LegalName,SupplierName) S On S.Id=E.SupplierId '
		--	--inner join UserSupplier us on us.SupplierId=s.Id and us.SupplierId in (Select Item from dbo.SplitString('''+@suppliers+''','',''))'
		--end
		--else
		--begin
		--	set @sqlQuery += ' inner Join (select Id,LegalName,SupplierName from dbo.Supplier group by Id,LegalName,SupplierName) S On S.Id=E.SupplierId '
		--				   --inner join UserSupplier us on us.SupplierId=s.Id '
		--end				    
	--end
	

	--if(@province is not null and @province <> '')
	--begin
	--	set @sqlQuery += ' and E.ProvinceId in (Select Item from dbo.SplitString('''+@province+''','',''))'
	--end
	
	--if(@suppliers is not null and @suppliers <> '')
	--begin
	--	set @sqlQuery +=' left Join (select Id,LegalName,SupplierName from  dbo.Supplier where Id  
	--	in (Select Item from dbo.SplitString('''+@suppliers+''','','')) group by Id,LegalName,SupplierName) S On S.Id=E.SupplierId ' 
	--end
	--else
	--begin
	--	set @sqlQuery += 'left Join (select Id,LegalName,SupplierName from dbo.Supplier group by Id,LegalName,SupplierName) S On S.Id=E.SupplierId ' 		
	--end

	set @sqlQuery += ' where FORMAT([date],''yyyy'') = '+Convert(varchar(5),@year)
	
		if(@province is not null and @province <> '')
		begin
			set @sqlQuery += ' and E.ProvinceId in (Select Item from dbo.SplitString('''+@province+''','',''))'
		end
		if(@suppliers is not null and @suppliers <> '')
		begin
			set @sqlQuery +=' and E.SupplierId  in (Select Item from dbo.SplitString('''+@suppliers+''','',''))'
		end

	print @sqlQuery
	execute(@sqlQuery)

		--select E.Id,[Record], FORMAT([Date],'MM-dd-yyyy') as [Date],E.BrandId,E.SupplierId,E.ProvinceId, B.BrandName, 
		--S.SupplierName,E.ProgramTypeId, PT.ProgramType, [Amount_Net], [Tax], [Total],
		-- [Month], P.Code as Province, [Vendor], [InvoiceNo], [InvoiceDescription], [RemyClassification], [Patron_GL_Account], 
		-- (case when [Grant_Applicable]=1 then 'Yes' else '' end ) as [Grant_Applicable], 
		-- [Supplier_Coding], [Bill_Back], [IsA_P], [IsStructure], [Employee],E.SupplierVendorName,E.ExpenseType
		--from Expense E 
		--left Join (select Id,LegalName,SupplierName from  dbo.Supplier  group by Id,LegalName,SupplierName) S On S.Id=E.SupplierId 		
		--left outer  join Brand B on B.Id=E.BrandId
		--left outer join ProgramType PT on PT.id=E.ProgramTypeId
		--left outer join Province P on P.Id=E.ProvinceId
		--where FORMAT([date],'yyyy') = @year
		---- order by Record

end
