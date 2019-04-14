CREATE PROCEDURE [dbo].[InsertExpenseData] --'[{"Id":0,"Record":"1","Month":"Dec","Date":"12/21/17 12:00:00 AM","Province":"AB","ExpenseType":"(VR)Sampling","InvoiceNo":"","Vendor":"LIQUORAMA","InvoiceDescription":"Retail sampling","Employee":"0069 Mikkelsen, Ayron J","Supplier":"Agave Loco","Brand":"RumChata","ProgramType":"","SupplierVendorName":"Agave Loco","RemyClassification":"","Patron_GL_Account":"","Grant_Applicable":"","Supplier_Coding":"","Amount_Net":"148.96","Tax":"7.4","Total":"156.36","BillBack":"Jan 2018 Bill Back","AP_Structure":""}]','Actual Spends for A&P (cleaned)_20190315181605.389.xlsx','e0e48589-b8c9-46c1-889f-42395c3a1d79'
(
    -- Add the parameters for the stored procedure here
    @json VARCHAR(max),
	@FileName NVARCHAR(500),
	@UserName uniqueidentifier
)
AS
BEGIN	
BEGIN TRY
BEGIN TRANSACTION

	Insert Into dbo.FileInfo Values(@FileName,@UserName,GetDate(),0)
	--Select @FileInfoId = SCOPE_IDENTITY()

		truncate table [Expense_Import]

		--Import data in expense_import
		INSERT into [dbo].[Expense_Import] ([Record], [Month], [Date], [Province],  [InvoiceNo], [Vendor], [InvoiceDescription], [Employee], [Supplier], [Brand],
		 [ProgramType], [SupplierVendorName], [RemyClassification], [Patron_GL_Account], [Grant_Applicable], [Supplier_Coding], [Amount_Net], 
		 [Tax], [Total], [BillBack], [AP_Structure])
     
		SELECT [Record], [Month], [Date], [Province], [InvoiceNo], [Vendor], [InvoiceDescription], [Employee], [Supplier], [Brand],
		 [ProgramType], [SupplierVendorName], [RemyClassification], [Patron_GL_Account], [Grant_Applicable], [Supplier_Coding], [Amount_Net], 
		 [Tax], [Total], [BillBack], [AP_Structure]--, [IsStructure]
	FROM OPENJSON(@json)
	WITH (		
			 Record varchar(50)	'$.Record'
			,[Month] varchar(20)	'$.Month'
			,[Date] varchar(50)	'$.Date'
			,[Province] varchar(50)	'$.Province'
			--,[ExpenseType] varchar(200)	'$.ExpenseType'
			,[InvoiceNo] varchar(100)	'$.InvoiceNo'
			,[Vendor] varchar(200)	'$.Vendor'
			,[InvoiceDescription] varchar(500)	'$.InvoiceDescription'
			,[Employee] varchar(200)	'$.Employee'
			,[Supplier] varchar(200)	'$.Supplier'
			,[Brand] varchar(200)	'$.Brand'
			,[ProgramType] varchar(500)	'$.ProgramType'
			,[SupplierVendorName] varchar(200)	'$.SupplierVendorName'
			,[RemyClassification] varchar(200)	'$.RemyClassification'
			,[Patron_GL_Account] varchar(200)	'$.Patron_GL_Account'
			,[Grant_Applicable] varchar(10)	'$.Grant_Applicable'
			,[Supplier_Coding] varchar(200)	'$.Supplier_Coding'
			,[Amount_Net] varchar(50)	'$.Amount_Net'
			,[Tax] varchar(50)	'$.Tax'
			,[Total] varchar(50)	'$.Total'
			,[BillBack] varchar(200)	'$.BillBack'
			,[AP_Structure] varchar(50)	'$.AP_Structure'
		)
		
		--Add/Update in Expense table from expense_import
		MERGE dbo.Expense AS TC
		USING (
				  
				Select distinct Convert(bigint,Record) as	Record, Month, Date, P.Id as ProvinceId, InvoiceNo, 
				Vendor, InvoiceDescription, Employee,S.Id as SupplierId,-- S.SupplierCode as SupplierId,
				B.Id as BrandId,PT.Id as ProgramTypeId,S.LegalName as SupplierVendorName, RemyClassification, Patron_GL_Account, 
				Grant_Applicable, Supplier_Coding,
				(case when len(TP.Amount_Net) >0 then Amount_Net else null end) as Amount_Net ,
				(case when len(TP.Tax) >0 then Tax else null end) as Tax ,
				(case when len(TP.Total) >0 then Total else null end) as Total ,
				BillBack, AP_Structure						
				From dbo.Expense_Import TP 
				left join Province P on P.Code = TP.Province
				left Join dbo.Brand B On TP.Brand= B.BrandName
				left Join (select Id,LegalName from Supplier group by Id,LegalName) S On TP.SupplierVendorName=S.LegalName 									
				left join ProgramType PT on PT.ProgramType= TP.ProgramType

				group by Record, Month, Date, P.Id, InvoiceNo, Vendor, InvoiceDescription, 
				Employee, 
				S.Id,S.LegalName,
				B.Id ,PT.Id, RemyClassification, Patron_GL_Account, 
				Grant_Applicable, Supplier_Coding,
				(case when len(TP.Amount_Net) >0 then Amount_Net else null end) ,
				(case when len(TP.Tax) >0 then Tax else null end) ,
				(case when len(TP.Total) >0 then Total else null end) ,
				BillBack, AP_Structure						
			  ) AS SC 
		ON (TC.Record = SC.Record) 
		WHEN MATCHED 
			THEN UPDATE SET  TC.Record = SC.Record
							,TC.[Month] = SC.[Month]
							,TC.[Date] = try_parse(SC.[Date] as date)
							,TC.BrandId = SC.BrandId
							,TC.SupplierId	= SC.SupplierId		
							,TC.ProgramTypeId = SC.ProgramTypeId
							,TC.Amount_Net = try_parse(SC.Amount_Net As decimal(30,2))
							,TC.Tax = try_parse(SC.Tax As decimal(30,2))
							,TC.Total = try_parse(SC.Total As decimal(30,2))
							,TC.ProvinceId = SC.ProvinceId
							,TC.Vendor = SC.Vendor
							,TC.InvoiceNo = SC.InvoiceNo
							,TC.InvoiceDescription = SC.InvoiceDescription
							,TC.RemyClassification = SC.RemyClassification
							,TC.Patron_GL_Account = SC.Patron_GL_Account
							,TC.Grant_Applicable = (case when SC.Grant_Applicable = 'Yes' then 1 else null end)
							,TC.Supplier_Coding = SC.Supplier_Coding
							,TC.Bill_Back = SC.BillBack
							,TC.IsA_P = (case when SC.AP_Structure like '%A&P%' then SC.AP_Structure else null end)
							,TC.IsStructure =(case when SC.AP_Structure like '%structure%' or SC.AP_Structure like '%TBC%' then 
												SC.AP_Structure else null end)
							,TC.Employee = SC.Employee
							,TC.SupplierVendorName=SC.SupplierVendorName
							--,TC.ExpenseType=SC.ExpenseType
		WHEN NOT MATCHED BY TARGET
		THEN 
		INSERT ([Record], [Date], [BrandId], [SupplierId], [ProgramTypeId], [Amount_Net], [Tax], [Total], [Month], 
		[ProvinceId], [Vendor], [InvoiceNo], [InvoiceDescription], [RemyClassification], [Patron_GL_Account], [Grant_Applicable],
		[Supplier_Coding], [Bill_Back], IsA_P, [IsStructure], [Employee],SupplierVendorName)	

		VALUES (SC.Record,try_parse(SC.[Date] as date),SC.BrandId,SC.SupplierId,SC.ProgramTypeId,try_parse(SC.Amount_Net As decimal(30,2))
		,try_parse(SC.Tax As decimal(30,2)),try_parse(SC.Total As decimal(30,2)),SC.[Month],SC.ProvinceId,SC.Vendor,SC.InvoiceNo,
		SC.InvoiceDescription,SC.RemyClassification,SC.Patron_GL_Account,(case when SC.Grant_Applicable = 'Yes' then 1 else null end),
		SC.Supplier_Coding,SC.BillBack,(case when SC.AP_Structure like '%A&P%' then SC.AP_Structure else null end),
		(case when SC.AP_Structure like '%structure%' then SC.AP_Structure else null end),-- or SC.AP_Structure like '%TBC%'
		SC.Employee,SC.SupplierVendorName);

		COMMIT TRANSACTION
 END TRY
BEGIN CATCH        
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION 
		END
		
		-- Raise an error with the details of the exception
		DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
		--SELECT @ErrMsg = ERROR_MESSAGE(),
		--	 @ErrSeverity = ERROR_SEVERITY()

		RAISERROR(@ErrMsg, @ErrSeverity, 1)
	END CATCH
	
	RETURN @@ERROR	
End
