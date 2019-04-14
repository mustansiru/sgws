

CREATE View [dbo].[vw_TMP_ProductInfo_GetErrorData]
As
Select * From 
(
	Select Id,try_parse(dbo.GetNumbers(SubCategoryCode)As Bigint)ParseValue
		   ,SubCategoryCode CValue
		   ,GlazersProductCode
		   ,'Subcategory Code' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(BrandCode,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(BrandCode)As Bigint)ParseValue
		   ,BrandCode CValue
		   ,GlazersProductCode
		   ,'Brand Code' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(BrandCode,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(SupplierCode)As Bigint)ParseValue
		   ,SupplierCode CValue
		   ,GlazersProductCode
		   ,'Supplier Code' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(SupplierCode,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(ItemCode)As Bigint)ParseValue
		   ,ItemCode CValue
		   ,GlazersProductCode
		   ,'Item Code' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(ItemCode,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(ABV_Per)As decimal(10,4))ParseValue
		   ,ABV_Per CValue
		   ,GlazersProductCode
		   ,'ABV%' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(ABV_Per,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(ContainerVolume)As bigint)ParseValue
		   ,ContainerVolume CValue
		   ,GlazersProductCode
		   ,'Container Volume' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(ContainerVolume,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Containers_Selling_Unit)As bigint)ParseValue
		   ,Containers_Selling_Unit CValue
		   ,GlazersProductCode
		   ,'Containers/Selling Unit' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Containers_Selling_Unit,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Selling_Units_Case)As bigint)ParseValue
		   ,Selling_Units_Case CValue
		   ,GlazersProductCode
		   ,'Selling Units/Case' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Selling_Units_Case,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Closure_Weight)As decimal(10,4))ParseValue
		   ,Closure_Weight CValue
		   ,GlazersProductCode
		   ,'Closure Weight' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Closure_Weight,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Bottle_Weight)As decimal(10,4))ParseValue
		   ,Bottle_Weight CValue
		   ,GlazersProductCode
		   ,'Bottle Weight' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Bottle_Weight,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Bottle_Height)As decimal(10,4))ParseValue
		   ,Bottle_Height CValue
		   ,GlazersProductCode
		   ,'Bottle Height' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Bottle_Height,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Bottle_Length)As decimal(10,4))ParseValue
		   ,Bottle_Length CValue
		   ,GlazersProductCode
		   ,'Bottle Length' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Bottle_Length,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Bottle_Width)As decimal(10,4))ParseValue
		   ,Bottle_Width CValue
		   ,GlazersProductCode
		   ,'Bottle Width' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Bottle_Width,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Empty_Bottle_Weight)As decimal(10,4))ParseValue
		   ,Empty_Bottle_Weight CValue
		   ,GlazersProductCode
		   ,'Empty Bottle Weight' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Empty_Bottle_Weight,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Lead_Time)As bigint)ParseValue
		   ,Lead_Time CValue
		   ,GlazersProductCode
		   ,'Lead Time(Days)' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Lead_Time,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Case_Height)As decimal(10,4))ParseValue
		   ,Case_Height CValue
		   ,GlazersProductCode
		   ,'Case Height' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Case_Height,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Case_Length)As decimal(10,4))ParseValue
		   ,Case_Length CValue
		   ,GlazersProductCode
		   ,'Case Length' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Case_Length,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Case_Weight)As decimal(10,4))ParseValue
		   ,Case_Weight CValue
		   ,GlazersProductCode
		   ,'Case Weight' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Case_Width,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Case_Width)As decimal(10,4))ParseValue
		   ,Case_Width CValue
		   ,GlazersProductCode
		   ,'Case Width' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Case_Width,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Cases_Per_Pallet)As bigint)ParseValue
		   ,Cases_Per_Pallet CValue
		   ,GlazersProductCode
		   ,'Cases Per Pallet' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Cases_Per_Pallet,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Cases_Per_Layer)As bigint)ParseValue
		   ,Cases_Per_Layer CValue
		   ,GlazersProductCode
		   ,'Cases Per Layer' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Cases_Per_Layer,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Cases_20ft_Container)As bigint)ParseValue
		   ,Cases_20ft_Container CValue
		   ,GlazersProductCode
		   ,'Cases/20ft Container' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Cases_20ft_Container,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Cases_40ft_Container)As bigint)ParseValue
		   ,Cases_40ft_Container CValue
		   ,GlazersProductCode
		   ,'Cases/40ft Container' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Cases_40ft_Container,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Cases_40ft_Heated_Container)As bigint)ParseValue
		   ,Cases_40ft_Heated_Container CValue
		   ,GlazersProductCode
		   ,'Cases/40ft Heated Container' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Cases_40ft_Heated_Container,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Grape_Varietals)As decimal(10,4))ParseValue
		   ,Grape_Varietals CValue
		   ,GlazersProductCode
		   ,'Grape Varietals' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Grape_Varietals,''), NULL)) > 0
Union All
	Select Id,try_parse(dbo.GetNumbers(Variety)As decimal(10,4))ParseValue
		   ,Variety CValue
		   ,GlazersProductCode
		   ,'Variety' ColumnName
	From dbo.TMP_ProductInfo
	Where DATALENGTH(COALESCE(NULLIF(Variety,''), NULL)) > 0

) T Where T.ParseValue = 0 Or T.ParseValue Is Null

