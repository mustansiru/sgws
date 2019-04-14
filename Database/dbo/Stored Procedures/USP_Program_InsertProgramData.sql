CREATE Proc [dbo].[USP_Program_InsertProgramData]
(   
    @json NVARCHAR(max),
	@FileName NVARCHAR(500),
	@UserId uniqueidentifier
)
AS
Begin
	SET NOCOUNT ON
	DECLARE @ErrorMessage NVARCHAR(4000) = 'success';
    DECLARE @ErrorSeverity INT = 0;
    DECLARE @ErrorState INT = 0;
	Declare @Process varchar(30) = '';

	Declare @FileInfoId Bigint 
	--Truncate Table dbo.Tmp_ParseError
	BEGIN TRY

	--Insert Into dbo.FileInfo Values(@FileName,@UserId,GetDate(),0)
	--Select @FileInfoId = SCOPE_IDENTITY()

	Select @Process = 'TMP_ProgramImport';
	MERGE dbo.TMP_ProgramImport AS T
    USING (
    --Insert Into dbo.TMP_ProgramImport
		SELECT
		distinct
		ProvinceCode
		,SGWS_Calendar_Year
		,SGWS_Calendar_Period
		,Liquor_Board_Period
		,Start_Date
		,End_Date
		,GID
		,Is_SKU_Brand
		,CSPC
		,ProgramType
		,Comments
		,ATL_BTL
		,Program_Status
		,Depth
		,ForecastCaseSalesBase
		,ForecastCaseSalesLift
		,ForecastTotalCaseSalesPhysCs
		,ForecastTotalCaseSales9LCsConverted
		,VariableCostPerCase
		,UpforntFees_LTO_BAM
		,RedemptionBAM
		,SpendQuantity
		,SpendPerQuantity
		,OtherFixedCost
		,TotalProgramSpend
		,Actual_Spend
		,Actual_Volume
		,UniqueID
	FROM OPENJSON(@json)
	WITH (		
		ProvinceCode varchar(50)   '$.ProvinceCode'
		,SGWS_Calendar_Year varchar(10)   '$.SGWS_Calendar_Year'
		,SGWS_Calendar_Period varchar(50)   '$.SGWS_Calendar_Period'
		,Liquor_Board_Period varchar(50)   '$.Liquor_Board_Period'
		,Start_Date varchar(10)   '$.Start_Date'
		,End_Date varchar(10)   '$.End_Date'
		,GID varchar(50)   '$.GID'
		,Is_SKU_Brand varchar(50)   '$.Is_SKU_Brand'
		,CSPC varchar(50)   '$.CSPC'
		,ProgramType varchar(50)   '$.ProgramType'
		,Comments varchar(1000)   '$.Comments'
		,ATL_BTL varchar(50)   '$.ATL_BTL'
		,Program_Status varchar(50)   '$.Program_Status'
		,Depth varchar(50)   '$.Depth'
		,ForecastCaseSalesBase varchar(50)   '$.ForecastCaseSalesBase'
		,ForecastCaseSalesLift varchar(50)   '$.ForecastCaseSalesLift'
		,ForecastTotalCaseSalesPhysCs varchar(50)   '$.ForecastTotalCaseSalesPhysCs'
		,ForecastTotalCaseSales9LCsConverted varchar(50)   '$.ForecastTotalCaseSales9LCsConverted'
		,VariableCostPerCase varchar(50)   '$.VariableCostPerCase'
		,UpforntFees_LTO_BAM varchar(50)   '$.UpforntFees_LTO_BAM'
		,RedemptionBAM varchar(50)   '$.RedemptionBAM'
		,SpendQuantity varchar(50)   '$.SpendQuantity'
		,SpendPerQuantity varchar(50)   '$.SpendPerQuantity'
		,OtherFixedCost varchar(50)   '$.OtherFixedCost'
		,TotalProgramSpend varchar(50)   '$.TotalProgramSpend'
		,Actual_Spend varchar(50)   '$.Actual_Spend'
		,Actual_Volume varchar(50)   '$.Actual_Volume'
		,UniqueID varchar(50)   '$.UniqueID'
	)) S
	ON (T.GID = S.GID And T.ProvinceCode   =   S.ProvinceCode  
					  And T.SGWS_Calendar_Year = S.SGWS_Calendar_Year 
					  And T.SGWS_Calendar_Period = S.SGWS_Calendar_Period 
					  And S.Start_Date = T.Start_Date And S.End_Date = T.End_Date
					  And T.ProgramType = S.ProgramType
					  And T.Comments = S.Comments
					  And T.ATL_BTL = S.ATL_BTL
					  And T.Program_Status = S.Program_Status
					  And T.Depth = S.Depth
					  And T.ForecastCaseSalesBase = S.ForecastCaseSalesBase
					  And T.UniqueID = S.UniqueID
					  ) 
	WHEN MATCHED 
		THEN UPDATE SET	
			T.ProvinceCode   =   S.ProvinceCode
			,T.SGWS_Calendar_Year   =   S.SGWS_Calendar_Year
			,T.SGWS_Calendar_Period   =   S.SGWS_Calendar_Period
			,T.Liquor_Board_Period   =   S.Liquor_Board_Period
			,T.Start_Date   =   S.Start_Date
			,T.End_Date   =   S.End_Date
			,T.GID   =   S.GID
			,T.Is_SKU_Brand   =   S.Is_SKU_Brand
			,T.CSPC   =   S.CSPC
			,T.ProgramType   =   S.ProgramType
			,T.Comments   =   S.Comments
			,T.ATL_BTL   =   S.ATL_BTL
			,T.Program_Status   =   S.Program_Status
			,T.Depth   =   S.Depth
			,T.ForecastCaseSalesBase   =   S.ForecastCaseSalesBase
			,T.ForecastCaseSalesLift   =   S.ForecastCaseSalesLift
			,T.ForecastTotalCaseSalesPhysCs   =   S.ForecastTotalCaseSalesPhysCs
			,T.ForecastTotalCaseSales9LCsConverted   =   S.ForecastTotalCaseSales9LCsConverted
			,T.VariableCostPerCase   =   S.VariableCostPerCase
			,T.UpforntFees_LTO_BAM   =   S.UpforntFees_LTO_BAM
			,T.RedemptionBAM   =   S.RedemptionBAM
			,T.SpendQuantity   =   S.SpendQuantity
			,T.SpendPerQuantity   =   S.SpendPerQuantity
			,T.OtherFixedCost   =   S.OtherFixedCost
			,T.TotalProgramSpend   =   S.TotalProgramSpend
			,T.Actual_Spend   =   S.Actual_Spend
			,T.Actual_Volume   =   S.Actual_Volume
			,T.UniqueID   =   S.UniqueID
			WHEN NOT MATCHED BY TARGET
	THEN INSERT (
	ProvinceCode
		,SGWS_Calendar_Year
		,SGWS_Calendar_Period
		,Liquor_Board_Period
		,Start_Date
		,End_Date
		,GID
		,Is_SKU_Brand
		,CSPC
		,ProgramType
		,Comments
		,ATL_BTL
		,Program_Status
		,Depth
		,ForecastCaseSalesBase
		,ForecastCaseSalesLift
		,ForecastTotalCaseSalesPhysCs
		,ForecastTotalCaseSales9LCsConverted
		,VariableCostPerCase
		,UpforntFees_LTO_BAM
		,RedemptionBAM
		,SpendQuantity
		,SpendPerQuantity
		,OtherFixedCost
		,TotalProgramSpend
		,Actual_Spend
		,Actual_Volume
		,UniqueID
	)
	Values
	(
		S.ProvinceCode
		,S.SGWS_Calendar_Year
		,S.SGWS_Calendar_Period
		,S.Liquor_Board_Period
		,S.Start_Date
		,S.End_Date
		,S.GID
		,S.Is_SKU_Brand
		,S.CSPC
		,S.ProgramType
		,S.Comments
		,S.ATL_BTL
		,S.Program_Status
		,S.Depth
		,S.ForecastCaseSalesBase
		,S.ForecastCaseSalesLift
		,S.ForecastTotalCaseSalesPhysCs
		,S.ForecastTotalCaseSales9LCsConverted
		,S.VariableCostPerCase
		,S.UpforntFees_LTO_BAM
		,S.RedemptionBAM
		,S.SpendQuantity
		,S.SpendPerQuantity
		,S.OtherFixedCost
		,S.TotalProgramSpend
		,S.Actual_Spend
		,S.Actual_Volume
		,S.UniqueID
	);
	
	Select @Process = 'SuperProgram';	
	MERGE dbo.SuperProgram AS T
    USING (
			Select * From (
			Select distinct TMP.GID,Start_Date,End_Date,SGWS_Calendar_Year,P.Id ProvinceId,TMP.ProvinceCode			
			, LB.Id LiquorBoardId
			,SF.Id SGWSFiscalId
			,FY.Id FiscalYearByLiquorBoardId
			,Case When TMP.Is_SKU_Brand = 'SKU Specific' Then 1 Else 0 End IsSkuBased
			,Case When TMP.Is_SKU_Brand = 'SKU Specific' Then 0 Else 1 End IsBrandBased
			From dbo.TMP_ProgramImport TMP With(Nolock)
			Left Join dbo.Province P On TMP.ProvinceCode = P.Code
			Left Join dbo.LiquorBoard LB On LB.ProvinceId = P.Id
			Left Join dbo.SGWSFiscal SF On Cast(TMP.SGWS_Calendar_Year As Int) = SF.Year 
										And SUBSTRING(Replace( Replace(SGWS_Calendar_Period,')',''),'(',''),5,10)  = SF.Period 
			
			Left Join dbo.FiscalYearByLiquorBoard FY On FY.SGWSFiscalId = SF.Id And FY.LiquorBoardId = LB.Id
			--Left Join dbo.SuperProgram SP With(Nolock) On SP.FiscalYearByLiquorBoardId = FY.Id 
			--													And SP.GID = TMP.GID
			--													And SP.ProvinceId = P.Id
			--													And SP.SGWSFiscalId = SF.Id
			--													And convert(varchar(10), SP.StartDate, 112) = TMP.Start_Date
			--													And convert(varchar(10), SP.EndDate, 112) = TMP.End_Date
			--													And (Case When TMP.Is_SKU_Brand = 'SKU Specific' Then 1 Else 0 End) = SP.IsSkuBased
			--													And (Case When TMP.Is_SKU_Brand <> 'SKU Specific' Then 1 Else 0 End) = SP.IsBrandBased
			) A
			Where FiscalYearByLiquorBoardId Is Not Null		
						
		  ) AS S 
	ON (T.GID = S.GID And T.FiscalYearByLiquorBoardId = S.FiscalYearByLiquorBoardId
					  And convert(varchar, T.StartDate, 112) = S.Start_Date
					  And convert(varchar, T.EndDate, 112) = S.End_Date
					  And T.SGWSFiscalId = S.SGWSFiscalId
					  ) 
	WHEN MATCHED 
		THEN UPDATE SET T.StartDate = TRY_CONVERT(DateTime, Start_Date, 104)
						,T.EndDate = TRY_CONVERT(DateTime, End_Date, 104)
						,T.IsSkuBased = S.IsSkuBased
						,T.IsBrandBased = S.IsBrandBased
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (SuperProgramName,SGWSFiscalId,StartDate,EndDate,FiscalYearByLiquorBoardId,GID,IsSkuBased,IsBrandBased
				,ProvinceId,BusinessTypeId,IsOverrideDate)	
	VALUES (S.SGWS_Calendar_Year + ' ' + S.ProvinceCode + ' ' + S.Start_Date + '/' + S.End_Date, S.SGWSFiscalId
			, TRY_CONVERT(DateTime, S.Start_Date, 104)
			, TRY_CONVERT(DateTime, S.End_Date, 104)
			,S.FiscalYearByLiquorBoardId
			,S.GID,S.IsSkuBased,S.IsBrandBased,S.ProvinceId,Null,0
			);

	Select @Process = 'Program';
	MERGE dbo.Program AS T
    USING (
			Select * From (
			Select TMP.GID,SP.Id SuperProgramId, PS.Id ProgramStatusId
					, AB.Id ATL_BTL_Id, PT.Id ProgramTypeId
					,TMP.Comments,FY.Id As FiscalYearByLiquorBoardId
			From dbo.TMP_ProgramImport TMP With(Nolock)
			Left Join dbo.Province P On TMP.ProvinceCode = P.Code
			Left Join dbo.LiquorBoard LB On LB.ProvinceId = P.Id
			Left Join dbo.SGWSFiscal SF On Cast(TMP.SGWS_Calendar_Year As Int) = SF.Year 
										And SUBSTRING(Replace( Replace(SGWS_Calendar_Period,')',''),'(',''),5,10)  = SF.Period 
			
			Left Join dbo.FiscalYearByLiquorBoard FY On FY.SGWSFiscalId = SF.Id And FY.LiquorBoardId = LB.Id	
			Left Join dbo.ProgramType PT With(Nolock) On TMP.ProgramType = PT.ProgramType
			Left Join dbo.ProgramStatus PS With(Nolock) On PS.Code = TMP.Program_Status
			Left Join dbo.Program_ATL_BTL AB With(Nolock) On TMP.ATL_BTL = AB.Name
			Left Join dbo.SuperProgram SP With(Nolock) On SP.FiscalYearByLiquorBoardId = FY.Id 
																And SP.GID = TMP.GID
																And SP.ProvinceId = P.Id
																And SP.SGWSFiscalId = SF.Id
																And convert(varchar(10), SP.StartDate, 112) = TMP.Start_Date
																And convert(varchar(10), SP.EndDate, 112) = TMP.End_Date
																And (Case When TMP.Is_SKU_Brand = 'SKU Specific' Then 1 Else 0 End) = SP.IsSkuBased
																And (Case When TMP.Is_SKU_Brand <> 'SKU Specific' Then 1 Else 0 End) = SP.IsBrandBased
			) A Where A.FiscalYearByLiquorBoardId Is Not Null And SuperProgramId Is Not Null
						
		  ) AS S 
	ON (  
		  T.SuperProgramId = S.SuperProgramId 
			And T.ProgramStatusId = S.ProgramStatusId 
			And T.AboveTheLineBelowTheLine = S.ATL_BTL_Id
			And T.ProgramTypeId = S.ProgramTypeId			
	    ) 
	WHEN MATCHED 
		THEN UPDATE SET T.Comment = S.Comments
						,T.ProgramStatusId = S.ProgramStatusId
						,T.AboveTheLineBelowTheLine = S.ATL_BTL_Id
						,T.ProgramTypeId = S.ProgramTypeId
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (SuperProgramId,ProgramTypeName,Comment,ProgramStatusId,AboveTheLineBelowTheLine,ProgramTypeId)	
	VALUES (S.SuperProgramId, '',S.Comments,S.ProgramStatusId,S.ATL_BTL_Id,S.ProgramTypeId);
	
	Select @Process = 'ProgramCost';
	MERGE dbo.ProgramCost AS T
    USING (
			Select * From (
			Select PR.Id ProgramId,FY.Id FiscalYearByLiquorBoardId
					,Cast(dbo.GetNumbers(TMP.Depth) As Money) Depth
					,Cast(dbo.GetNumbers(TMP.ForecastCaseSalesBase) As Money) ForecastCaseSalesBase
					,Cast(dbo.GetNumbers(TMP.ForecastCaseSalesLift) As Money) ForecastCaseSalesLift
					,Cast(dbo.GetNumbers(TMP.ForecastTotalCaseSalesPhysCs) As Money) ForecastTotalCaseSalesPhysCs
					,Cast(dbo.GetNumbers(TMP.ForecastTotalCaseSales9LCsConverted) As Money) ForecastTotalCaseSales9LCsConverted
					,Cast(dbo.GetNumbers(TMP.VariableCostPerCase) As Money) VariableCostPerCase
					,Cast(dbo.GetNumbers(TMP.UpforntFees_LTO_BAM) As Money) UpforntFees_LTO_BAM
					,Cast(dbo.GetNumbers(TMP.RedemptionBAM) As Money) RedemptionBAM
					,Cast(dbo.GetNumbers(TMP.SpendQuantity) As Money) SpendQuantity
					,Cast(dbo.GetNumbers(TMP.SpendPerQuantity) As Money) SpendPerQuantity
					,Cast(dbo.GetNumbers(TMP.OtherFixedCost) As Money) OtherFixedCost
					,Cast(dbo.GetNumbers(TMP.TotalProgramSpend) As Money) TotalProgramSpend
			From dbo.TMP_ProgramImport TMP With(Nolock)
			Left Join dbo.Province P On TMP.ProvinceCode = P.Code
			Left Join dbo.LiquorBoard LB On LB.ProvinceId = P.Id
			Left Join dbo.SGWSFiscal SF On Cast(TMP.SGWS_Calendar_Year As Int) = SF.Year 
										And SUBSTRING(Replace( Replace(SGWS_Calendar_Period,')',''),'(',''),5,10)  = SF.Period 
			
			Left Join dbo.FiscalYearByLiquorBoard FY On FY.SGWSFiscalId = SF.Id And FY.LiquorBoardId = LB.Id	
			Left Join dbo.ProgramType PT With(Nolock) On TMP.ProgramType = PT.ProgramType
			Left Join dbo.ProgramStatus PS With(Nolock) On PS.Code = TMP.Program_Status
			Left Join dbo.Program_ATL_BTL AB With(Nolock) On TMP.ATL_BTL = AB.Name
			Left Join dbo.SuperProgram SP With(Nolock) On SP.FiscalYearByLiquorBoardId = FY.Id 
																And SP.GID = TMP.GID
																And SP.ProvinceId = P.Id
																And SP.SGWSFiscalId = SF.Id
																And convert(varchar(10), SP.StartDate, 112) = TMP.Start_Date
																And convert(varchar(10), SP.EndDate, 112) = TMP.End_Date
																And (Case When TMP.Is_SKU_Brand = 'SKU Specific' Then 1 Else 0 End) = SP.IsSkuBased
																And (Case When TMP.Is_SKU_Brand <> 'SKU Specific' Then 1 Else 0 End) = SP.IsBrandBased
			Left Join dbo.Program PR With(Nolock) On SP.Id = PR.SuperProgramId

			) A Where A.FiscalYearByLiquorBoardId Is Not Null
						
		  ) AS S 
	ON (  
		    T.ProgramId = S.ProgramId 
			And T.Depth = S.Depth 
			And T.ForecastCaseSalesLift = S.ForecastCaseSalesLift
			And T.ForecastTotalCaseSalesPhysCs = S.ForecastTotalCaseSalesPhysCs
			And T.ForecastTotalCaseSales9LCsConverted = S.ForecastTotalCaseSales9LCsConverted
			And T.VariableCostPerCase = S.VariableCostPerCase
			And T.UpforntFees_LTO_BAM = S.UpforntFees_LTO_BAM
			And T.RedemptionBAM = S.RedemptionBAM
			And T.SpendQuantity = S.SpendQuantity
			And T.SpendPerQuantity = S.SpendPerQuantity
			And T.OtherFixedCost = S.OtherFixedCost
			And T.TotalProgramSpend = S.TotalProgramSpend
	    ) 
	WHEN MATCHED 
		THEN UPDATE SET T.ProgramId = S.ProgramId 
			, T.Depth = S.Depth 
			, T.ForecastCaseSalesBase = S.ForecastCaseSalesBase
			, T.ForecastCaseSalesLift = S.ForecastCaseSalesLift
			, T.ForecastTotalCaseSalesPhysCs = S.ForecastTotalCaseSalesPhysCs
			, T.ForecastTotalCaseSales9LCsConverted = S.ForecastTotalCaseSales9LCsConverted
			, T.VariableCostPerCase = S.VariableCostPerCase
			, T.UpforntFees_LTO_BAM = S.UpforntFees_LTO_BAM
			, T.RedemptionBAM = S.RedemptionBAM
			, T.SpendQuantity = S.SpendQuantity
			, T.SpendPerQuantity = S.SpendPerQuantity
			, T.OtherFixedCost = S.OtherFixedCost
			, T.TotalProgramSpend = S.TotalProgramSpend
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (ProgramId,Depth,ForecastCaseSalesBase,ForecastCaseSalesLift,ForecastTotalCaseSalesPhysCs,ForecastTotalCaseSales9LCsConverted,
					VariableCostPerCase,UpforntFees_LTO_BAM,RedemptionBAM,SpendQuantity,SpendPerQuantity,OtherFixedCost,TotalProgramSpend)	
	VALUES (S.ProgramId,S.ForecastCaseSalesBase,S.Depth,S.ForecastCaseSalesLift,S.ForecastTotalCaseSalesPhysCs,S.ForecastTotalCaseSales9LCsConverted,
					S.VariableCostPerCase,S.UpforntFees_LTO_BAM,S.RedemptionBAM,S.SpendQuantity,S.SpendPerQuantity,S.OtherFixedCost,S.TotalProgramSpend);
	
	END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = 'Process: '+  @Process + ', ' + ERROR_MESSAGE() ,
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

   
END CATCH;

SELECT @ErrorMessage ErrorMessage, @ErrorSeverity ErrorSeverity, @ErrorState ErrorState;
End
