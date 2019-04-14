CREATE PROCEDURE [dbo].[InsertMasterSkuListData]
(
    -- Add the parameters for the stored procedure here
    @json NVARCHAR(max),
	@FileName NVARCHAR(500),
	@UserName uniqueidentifier
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    --SET NOCOUNT ON
	DECLARE @ErrorMessage NVARCHAR(4000) = 'success';
    DECLARE @ErrorSeverity INT = 0;
    DECLARE @ErrorState INT = 0;
	Declare @Process varchar(30) = '';

	BEGIN TRY

	Declare @FileInfoId Bigint 
	Truncate Table dbo.Tmp_ParseError

	Insert Into dbo.FileInfo Values(@FileName,@UserName,GetDate(),0)
	Select @FileInfoId = SCOPE_IDENTITY()

	Select @Process = 'TMP_ProductInfo';
    MERGE dbo.TMP_ProductInfo AS T
    USING (
		SELECT
		 CategoryCode
		,SubCategoryCode
		,SupplierCode
		,BrandCode
		,ItemCode
		,GlazersProductCode
		,SupplierName
		,BrandName
		,ProductName
		,AlternateName
		,SupplierLegalName
		,UPC_EAN_13
		,SCC_14
		,ABV_Per
		,Category
		,SubCategory
		,ContainerType
		,ContainerVolume
		,Containers_Selling_Unit
		,Selling_Units_Case
		,Supplier_Internal_Code
		,Supplier_Internal_Code2
		,Supplier_Internal_Code3
		,Closure_Type
		,Closure_Weight
		,Bottle_Weight
		,Bottle_Height
		,Bottle_Length
		,Bottle_Width
		,Empty_Bottle_Weight
		,Lead_Time
		,Shipping_Term
		,Product_Designation
		,Origin_Country
		,Case_Height
		,Case_Width
		,Case_Length
		,Case_Weight
		,Cases_Per_Pallet
		,Layers_Per_Pallet
		,Cases_Per_Layer
		,Cases_20ft_Container
		,Cases_40ft_Container
		,Cases_40ft_Heated_Container
		,Appellation
		,Colour
		,Residual_Sugar
		,Grape_Varietals
		,Variety
		,Flavour
		,HQ_Contact_Name
		,HQ_Contact_Name_Position		
		,HQ_Address
		,HQ_City
		,HQ_Postal_Code
		,HQ_Country
		,HQ_Phone_Number		
		,HQ_Email
		,ACD_British_Columbia
		,ACD_Alberta
		,ACD_Saskatchewan
		,ACD_Manitoba
		,ACD_Ontario
		,ACD_Quebec
		,ACD_Newfoundland
		,ACD_New_Brunswick
		,ACD_Nova_Scotia
		,ACD_Prince_Edward_Island
		,ACD_Northwest_Territories
		,ACD_Nunavut
		,ACD_Yukon
		,CSPC_British_Columbia
		,CSPC_Alberta
		,CSPC_Saskatchewan
		,CSPC_Manitoba
		,CSPC_Ontario
		,CSPC_Quebec
		,CSPC_Newfoundland
		,CSPC_New_Brunswick
		,CSPC_Nova_Scotia
		,CSPC_Prince_Edward_Island
		,CSPC_Northwest_Territories
		,CSPC_Nunavut
		,CSPC_Yukon
		,CSPC_Quebec_Private_Order
		,CSPC_Ontario_Consignment
		,PM_Owner
	FROM OPENJSON(@json)
	WITH (		
		CategoryCode varchar(10)	'$.CategoryCode'
		,SubCategoryCode varchar(10)	'$.SubCategoryCode'
		,SupplierCode varchar(10)	'$.SupplierCode'
		,BrandCode varchar(10)	'$.BrandCode'
		,ItemCode varchar(10)	'$.ItemCode'
		,GlazersProductCode varchar(50)	'$.GlazersProductCode'
		,SupplierName varchar(500)	'$.SupplierName'
		,BrandName varchar(500)	'$.BrandName'
		,ProductName varchar(500)	'$.ProductName'
		,AlternateName varchar(500)	'$.AlternateName'
		,SupplierLegalName varchar(500)	'$.SupplierLegalName'
		,UPC_EAN_13 varchar(50)	'$.UPC_EAN_13'
		,SCC_14 varchar(50)	'$.SCC_14'
		,ABV_Per varchar(50)	'$.ABV_Per'
		,Category varchar(50)	'$.Category'
		,SubCategory varchar(500)	'$.SubCategory'
		,ContainerType varchar(50)	'$.ContainerType'
		,ContainerVolume varchar(50)	'$.ContainerVolume'
		,Containers_Selling_Unit varchar(50)	'$.Containers_Selling_Unit'
		,Selling_Units_Case varchar(50)	'$.Selling_Units_Case'
		,Supplier_Internal_Code varchar(50)	'$.Supplier_Internal_Code'
		,Supplier_Internal_Code2 varchar(50)	'$.Supplier_Internal_Code2'
		,Supplier_Internal_Code3 varchar(50)	'$.Supplier_Internal_Code3'
		,Closure_Type varchar(50)	'$.Closure_Type'
		,Closure_Weight varchar(50)	'$.Closure_Weight'
		,Bottle_Weight varchar(50)	'$.Bottle_Weight'
		,Bottle_Height varchar(50)	'$.Bottle_Height'
		,Bottle_Length varchar(50)	'$.Bottle_Length'
		,Bottle_Width varchar(50)	'$.Bottle_Width'
		,Empty_Bottle_Weight varchar(50)	'$.Empty_Bottle_Weight'
		,Lead_Time varchar(50)	'$.Lead_Time'
		,Shipping_Term varchar(50)	'$.Shipping_Term'
		,Product_Designation varchar(100)	'$.Product_Designation'
		,Origin_Country varchar(100)	'$.Origin_Country'
		,Case_Height varchar(50)	'$.Case_Height'
		,Case_Width varchar(50)	'$.Case_Width'
		,Case_Length varchar(50)	'$.Case_Length'
		,Case_Weight varchar(50)	'$.Case_Weight'
		,Cases_Per_Pallet varchar(50)	'$.Cases_Per_Pallet'
		,Layers_Per_Pallet varchar(50)	'$.Layers_Per_Pallet'
		,Cases_Per_Layer varchar(50)	'$.Cases_Per_Layer'
		,Cases_20ft_Container varchar(50)	'$.Cases_20ft_Container'
		,Cases_40ft_Container varchar(50)	'$.Cases_40ft_Container'
		,Cases_40ft_Heated_Container varchar(50)	'$.Cases_40ft_Heated_Container'
		,Appellation varchar(500)	'$.Appellation'
		,Colour varchar(500)	'$.Colour'
		,Residual_Sugar varchar(500)	'$.Residual_Sugar'
		,Grape_Varietals varchar(500)	'$.Grape_Varietals'
		,Variety varchar(500)	'$.Variety'
		,Flavour varchar(500)	'$.Flavour'
		,HQ_Contact_Name varchar(100)	'$.HQ_Contact_Name'
		,HQ_Contact_Name_Position varchar(50)	'$.HQ_Contact_Name_Position'
		,HQ_Address nvarchar(2000)	'$.HQ_Address'		
		,HQ_City varchar(100)	'$.HQ_City'
		,HQ_Postal_Code varchar(50)	'$.HQ_Postal_Code'
		,HQ_Country varchar(100)	'$.HQ_Country'
		,HQ_Phone_Number varchar(50)	'$.HQ_Phone_Number'
		,HQ_Email nvarchar(512)	'$.HQ_Email'		
		,ACD_British_Columbia [varchar](50)	'$.ACD_British_Columbia'
		,ACD_Alberta [varchar](50)	'$.ACD_Alberta'
		,ACD_Saskatchewan [varchar](50)	'$.ACD_Saskatchewan'
		,ACD_Manitoba [varchar](50)	'$.ACD_Manitoba'
		,ACD_Ontario [varchar](50)	'$.ACD_Ontario'
		,ACD_Quebec [varchar](50)	'$.ACD_Quebec'
		,ACD_Newfoundland [varchar](50)	'$.ACD_Newfoundland'
		,ACD_New_Brunswick [varchar](50)	'$.ACD_New_Brunswick'
		,ACD_Nova_Scotia [varchar](50)	'$.ACD_Nova_Scotia'
		,ACD_Prince_Edward_Island [varchar](50)	'$.ACD_Prince_Edward_Island'
		,ACD_Northwest_Territories [varchar](50)	'$.ACD_Northwest_Territories'
		,ACD_Nunavut [varchar](50)	'$.ACD_Nunavut'
		,ACD_Yukon [varchar](50)	'$.ACD_Yukon'
		,CSPC_British_Columbia [varchar](50)	'$.CSPC_British_Columbia'
		,CSPC_Alberta [varchar](50)	'$.CSPC_Alberta'
		,CSPC_Saskatchewan [varchar](50)	'$.CSPC_Saskatchewan'
		,CSPC_Manitoba [varchar](50)	'$.CSPC_Manitoba'
		,CSPC_Ontario [varchar](50)	'$.CSPC_Ontario'
		,CSPC_Quebec [varchar](50)	'$.CSPC_Quebec'
		,CSPC_Newfoundland [varchar](50)	'$.CSPC_Newfoundland'
		,CSPC_New_Brunswick [varchar](50)	'$.CSPC_New_Brunswick'
		,CSPC_Nova_Scotia [varchar](50)	'$.CSPC_Nova_Scotia'
		,CSPC_Prince_Edward_Island [varchar](50)	'$.CSPC_Prince_Edward_Island'
		,CSPC_Northwest_Territories [varchar](50)	'$.CSPC_Northwest_Territories'
		,CSPC_Nunavut [varchar](50)	'$.CSPC_Nunavut'
		,CSPC_Yukon [varchar](50)	'$.CSPC_Yukon'
		,CSPC_Quebec_Private_Order [varchar](50)	'$.CSPC_Quebec_Private_Order'
		,CSPC_Ontario_Consignment [varchar](50)	'$.CSPC_Ontario_Consignment'
		,PM_Owner [varchar](50)	'$.PM_Owner'
	)) AS S
	ON (T.GlazersProductCode = S.GlazersProductCode And T.ProductName = S.ProductName) 
	WHEN MATCHED 
		THEN UPDATE SET			T.CategoryCode   = S.CategoryCode
								,T.SubCategoryCode  =  S.SubCategoryCode				
								,T.SupplierCode  =  S.SupplierCode
								,T.BrandCode  =  S.BrandCode
								,T.ItemCode  =  S.ItemCode
								--,T.GlazersProductCode  =  S.GlazersProductCode
								,T.SupplierName  =  S.SupplierName
								,T.BrandName  =  S.BrandName
								,T.ProductName  =  S.ProductName
								,T.AlternateName  =  S.AlternateName
								,T.SupplierLegalName  =  S.SupplierLegalName
								,T.UPC_EAN_13  =  S.UPC_EAN_13
								,T.SCC_14  =  S.SCC_14
								,T.ABV_Per  =  S.ABV_Per
								,T.Category  =  S.Category
								,T.SubCategory  =  S.SubCategory
								,T.ContainerType  =  S.ContainerType
								,T.ContainerVolume  =  S.ContainerVolume
								,T.Containers_Selling_Unit  =  S.Containers_Selling_Unit
								,T.Selling_Units_Case  =  S.Selling_Units_Case
								,T.Supplier_Internal_Code  =  S.Supplier_Internal_Code
								,T.Supplier_Internal_Code2  =  S.Supplier_Internal_Code2
								,T.Supplier_Internal_Code3  =  S.Supplier_Internal_Code3
								,T.Closure_Type  =  S.Closure_Type
								,T.Closure_Weight  =  S.Closure_Weight
								,T.Bottle_Weight  =  S.Bottle_Weight
								,T.Bottle_Height  =  S.Bottle_Height
								,T.Bottle_Length  =  S.Bottle_Length
								,T.Bottle_Width  =  S.Bottle_Width
								,T.Empty_Bottle_Weight  =  S.Empty_Bottle_Weight
								,T.Lead_Time  =  S.Lead_Time
								,T.Shipping_Term  =  S.Shipping_Term
								,T.Product_Designation  =  S.Product_Designation
								,T.Origin_Country  =  S.Origin_Country
								,T.Case_Height  =  S.Case_Height
								,T.Case_Width  =  S.Case_Width
								,T.Case_Length  =  S.Case_Length
								,T.Case_Weight  =  S.Case_Weight
								,T.Cases_Per_Pallet  =  S.Cases_Per_Pallet
								,T.Layers_Per_Pallet  =  S.Layers_Per_Pallet
								,T.Cases_Per_Layer  =  S.Cases_Per_Layer
								,T.Cases_20ft_Container  =  S.Cases_20ft_Container
								,T.Cases_40ft_Container  =  S.Cases_40ft_Container
								,T.Cases_40ft_Heated_Container  =  S.Cases_40ft_Heated_Container
								,T.Appellation  =  S.Appellation
								,T.Colour  =  S.Colour
								,T.Residual_Sugar  =  S.Residual_Sugar
								,T.Grape_Varietals  =  S.Grape_Varietals
								,T.Variety  =  S.Variety
								,T.Flavour  =  S.Flavour
								,T.HQ_Contact_Name  =  S.HQ_Contact_Name
								,T.HQ_Contact_Name_Position  =  S.HQ_Contact_Name_Position
								,T.HQ_Address  =  S.HQ_Address
								,T.HQ_City  =  S.HQ_City
								,T.HQ_Postal_Code  =  S.HQ_Postal_Code
								,T.HQ_Country  =  S.HQ_Country
								,T.HQ_Phone_Number  =  S.HQ_Phone_Number
								,T.HQ_Email  =  S.HQ_Email
								,T.ACD_British_Columbia  =  S.ACD_British_Columbia
								,T.ACD_Alberta  =  S.ACD_Alberta
								,T.ACD_Saskatchewan  =  S.ACD_Saskatchewan
								,T.ACD_Manitoba  =  S.ACD_Manitoba
								,T.ACD_Ontario  =  S.ACD_Ontario
								,T.ACD_Quebec  =  S.ACD_Quebec
								,T.ACD_Newfoundland  =  S.ACD_Newfoundland
								,T.ACD_New_Brunswick  =  S.ACD_New_Brunswick
								,T.ACD_Nova_Scotia  =  S.ACD_Nova_Scotia
								,T.ACD_Prince_Edward_Island  =  S.ACD_Prince_Edward_Island
								,T.ACD_Northwest_Territories  =  S.ACD_Northwest_Territories
								,T.ACD_Nunavut  =  S.ACD_Nunavut
								,T.ACD_Yukon  =  S.ACD_Yukon
								,T.CSPC_British_Columbia  =  S.CSPC_British_Columbia
								,T.CSPC_Alberta  =  S.CSPC_Alberta
								,T.CSPC_Saskatchewan  =  S.CSPC_Saskatchewan
								,T.CSPC_Manitoba  =  S.CSPC_Manitoba
								,T.CSPC_Ontario  =  S.CSPC_Ontario
								,T.CSPC_Quebec  =  S.CSPC_Quebec
								,T.CSPC_Newfoundland  =  S.CSPC_Newfoundland
								,T.CSPC_New_Brunswick  =  S.CSPC_New_Brunswick
								,T.CSPC_Nova_Scotia  =  S.CSPC_Nova_Scotia
								,T.CSPC_Prince_Edward_Island  =  S.CSPC_Prince_Edward_Island
								,T.CSPC_Northwest_Territories  =  S.CSPC_Northwest_Territories
								,T.CSPC_Nunavut  =  S.CSPC_Nunavut
								,T.CSPC_Yukon  =  S.CSPC_Yukon
								,T.CSPC_Quebec_Private_Order  =  S.CSPC_Quebec_Private_Order
								,T.CSPC_Ontario_Consignment = S.CSPC_Ontario_Consignment
								,T.FileInfoId = @FileInfoId
								,T.UserName = @UserName
								,T.PM_Owner = S.PM_Owner

WHEN NOT MATCHED BY TARGET
	THEN INSERT (
		CategoryCode
		,SubCategoryCode
		,SupplierCode
		,BrandCode
		,ItemCode
		,GlazersProductCode
		,SupplierName
		,BrandName
		,ProductName
		,AlternateName
		,SupplierLegalName
		,UPC_EAN_13
		,SCC_14
		,ABV_Per
		,Category
		,SubCategory
		,ContainerType
		,ContainerVolume
		,Containers_Selling_Unit
		,Selling_Units_Case
		,Supplier_Internal_Code
		,Supplier_Internal_Code2
		,Supplier_Internal_Code3
		,Closure_Type
		,Closure_Weight
		,Bottle_Weight
		,Bottle_Height
		,Bottle_Length
		,Bottle_Width
		,Empty_Bottle_Weight
		,Lead_Time
		,Shipping_Term
		,Product_Designation
		,Origin_Country
		,Case_Height
		,Case_Width
		,Case_Length
		,Case_Weight
		,Cases_Per_Pallet
		,Layers_Per_Pallet
		,Cases_Per_Layer
		,Cases_20ft_Container
		,Cases_40ft_Container
		,Cases_40ft_Heated_Container
		,Appellation
		,Colour
		,Residual_Sugar
		,Grape_Varietals
		,Variety
		,Flavour
		,HQ_Contact_Name
		,HQ_Contact_Name_Position
		,HQ_Address		
		,HQ_City
		,HQ_Postal_Code
		,HQ_Country
		,HQ_Phone_Number
		,HQ_Email		
		,ACD_British_Columbia
		,ACD_Alberta
		,ACD_Saskatchewan
		,ACD_Manitoba
		,ACD_Ontario
		,ACD_Quebec
		,ACD_Newfoundland
		,ACD_New_Brunswick
		,ACD_Nova_Scotia
		,ACD_Prince_Edward_Island
		,ACD_Northwest_Territories
		,ACD_Nunavut
		,ACD_Yukon
		,CSPC_British_Columbia
		,CSPC_Alberta
		,CSPC_Saskatchewan
		,CSPC_Manitoba
		,CSPC_Ontario
		,CSPC_Quebec
		,CSPC_Newfoundland
		,CSPC_New_Brunswick
		,CSPC_Nova_Scotia
		,CSPC_Prince_Edward_Island
		,CSPC_Northwest_Territories
		,CSPC_Nunavut
		,CSPC_Yukon
		,CSPC_Quebec_Private_Order
		,CSPC_Ontario_Consignment
		,FileInfoId
		,UserName
		,PM_Owner
	)	
Values( S.CategoryCode
		,S.SubCategoryCode
		,S.SupplierCode
		,S.BrandCode
		,S.ItemCode
		,S.GlazersProductCode
		,S.SupplierName
		,S.BrandName
		,S.ProductName
		,S.AlternateName
		,S.SupplierLegalName
		,S.UPC_EAN_13
		,S.SCC_14
		,S.ABV_Per
		,S.Category
		,S.SubCategory
		,S.ContainerType
		,S.ContainerVolume
		,S.Containers_Selling_Unit
		,S.Selling_Units_Case
		,S.Supplier_Internal_Code
		,S.Supplier_Internal_Code2
		,S.Supplier_Internal_Code3
		,S.Closure_Type
		,S.Closure_Weight
		,S.Bottle_Weight
		,S.Bottle_Height
		,S.Bottle_Length
		,S.Bottle_Width
		,S.Empty_Bottle_Weight
		,S.Lead_Time
		,S.Shipping_Term
		,S.Product_Designation
		,S.Origin_Country
		,S.Case_Height
		,S.Case_Width
		,S.Case_Length
		,S.Case_Weight
		,S.Cases_Per_Pallet
		,S.Layers_Per_Pallet
		,S.Cases_Per_Layer
		,S.Cases_20ft_Container
		,S.Cases_40ft_Container
		,S.Cases_40ft_Heated_Container
		,S.Appellation
		,S.Colour
		,S.Residual_Sugar
		,S.Grape_Varietals
		,S.Variety
		,S.Flavour
		,S.HQ_Contact_Name
		,S.HQ_Contact_Name_Position
		,S.HQ_Address
		,S.HQ_City
		,S.HQ_Postal_Code
		,S.HQ_Country
		,S.HQ_Phone_Number
		,S.HQ_Email
		,S.ACD_British_Columbia
		,S.ACD_Alberta
		,S.ACD_Saskatchewan
		,S.ACD_Manitoba
		,S.ACD_Ontario
		,S.ACD_Quebec
		,S.ACD_Newfoundland
		,S.ACD_New_Brunswick
		,S.ACD_Nova_Scotia
		,S.ACD_Prince_Edward_Island
		,S.ACD_Northwest_Territories
		,S.ACD_Nunavut
		,S.ACD_Yukon
		,S.CSPC_British_Columbia
		,S.CSPC_Alberta
		,S.CSPC_Saskatchewan
		,S.CSPC_Manitoba
		,S.CSPC_Ontario
		,S.CSPC_Quebec
		,S.CSPC_Newfoundland
		,S.CSPC_New_Brunswick
		,S.CSPC_Nova_Scotia
		,S.CSPC_Prince_Edward_Island
		,S.CSPC_Northwest_Territories
		,S.CSPC_Nunavut
		,S.CSPC_Yukon
		,S.CSPC_Quebec_Private_Order
		,S.CSPC_Ontario_Consignment
		,@FileInfoId
		,@UserName
		,S.PM_Owner
);
	
	/*---------- Parse Error-----------*/
	Select @Process = 'Tmp_ParseError';
	Insert Into dbo.Tmp_ParseError(RecordId,ColumnName,ColumnValue,ErrroMsg,GID)
	Select Id,ColumnName,CValue,'',GlazersProductCode From dbo.vw_TMP_ProductInfo_GetErrorData

	/*---------- Duplicate SupplierCode-----------*/
	Insert Into dbo.Tmp_ParseError(RecordId,ColumnName,ColumnValue,ErrroMsg,GID)
	Select 0,'SupplierCode',SupplierCode,'Duplicate Supplier Name',''--Count(SupplierName) SupplierCount
	From
	(
		Select SupplierCode,SupplierName
		From dbo.TMP_ProductInfo With(Nolock)
		Group By SupplierCode,SupplierName
	) A
	Group By SupplierCode
	Having Count(SupplierName) > 1

	/*---------- Duplicate GlazersProductCode-----------*/
	Insert Into dbo.Tmp_ParseError(RecordId,ColumnName,ColumnValue,ErrroMsg,GID)
	Select 0,'GlazersProductCode',GlazersProductCode,'Duplicate GlazersProductCode','' 		
			From dbo.TMP_ProductInfo With(Nolock)
			Group by GlazersProductCode
			Having count(GlazersProductCode) > 1
		 
	
	/*---------- End of Parse Error-----------*/

	Select @Process = 'Archive_ProductInfo';
	INSERT INTO dbo.Archive_ProductInfo(
		 FileInfoId
		,CategoryCode
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
		, CSPC_Ontario_Consignment
		, PM_Owner)
	SELECT
		 FileInfoId
		,CategoryCode
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
		, CSPC_Ontario_Consignment
		, PM_Owner
		From dbo.TMP_ProductInfo
	
	Select @Process = 'PM_Owner';
	MERGE dbo.PM_Owner AS T
    USING (
			Select PM_Owner From dbo.TMP_ProductInfo With(Nolock)
			Group  By PM_Owner			
		  ) AS S 
	ON (T.PM_Owner = S.PM_Owner) 
	WHEN MATCHED 
		THEN UPDATE SET T.PM_Owner = S.PM_Owner
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (PM_Owner, IsActive)	
	VALUES (S.PM_Owner, 1);

	Select @Process = 'Category';	
	MERGE dbo.Category AS TC
    USING (
			Select	CategoryCode
					,Category
			From dbo.TMP_ProductInfo TP With (Nolock) 
			Group By CategoryCode,Category
			
		  ) AS SC 
	ON (TC.CategoryCode = SC.CategoryCode) 
	WHEN MATCHED 
		THEN UPDATE SET TC.Category = SC.Category
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (CategoryCode, Category)	
	VALUES (SC.CategoryCode, SC.Category);

	Select @Process = 'SubCategory';
	MERGE dbo.SubCategory AS TC
    USING (
			Select	SubCategoryCode
					,SubCategory
					,C.Id
			From dbo.TMP_ProductInfo TP With (Nolock) 
			Inner Join dbo.Category C With(Nolock) On TP.CategoryCode = C.CategoryCode
			Group By SubCategoryCode,SubCategory,C.Id
			
		  ) AS SC 
	ON (TC.SubCategoryCode = SC.SubCategoryCode) 
	WHEN MATCHED 
		THEN UPDATE SET TC.SubCategory = SC.SubCategory
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (SubCategoryCode, SubCategory,CategoryId)	
	VALUES (SC.SubCategoryCode, SC.SubCategory,SC.Id);

	Select @Process = 'Brand';
	MERGE dbo.Brand AS TB
    USING (
			Select	BrandCode
					,BrandName
					,S.SupplierCode
			From dbo.TMP_ProductInfo TP With (Nolock) 
			Left Join dbo.Supplier S With (Nolock) On TP.SupplierCode = S.SupplierCode
			
			Group By BrandCode,BrandName,S.SupplierCode			
		  ) AS SB 
	ON (TB.BrandCode = SB.BrandCode And TB.BrandName = SB.BrandName) 
	WHEN MATCHED 
		THEN UPDATE SET TB.BrandName = SB.BrandName						
						,TB.SupplierCode = SB.SupplierCode
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (BrandCode, BrandName,OwnerId,SupplierCode)	
	VALUES (SB.BrandCode, SB.BrandName,@UserName,Sb.SupplierCode);

	Select @Process = 'Supplier';
	MERGE dbo.Supplier AS TS
    USING (
			Select	SupplierCode
					,SupplierName
					,SupplierLegalName					
			From dbo.TMP_ProductInfo TP With (Nolock) 			
			Group By SupplierCode,SupplierName,SupplierLegalName
		  ) AS SS 
	ON (TS.SupplierCode = SS.SupplierCode 
		And TS.SupplierName = SS.SupplierName 
		And TS.LegalName = SS.SupplierLegalName) 
	WHEN MATCHED 
		THEN UPDATE SET  TS.SupplierName = SS.SupplierName
						,TS.LegalName = SS.SupplierLegalName						
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (SupplierCode
					,SupplierName
					,LegalName					
					,Active
				)	
	VALUES     (SS.SupplierCode
				   ,SS.SupplierName
				   ,SS.SupplierLegalName			    
				   ,1
				);

	Select @Process = 'SupplierInternalCode';	
	MERGE dbo.SupplierInternalCode AS TS
    USING (
			Select	S.SupplierCode	
					,S.Id				
					,Supplier_Internal_Code
					,Supplier_Internal_Code2
					,Supplier_Internal_Code3
			From dbo.TMP_ProductInfo TP With (Nolock)
			Inner Join dbo.Supplier S With(Nolock) On TP.SupplierCode = S.SupplierCode			
			Where Supplier_Internal_Code <> '' Or Supplier_Internal_Code2 <> '' Or Supplier_Internal_Code3 <>''
			Group By S.SupplierCode,S.Id,Supplier_Internal_Code,Supplier_Internal_Code2,Supplier_Internal_Code3
		  ) AS SS 
	ON (TS.SupplierId = SS.Id 
		And TS.Supplier_Internal_Code = SS.Supplier_Internal_Code
		And TS.Supplier_Internal_Code2 = SS.Supplier_Internal_Code2
		And TS.Supplier_Internal_Code3 = SS.Supplier_Internal_Code3) 
	WHEN MATCHED 
		THEN UPDATE SET 
						TS.Supplier_Internal_Code = SS.Supplier_Internal_Code
						,TS.Supplier_Internal_Code2 = SS.Supplier_Internal_Code2
						,TS.Supplier_Internal_Code3 = SS.Supplier_Internal_Code3
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (
					SupplierId
					,Supplier_Internal_Code
					,Supplier_Internal_Code2
					,Supplier_Internal_Code3					
				)	
	VALUES     (    SS.Id				   
				   ,SS.Supplier_Internal_Code
				   ,SS.Supplier_Internal_Code2
				   ,SS.Supplier_Internal_Code3				   
				);


	Select @Process = 'ProductCase';
	MERGE dbo.ProductCase AS TC
    USING (
			Select distinct	GlazersProductCode
					,try_parse(dbo.GetNumbers(Case_Height) As decimal(10,2))Case_Height
					,try_parse(dbo.GetNumbers(Case_Width) As decimal(10,2))Case_Width
					,try_parse(dbo.GetNumbers(Case_Length) As decimal(10,2))Case_Length
					,try_parse(dbo.GetNumbers(Case_Weight) As decimal(10,2))Case_Weight
			From dbo.TMP_ProductInfo TP With (Nolock) 
			--Group By GlazersProductCode
			
		  ) AS SC 
	ON (TC.GID = SC.GlazersProductCode 
						And Isnull(TC.Case_Height,0) = Isnull(SC.Case_Height,0)
						And Isnull(TC.Case_Width,0) = Isnull(SC.Case_Width,0)
						And Isnull(TC.Case_Length,0) = Isnull(SC.Case_Length,0)
						And Isnull(TC.Case_Weight,0) = Isnull(SC.Case_Weight,0)
	) 
	WHEN MATCHED 
		THEN UPDATE SET TC.Case_Height = SC.Case_Height						
						,TC.Case_Width = SC.Case_Width
						,TC.Case_Length = SC.Case_Length
						,TC.Case_Weight = SC.Case_Weight	
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (GID
					,Case_Height
					,Case_Width
					,Case_Length
					,Case_Weight
				)	
	VALUES (SC.GlazersProductCode
					,SC.Case_Height
					,SC.Case_Width
					,SC.Case_Length
					,SC.Case_Weight					
				);
		
	Select @Process = 'CSPC_ACD';
	MERGE dbo.CSPC_ACD AS TC
    USING (
			Select	GlazersProductCode
					,ACD_Code
					,CSPC_Code
					,P.Id					
			From dbo.vw_ACD_CSPC_Code TP With (Nolock) 	
			Inner Join dbo.Province P With (Nolock)	On TP.Province = P.Code
			Where COALESCE(NULLIF(TP.ACD_Code,''),'0') <> '0' 
					OR COALESCE(NULLIF(TP.CSPC_Code,''),'0')	<> '0'		
		  ) AS SC 
	ON (TC.GID = SC.GlazersProductCode And TC.ProvinceId = SC.Id) 
	WHEN MATCHED 
		THEN UPDATE SET TC.ACD_Code = SC.ACD_Code						
						,TC.CSPC_Code = SC.CSPC_Code							
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (GID
					,ACD_Code
					,CSPC_Code
					,ProvinceId					
				)	
	VALUES (SC.GlazersProductCode
					,SC.ACD_Code
					,SC.CSPC_Code
					,SC.Id									
				);

		
	Select @Process = 'Product';
	MERGE dbo.Product AS TC
		USING (
				Select distinct	GlazersProductCode
						,ItemCode
						,ProductName
						,AlternateName
						,UPC_EAN_13
						,SCC_14					
						,S.Id SupplierId
						,B.Id BrandId
						,C.Id CategoryId
						,sub.Id SubCategoryId
						,S.SupplierCode
						,PM.Id PM_Owner_Id
				From dbo.TMP_ProductInfo TP With (Nolock)
				Left Join dbo.Brand B On TP.BrandCode = B.BrandCode And TP.BrandName = B.BrandName
				Left Join dbo.Supplier S On TP.SupplierCode = S.SupplierCode 
											And TP.SupplierName = S.SupplierName 
											And TP.SupplierLegalName = S.LegalName										
				Left Join dbo.SubCategory Sub On TP.SubCategoryCode = Sub.SubCategoryCode And TP.SubCategory = Sub.SubCategory
				Left Join dbo.Category C On TP.CategoryCode = C.CategoryCode And TP.Category = C.Category	
				Left Join dbo.PM_Owner PM On TP.PM_Owner = PM.PM_Owner		
			  ) AS SC 
		ON (TC.GID = SC.GlazersProductCode And TC.ProductName = SC.ProductName
											And TC.AlternateName = SC.AlternateName) 
		WHEN MATCHED 
			THEN UPDATE SET TC.ItemCode = SC.ItemCode
							,TC.ProductName = SC.ProductName
							,TC.AlternateName = SC.AlternateName
							,TC.UPC_EAN_13 = SC.UPC_EAN_13
							,TC.SCC_14	= SC.SCC_14		
							,TC.SupplierId = SC.SupplierId
							,TC.BrandId = SC.BrandId
							,TC.CategoryId = SC.CategoryId
							,TC.SubCategoryId = SC.SubCategoryId
							,TC.SupplierCode = SC.SupplierCode
							,TC.PM_Owner_Id = SC.PM_Owner_Id
		WHEN NOT MATCHED BY TARGET
		THEN INSERT (GID				
						,ItemCode
						,ProductName
						,AlternateName
						,UPC_EAN_13
						,SCC_14					
						,SupplierId
						,BrandId
						,CategoryId
						,SubCategoryId
						,SupplierCode
					)	
		VALUES (SC.GlazersProductCode
						,SC.ItemCode
						,SC.ProductName
						,SC.AlternateName
						,SC.UPC_EAN_13		
						,SC.SCC_14			
						,SC.SupplierId
						,SC.BrandId
						,SC.CategoryId
						,SC.SubCategoryId
						,SC.SupplierCode
					);

	Select @Process = 'ProductDetails';			
	MERGE dbo.ProductDetails AS TC
    USING (
			Select distinct	GlazersProductCode
					,try_parse(dbo.GetNumbers(ABV_Per) As Decimal(10,2))ABV_Per
					,Appellation
					,Colour
					,Residual_Sugar
					,try_parse(dbo.GetNumbers(Grape_Varietals) As Decimal(10,2))Grape_Varietals
					,try_parse(dbo.GetNumbers(Variety) As Decimal(10,2))Variety
					,Flavour
					,Origin_Country
					,Closure_Type
					,try_parse(dbo.GetNumbers(Closure_Weight) As Decimal(10,2))Closure_Weight					
					,try_parse(dbo.GetNumbers(Bottle_Weight) As Decimal(10,2))Bottle_Weight
					,try_parse(dbo.GetNumbers(Bottle_Height) As Decimal(10,2))Bottle_Height
					,try_parse(dbo.GetNumbers(Bottle_Length) As Decimal(10,2))Bottle_Length
					,try_parse(dbo.GetNumbers(Bottle_Width) As Decimal(10,2))Bottle_Width
					,try_parse(dbo.GetNumbers(Empty_Bottle_Weight) As Decimal(10,2))Empty_Bottle_Weight
					,ContainerType
					,try_parse(dbo.GetNumbers(Containers_Selling_Unit) As bigint)Containers_Selling_Unit
					,try_parse(dbo.GetNumbers(Selling_Units_Case) As bigint)Selling_Units_Case
					,try_parse(dbo.GetNumbers(ContainerVolume) As bigint)ContainerVolume
			From dbo.TMP_ProductInfo TP With (Nolock)			
		  ) AS SC 
	ON (TC.GID = SC.GlazersProductCode And Isnull(TC.ABV_Per,0) = Isnull(SC.ABV_Per,0)) 
	WHEN MATCHED 
		THEN UPDATE SET TC.ABV_Per = SC.ABV_Per
						,TC.Appellation = SC.Appellation
						,TC.Colour = SC.Colour
						,TC.Residual_Sugar = SC.Residual_Sugar
						,TC.Grape_Varietals = SC.Grape_Varietals
						,TC.Variety = SC.Variety
						,TC.Flavour = SC.Flavour
						,TC.Origin_Country = SC.Origin_Country
						,TC.Closure_Type = SC.Closure_Type
						,TC.Closure_Weight= SC.Closure_Weight
						,TC.Bottle_Weight = SC.Bottle_Weight
						,TC.Bottle_Height = SC.Bottle_Height
						,TC.Bottle_Length = SC.Bottle_Length
						,TC.Bottle_Width = SC.Bottle_Width
						,TC.Empty_Bottle_Weight = SC.Empty_Bottle_Weight
						,TC.ContainerType = SC.ContainerType
						,TC.Containers_Selling_Unit = SC.Containers_Selling_Unit
						,TC.Selling_Units_Case = SC.Selling_Units_Case
						,TC.ContainerVolume = SC.ContainerVolume
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (GID									
					,ABV_Per
					,Appellation
					,Colour
					,Residual_Sugar
					,Grape_Varietals
					,Variety
					,Flavour
					,Origin_Country
					,Closure_Type
					,Closure_Weight
					,Bottle_Weight
					,Bottle_Height
					,Bottle_Length
					,Bottle_Width
					,Empty_Bottle_Weight
					,ContainerType
					,Containers_Selling_Unit
					,Selling_Units_Case
					,ContainerVolume
				)	
	VALUES (SC.GlazersProductCode
					,SC.ABV_Per
					,SC.Appellation
					,SC.Colour
					,SC.Residual_Sugar
					,SC.Grape_Varietals
					,SC.Variety
					,SC.Flavour
					,SC.Origin_Country
					,SC.Closure_Type
					,SC.Closure_Weight
					,SC.Bottle_Weight
					,SC.Bottle_Height
					,SC.Bottle_Length
					,SC.Bottle_Width
					,SC.Empty_Bottle_Weight
					,SC.ContainerType
					,SC.Containers_Selling_Unit
					,SC.Selling_Units_Case
					,SC.ContainerVolume
				);
	
	
	
	Select @Process = 'Logistics';
	MERGE dbo.Logistics AS TC
    USING (
			Select distinct	GlazersProductCode
					,try_parse(dbo.GetNumbers(Cases_Per_Pallet) As int)Cases_Per_Pallet
					,try_parse(dbo.GetNumbers(Layers_Per_Pallet) As int)Layers_Per_Pallet
					,try_parse(dbo.GetNumbers(Cases_Per_Layer) As int)Cases_Per_Layer
					,try_parse(dbo.GetNumbers(Cases_20ft_Container) As int)Cases_20ft_Container
					,try_parse(dbo.GetNumbers(Cases_40ft_Container) As int)Cases_40ft_Container
					,try_parse(dbo.GetNumbers(Cases_40ft_Heated_Container) As int)Cases_40ft_Heated_Container
			From dbo.TMP_ProductInfo TP With (Nolock) 	
			--Where 	Cases_Per_Pallet IS Not Null 
			--		Or Layers_Per_Pallet IS Not Null				
			--		Or Cases_Per_Layer IS Not Null
			--		Or Cases_20ft_Container IS Not Null
			--		Or Cases_40ft_Container IS Not Null
			--		Or Cases_40ft_Heated_Container IS Not Null
		  ) AS SC 
	ON (TC.GID = SC.GlazersProductCode
	           And Isnull(TC.Cases_Per_Pallet,0) = Isnull(SC.Cases_Per_Pallet,0)
			   And Isnull(TC.Layers_Per_Pallet,0) = Isnull(SC.Layers_Per_Pallet,0)
			   And Isnull(TC.Cases_Per_Layer,0) = Isnull(SC.Cases_Per_Layer,0)
			   And Isnull(TC.Cases_20ft_Container,0) = Isnull(SC.Cases_20ft_Container,0)
			   And Isnull(TC.Cases_40ft_Container,0) = Isnull(SC.Cases_40ft_Container,0)
			   And Isnull(TC.Cases_40ft_Heated_Container,0) = Isnull(SC.Cases_40ft_Heated_Container,0)
			   ) 
	WHEN MATCHED 
		THEN UPDATE SET TC.Cases_Per_Pallet = SC.Cases_Per_Pallet
						,TC.Layers_Per_Pallet = SC.Layers_Per_Pallet
						,TC.Cases_Per_Layer = SC.Cases_Per_Layer
						,TC.Cases_20ft_Container = SC.Cases_20ft_Container
						,TC.Cases_40ft_Container = SC.Cases_40ft_Container
						,TC.Cases_40ft_Heated_Container = SC.Cases_40ft_Heated_Container
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (GID
					,Cases_Per_Pallet
					,Layers_Per_Pallet
					,Cases_Per_Layer
					,Cases_20ft_Container
					,Cases_40ft_Container
					,Cases_40ft_Heated_Container)	
	VALUES (SC.GlazersProductCode
					,SC.Cases_Per_Pallet
					,SC.Layers_Per_Pallet
					,SC.Cases_Per_Layer
					,SC.Cases_20ft_Container
					,SC.Cases_40ft_Container
					,SC.Cases_40ft_Heated_Container
				);
		
	Select @Process = 'Shipping';
	MERGE dbo.Shipping AS TC
    USING (
			Select distinct GlazersProductCode
					,try_parse(dbo.GetNumbers(Lead_Time) As int)Lead_Time
					,Shipping_Term
					,Product_Designation					
			From dbo.TMP_ProductInfo TP With (Nolock) 
		  ) AS SC 
	ON (TC.GID = SC.GlazersProductCode
			And Isnull(TC.Lead_Time,0) = Isnull(SC.Lead_Time,0)
			And TC.Shipping_Term = SC.Shipping_Term
			And TC.Product_Designation = SC.Product_Designation
	) 
	WHEN MATCHED 
		THEN UPDATE SET TC.Lead_Time = SC.Lead_Time
						,TC.Shipping_Term = SC.Shipping_Term
						,TC.Product_Designation = SC.Product_Designation						
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (GID
					,Lead_Time
					,Shipping_Term
					,Product_Designation
					)	
	VALUES (SC.GlazersProductCode
					,SC.Lead_Time
					,SC.Shipping_Term
					,SC.Product_Designation					
				);
	
	Select @Process = 'SupplierContact';
	MERGE dbo.SupplierContact AS TB
    USING (
			Select	Distinct S.Id SupplierId
					,HQ_Contact_Name
					,HQ_Contact_Name_Position
					,HQ_Address
					,HQ_City
					,HQ_Postal_Code
					,HQ_Country
					,HQ_Phone_Number
					,HQ_Email
			From dbo.TMP_ProductInfo TP With (Nolock) 			
			Left Join dbo.Supplier S With (Nolock) On TP.SupplierCode = S.SupplierCode		
			Where HQ_Contact_Name <>''  Or
				  HQ_Contact_Name_Position <> '' Or
				  HQ_Address <> '' Or HQ_City <> '' Or HQ_Postal_Code <> '' Or HQ_Country <> '' Or
				  HQ_Phone_Number <> '' Or HQ_Email <> ''			
		  ) AS SB 
	ON (TB.SupplierId = SB.SupplierId
					And TB.HQ_Contact_Name = SB.HQ_Contact_Name
					And TB.HQ_Contact_Name_Position = SB.HQ_Contact_Name_Position
					And TB.HQ_Address = SB.HQ_Address
					And TB.HQ_City = SB.HQ_City
					And TB.HQ_Postal_Code = SB.HQ_Postal_Code
					And TB.HQ_Country = SB.HQ_Country
					And TB.HQ_Phone_Number = SB.HQ_Phone_Number
					And TB.HQ_Email = SB.HQ_Email
	) 
	WHEN MATCHED 
		THEN UPDATE SET TB.HQ_Contact_Name           = SB.HQ_Contact_Name
					,TB.HQ_Contact_Name_Position     = SB.HQ_Contact_Name_Position
					,TB.HQ_Address                   = SB.HQ_Address
					,TB.HQ_City                      = SB.HQ_City
					,TB.HQ_Postal_Code               = SB.HQ_Postal_Code
					,TB.HQ_Country                   = SB.HQ_Country
					,TB.HQ_Phone_Number              = SB.HQ_Phone_Number
					,TB.HQ_Email                     = SB.HQ_Email
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (   SupplierId
					,HQ_Contact_Name
					,HQ_Contact_Name_Position
					,HQ_Address
					,HQ_City
					,HQ_Postal_Code
					,HQ_Country
					,HQ_Phone_Number
					,HQ_Email)	
	VALUES (
			SB.SupplierId
			,SB.HQ_Contact_Name
			,SB.HQ_Contact_Name_Position
			,SB.HQ_Address
			,SB.HQ_City
			,SB.HQ_Postal_Code
			,SB.HQ_Country
			,SB.HQ_Phone_Number
			,SB.HQ_Email
	);
	
  END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = 'Process: '+  @Process + ', ' + ERROR_MESSAGE() ,
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

   
END CATCH;

SELECT @ErrorMessage ErrorMessage, @ErrorSeverity ErrorSeverity, @ErrorState ErrorState;
        
END
