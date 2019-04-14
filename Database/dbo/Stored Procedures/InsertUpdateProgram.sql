CREATE proc [dbo].[InsertUpdateProgram] --0,0,0,1,2,'sp1',2016,'p01','3/1/2019 12:00:00','3/1/2019 12:00:00',1,'S100703',1,0,1,'p1','test',3,1,2,3,4,5,6,7,8,9,10,11
(
	@ProgramId bigint =0,
	@SuperProgramId bigint =0,
	@ProgramCostId bigint =0,	
	@ProgramTypeId bigint =0,
	@ProgramTypeName varchar(200) =null,
	@Comment varchar(max) =null,
	@ProgramStatusId int =0,
	@ATL_BTL int =0,
	@Depth money=null,
	@ForecastCaseSalesBase money=null, 
	@ForecastCaseSalesLift money=null, 
	@ForecastTotalCaseSalesPhysCs money=null, 
	@ForecastTotalCaseSales9LCsConverted money=null, 
	@VariableCostPerCase money=null, 
	@UpforntFees_LTO_BAM money=null, 
	@RedemptionBAM money=null, 
	@SpendQuantity money=null,
	@SpendPerQuantity money=null, 
	@OtherFixedCost money=null,
	@TotalProgramSpend money =null
)
As 
Begin
begin try
begin transaction

	declare @_SuperProgramId bigint=@SuperProgramId
	declare @_ProgramId bigint=0
	
	
	if(@_SuperProgramId>0)
	begin
		if(@ProgramId>0)
		begin
			update Program set ProgramTypeName=@ProgramTypeName, Comment=@Comment, ProgramStatusId=@ProgramStatusId,
			AboveTheLineBelowTheLine=@ATL_BTL, ModifiedDate=GetDATE(), ProgramTypeId=@ProgramTypeId
			where Id=@ProgramId

			set @_ProgramId=@ProgramId
			
			update ProgramCost set Depth=@Depth, ForecastCaseSalesBase=@ForecastCaseSalesBase, ForecastCaseSalesLift=@ForecastCaseSalesLift,
			ForecastTotalCaseSalesPhysCs=@ForecastTotalCaseSalesPhysCs,ForecastTotalCaseSales9LCsConverted=@ForecastTotalCaseSales9LCsConverted,
			VariableCostPerCase=@VariableCostPerCase, UpforntFees_LTO_BAM=@UpforntFees_LTO_BAM, RedemptionBAM=@RedemptionBAM, 
			SpendQuantity=@SpendQuantity, SpendPerQuantity=@SpendPerQuantity, OtherFixedCost=@OtherFixedCost,
			TotalProgramSpend= @TotalProgramSpend
			--(@Depth+@ForecastCaseSalesBase+@ForecastCaseSalesLift+@ForecastTotalCaseSalesPhysCs+@ForecastTotalCaseSales9LCsConverted+@VariableCostPerCase+
			--@UpforntFees_LTO_BAM+@RedemptionBAM+@SpendQuantity+@SpendPerQuantity+@OtherFixedCost)
			where ProgramId=@_ProgramId
		end
		else
		begin
			
			insert into Program (SuperProgramId, ProgramTypeName, Comment, ProgramStatusId, AboveTheLineBelowTheLine, CreatedDate,ProgramTypeId)
			--output inserted.Id
			values(@_SuperProgramId,@ProgramTypeName,@Comment,@ProgramStatusId,@ATL_BTL,GetDATE(),@ProgramTypeId)

			set @_ProgramId=@@IDENTITY;

			--print(@_ProgramId)

			insert into ProgramCost (ProgramId, Depth, ForecastCaseSalesBase, ForecastCaseSalesLift, ForecastTotalCaseSalesPhysCs, 
			ForecastTotalCaseSales9LCsConverted, VariableCostPerCase, UpforntFees_LTO_BAM, RedemptionBAM, SpendQuantity, SpendPerQuantity, 
			OtherFixedCost,TotalProgramSpend)
			values(@_ProgramId,@Depth,@ForecastCaseSalesBase,@ForecastCaseSalesLift,@ForecastTotalCaseSalesPhysCs,
			@ForecastTotalCaseSales9LCsConverted,@VariableCostPerCase,@UpforntFees_LTO_BAM,@RedemptionBAM,@SpendQuantity,
			@SpendPerQuantity,@OtherFixedCost,@TotalProgramSpend)
			--(@Depth+@ForecastCaseSalesBase+@ForecastCaseSalesLift+@ForecastTotalCaseSalesPhysCs+@ForecastTotalCaseSales9LCsConverted+@VariableCostPerCase+
			--@UpforntFees_LTO_BAM+@RedemptionBAM+@SpendQuantity+@SpendPerQuantity+@OtherFixedCost))
		
		end
	end

	COMMIT TRANSACTION

	------------------------------------------------------------
	--select @_SuperProgramId as SuperProgramId,@_ProgramId as ProgramId

	select P.Id as ProgramId, P.ProgramTypeName,PT.ProgramType,AB.Name as ATL_BTL,S.Code as ProgramStatus,P.Comment
	,PC.Depth,Pc.ForecastCaseSalesBase,Pc.ForecastCaseSalesLift,Pc.ForecastTotalCaseSalesPhysCs,Pc.ForecastTotalCaseSales9LCsConverted
	,PC.VariableCostPerCase,Pc.UpforntFees_LTO_BAM,Pc.RedemptionBAM,Pc.SpendQuantity,PC.SpendPerQuantity,PC.OtherFixedCost,
	PC.TotalProgramSpend
	from Program P inner join ProgramType PT on PT.Id=P.ProgramTypeId 
	inner join ProgramStatus S on S.id =P.ProgramStatusId 
	inner join ProgramCost PC on PC.ProgramId=P.Id
	left outer join Program_ATL_BTL AB on AB.Id=P.AboveTheLineBelowTheLine
	where SuperProgramId=@_SuperProgramId

	--select TotalProgramSpend
	--from  ProgramCost PC where ProgramId=@_ProgramId
	------------------------------------------------------------

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
