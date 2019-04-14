

CREATE PROCEDURE [dbo].[InsertMasterSkuListData_old]
(
    -- Add the parameters for the stored procedure here
    @json NVARCHAR(max)
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    INSERT INTO dbo.TMP_ProductInfo (
		CategoryCode
		, SubCategoryCode
		, SupplierCode
		, BrandCode
		, ItemCode
		, GlazersProductCode
		, SupplierName
		, BrandName
		, ProductName
		, AlternateName
		, SupplierLegalName
		, UPC_EAN_13
		, SCC_14
		, ABV_Per
		, Category
		, SubCategory
		, ContainerType
		, ContainerVolume
		, Containers_Selling_Unit
		, Selling_Units_Case
		, Supplier_Internal_Code
		, Supplier_Internal_Code2
		, Supplier_Internal_Code3
		, Closure_Type
		, Closure_Weight
		, Bottle_Weight
		, Bottle_Height
		, Bottle_Length
		, Bottle_Width
		, Empty_Bottle_Weight
		, Lead_Time
		, Shipping_Term
		, Product_Designation
		, Origin_Country
		, Case_Height
		, Case_Width
		, Case_Length
		, Case_Weight
		, Cases_Per_Pallet
		, Layers_Per_Pallet
		, Cases_Per_Layer
		, Cases_20ft_Container
		, Cases_40ft_Container
		, Cases_40ft_Heated_Container
		, Appellation
		, Colour
		, Residual_Sugar
		, Grape_Varietals
		, Variety
		, Flavour
		, HQ_Contact_Name
		, HQ_Contact_Name_Position
		, HQ_Address		
		, HQ_City
		, HQ_Postal_Code
		, HQ_Country
		, HQ_Phone_Number
		, HQ_Email		
		, ACD_British_Columbia
		, ACD_Alberta
		, ACD_Saskatchewan
		, ACD_Manitoba
		, ACD_Ontario
		, ACD_Quebec
		, ACD_Newfoundland
		, ACD_New_Brunswick
		, ACD_Nova_Scotia
		, ACD_Prince_Edward_Island
		, ACD_Northwest_Territories
		, ACD_Nunavut
		, ACD_Yukon
		, CSPC_British_Columbia
		, CSPC_Alberta
		, CSPC_Saskatchewan
		, CSPC_Manitoba
		, CSPC_Ontario
		, CSPC_Quebec
		, CSPC_Newfoundland
		, CSPC_New_Brunswick
		, CSPC_Nova_Scotia
		, CSPC_Prince_Edward_Island
		, CSPC_Northwest_Territories
		, CSPC_Nunavut
		, CSPC_Yukon
		, CSPC_Quebec_Private_Order)
	SELECT
		 CategoryCode
		, SubCategoryCode
		, SupplierCode
		, BrandCode
		, ItemCode
		, GlazersProductCode
		, SupplierName
		, BrandName
		, ProductName
		, AlternateName
		, SupplierLegalName
		, UPC_EAN_13
		, SCC_14
		, ABV_Per
		, Category
		, SubCategory
		, ContainerType
		, ContainerVolume
		, Containers_Selling_Unit
		, Selling_Units_Case
		, Supplier_Internal_Code
		, Supplier_Internal_Code2
		, Supplier_Internal_Code3
		, Closure_Type
		, Closure_Weight
		, Bottle_Weight
		, Bottle_Height
		, Bottle_Length
		, Bottle_Width
		, Empty_Bottle_Weight
		, Lead_Time
		, Shipping_Term
		, Product_Designation
		, Origin_Country
		, Case_Height
		, Case_Width
		, Case_Length
		, Case_Weight
		, Cases_Per_Pallet
		, Layers_Per_Pallet
		, Cases_Per_Layer
		, Cases_20ft_Container
		, Cases_40ft_Container
		, Cases_40ft_Heated_Container
		, Appellation
		, Colour
		, Residual_Sugar
		, Grape_Varietals
		, Variety
		, Flavour
		, HQ_Contact_Name
		, HQ_Contact_Name_Position		
		, HQ_Address
		, HQ_City
		, HQ_Postal_Code
		, HQ_Country
		, HQ_Phone_Number		
		, HQ_Email
		, ACD_British_Columbia
		, ACD_Alberta
		, ACD_Saskatchewan
		, ACD_Manitoba
		, ACD_Ontario
		, ACD_Quebec
		, ACD_Newfoundland
		, ACD_New_Brunswick
		, ACD_Nova_Scotia
		, ACD_Prince_Edward_Island
		, ACD_Northwest_Territories
		, ACD_Nunavut
		, ACD_Yukon
		, CSPC_British_Columbia
		, CSPC_Alberta
		, CSPC_Saskatchewan
		, CSPC_Manitoba
		, CSPC_Ontario
		, CSPC_Quebec
		, CSPC_Newfoundland
		, CSPC_New_Brunswick
		, CSPC_Nova_Scotia
		, CSPC_Prince_Edward_Island
		, CSPC_Northwest_Territories
		, CSPC_Nunavut
		, CSPC_Yukon
		, CSPC_Quebec_Private_Order
	FROM OPENJSON(@json)
	WITH (
		--GlazersProductCode VARCHAR(50) '$.Glazersproductcode'
		CategoryCode varchar(10)	'$.CategoryCode'
		,SubCategoryCode int	'$.SubCategoryCode'
		,SupplierCode varchar(10)	'$.SupplierCode'
		,BrandCode int	'$.BrandCode'
		,ItemCode int	'$.ItemCode'
		,GlazersProductCode varchar(50)	'$.GlazersProductCode'
		,SupplierName varchar(500)	'$.SupplierName'
		,BrandName varchar(500)	'$.BrandName'
		,ProductName varchar(500)	'$.ProductName'
		,AlternateName varchar(500)	'$.AlternateName'
		,SupplierLegalName varchar(500)	'$.SupplierLegalName'
		,UPC_EAN_13 varchar(50)	'$.UPC_EAN_13'
		,SCC_14 varchar(50)	'$.SCC_14'
		,ABV_Per decimal(10, 2)	'$.ABV_Per'
		,Category varchar(50)	'$.Category'
		,SubCategory varchar(500)	'$.SubCategory'
		,ContainerType varchar(50)	'$.ContainerType'
		,ContainerVolume int	'$.ContainerVolume'
		,Containers_Selling_Unit int	'$.Containers_Selling_Unit'
		,Selling_Units_Case int	'$.Selling_Units_Case'
		,Supplier_Internal_Code varchar(50)	'$.Supplier_Internal_Code'
		,Supplier_Internal_Code2 varchar(50)	'$.Supplier_Internal_Code2'
		,Supplier_Internal_Code3 varchar(50)	'$.Supplier_Internal_Code3'
		,Closure_Type varchar(50)	'$.Closure_Type'
		,Closure_Weight decimal(10, 2)	'$.Closure_Weight'
		,Bottle_Weight decimal(10, 2)	'$.Bottle_Weight'
		,Bottle_Height decimal(10, 2)	'$.Bottle_Height'
		,Bottle_Length decimal(10, 2)	'$.Bottle_Length'
		,Bottle_Width decimal(10, 2)	'$.Bottle_Width'
		,Empty_Bottle_Weight decimal(10, 2)	'$.Empty_Bottle_Weight'
		,Lead_Time int	'$.Lead_Time'
		,Shipping_Term varchar(50)	'$.Shipping_Term'
		,Product_Designation varchar(100)	'$.Product_Designation'
		,Origin_Country varchar(100)	'$.Origin_Country'
		,Case_Height decimal(10, 2)	'$.Case_Height'
		,Case_Width decimal(10, 2)	'$.Case_Width'
		,Case_Length decimal(10, 2)	'$.Case_Length'
		,Case_Weight decimal(10, 2)	'$.Case_Weight'
		,Cases_Per_Pallet int	'$.Cases_Per_Pallet'
		,Layers_Per_Pallet int	'$.Layers_Per_Pallet'
		,Cases_Per_Layer int	'$.Cases_Per_Layer'
		,Cases_20ft_Container varchar(50)	'$.Cases_20ft_Container'
		,Cases_40ft_Container varchar(50)	'$.Cases_40ft_Container'
		,Cases_40ft_Heated_Container varchar(50)	'$.Cases_40ft_Heated_Container'
		,Appellation varchar(50)	'$.Appellation'
		,Colour varchar(50)	'$.Colour'
		,Residual_Sugar varchar(50)	'$.Residual_Sugar'
		,Grape_Varietals decimal(10, 2)	'$.Grape_Varietals'
		,Variety decimal(10, 2)	'$.Variety'
		,Flavour varchar(50)	'$.Flavour'
		,HQ_Contact_Name varchar(100)	'$.HQ_Contact_Name'
		,HQ_Contact_Name_Position varchar(50)	'$.HQ_Contact_Name_Position'
		,HQ_Address nvarchar(2000)	'$.HQ_Address'		
		,HQ_City varchar(100)	'$.HQ_City'
		,HQ_Postal_Code varchar(50)	'$.HQ_Postal_Code'
		,HQ_Country varchar(100)	'$.HQ_Country'
		,HQ_Phone_Number varchar(50)	'$.HQ_Phone_Number'
		,HQ_Email nvarchar(512)	'$.HQ_Email'		
		,ACD_British_Columbia bigint	'$.ACD_British_Columbia'
		,ACD_Alberta bigint	'$.ACD_Alberta'
		,ACD_Saskatchewan bigint	'$.ACD_Saskatchewan'
		,ACD_Manitoba bigint	'$.ACD_Manitoba'
		,ACD_Ontario bigint	'$.ACD_Ontario'
		,ACD_Quebec bigint	'$.ACD_Quebec'
		,ACD_Newfoundland bigint	'$.ACD_Newfoundland'
		,ACD_New_Brunswick bigint	'$.ACD_New_Brunswick'
		,ACD_Nova_Scotia bigint	'$.ACD_Nova_Scotia'
		,ACD_Prince_Edward_Island bigint	'$.ACD_Prince_Edward_Island'
		,ACD_Northwest_Territories bigint	'$.ACD_Northwest_Territories'
		,ACD_Nunavut bigint	'$.ACD_Nunavut'
		,ACD_Yukon bigint	'$.ACD_Yukon'
		,CSPC_British_Columbia bigint	'$.CSPC_British_Columbia'
		,CSPC_Alberta bigint	'$.CSPC_Alberta'
		,CSPC_Saskatchewan bigint	'$.CSPC_Saskatchewan'
		,CSPC_Manitoba bigint	'$.CSPC_Manitoba'
		,CSPC_Ontario bigint	'$.CSPC_Ontario'
		,CSPC_Quebec bigint	'$.CSPC_Quebec'
		,CSPC_Newfoundland bigint	'$.CSPC_Newfoundland'
		,CSPC_New_Brunswick bigint	'$.CSPC_New_Brunswick'
		,CSPC_Nova_Scotia bigint	'$.CSPC_Nova_Scotia'
		,CSPC_Prince_Edward_Island bigint	'$.CSPC_Prince_Edward_Island'
		,CSPC_Northwest_Territories bigint	'$.CSPC_Northwest_Territories'
		,CSPC_Nunavut bigint	'$.CSPC_Nunavut'
		,CSPC_Yukon bigint	'$.CSPC_Yukon'
		,CSPC_Quebec_Private_Order bigint	'$.CSPC_Quebec_Private_Order'

	)
		
END
