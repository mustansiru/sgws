USE [dev-promoplan]
GO

/****** Object:  StoredProcedure [dbo].[GetCalendarView]    Script Date: 4/3/2019 4:21:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCalendarView] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @RowNum bigint
	declare @Code varchar(10)
	declare @Year int
	declare @Period varchar(50)
	declare @BrandName varchar(500)
	declare @AlternateName varchar(100)
	declare @ContainerVolume int
	declare @IsBrandBased bit
	declare @IsSkuBased bit
	declare @ProgramType varchar(200)
	declare @ProgramName varchar(500)

	declare @View Table (
	 Code varchar(10),
	 Year int,
	 BrandName varchar(500),
	 AlternateName varchar(100),
	 ContainerVolume int,
	 SKUSpecific varchar(20),
	 ProgramType varchar(200),
	 P01 varchar(50),
	 P02 varchar(50),
	 P03 varchar(50),
	 P04 varchar(50),
	 P05 varchar(50),
	 P06 varchar(50),
	 P07 varchar(50),
	 P08 varchar(50),
	 P09 varchar(50),
	 P10 varchar(50),
	 P11 varchar(50),
	 P12 varchar(50),
	 P13 varchar(50)
)

	declare cCal cursor forward_only for
	Select ROW_NUMBER() OVER ( ORDER BY P.Id ) AS RowNum, PV.Code, SF.Year, SF.Period, B.BrandName, PR.AlternateName, PD.ContainerVolume, SP.IsBrandBased, SP.IsSkuBased, PT.ProgramType, SP.SuperProgramName
	From dbo.Program P With(Nolock)
	Left Join dbo.SuperProgram SP With(Nolock) On P.SuperProgramId = SP.Id
	Left Join dbo.Program_ATL_BTL AB With(Nolock) On P.AboveTheLineBelowTheLine = AB.Id
	Left Join dbo.ProgramStatus PS With(Nolock) On P.ProgramStatusId = PS.Id
	Left Join dbo.ProgramType PT With(Nolock) On P.ProgramTypeId = PT.Id
	Left Join dbo.FiscalYearByLiquorBoard FY With(Nolock) On SP.FiscalYearByLiquorBoardId = FY.Id
	Left Join dbo.BusinessType BT With(Nolock) On SP.BusinessTypeId = BT.Id
	Left Join dbo.Province PV With(Nolock) On SP.ProvinceId = PV.Id
	Inner Join dbo.ProgramCost PC With(Nolock) On P.Id = PC.ProgramId
	Left Join dbo.Product PR With(Nolock) On SP.GID = PR.GID
	Inner Join dbo.ProductDetails PD With(Nolock) ON PR.Id = PD.Id
	Left Join dbo.SGWSFiscal SF With(Nolock) On SP.SGWSFiscalId = SF.Id 
	Left Join dbo.UserProvince UP With(Nolock) On UP.ProvinceId = SP.ProvinceId
	Left Join dbo.UserSupplier US With(Nolock) On US.SupplierId = PR.SupplierId
	Left Join dbo.UserBusinessType UB With(Nolock) On UB.BusinessTypeId = SP.BusinessTypeId
	Left Join dbo.Users U With(Nolock) On U.UserId = UP.UserId Or US.UserId = U.UserId Or U.UserId = UB.UserId
	Inner Join dbo.Brand B With(Nolock) ON PR.BrandId = B.Id

	open cCal
	fetch next from cCal into @RowNum, @Code, @Year, @Period, @BrandName, @AlternateName, @ContainerVolume, @IsBrandBased, @IsSkuBased, @ProgramType, @ProgramName
	while @@FETCH_STATUS = 0
	begin
		declare @SKU varchar(20)
		declare @P01 varchar(50)
		declare @P02 varchar(50)
		declare @P03 varchar(50)
		declare @P04 varchar(50)
		declare @P05 varchar(50)
		declare @P06 varchar(50)
		declare @P07 varchar(50)
		declare @P08 varchar(50)
		declare @P09 varchar(50)
		declare @P10 varchar(50)
		declare @P11 varchar(50)
		declare @P12 varchar(50)
		declare @P13 varchar(50)

		if @IsBrandBased = 1
			set @SKU = 'Brand Specific'
		else
			set @SKU = 'SKU Specific'

		set @P01 = case when @Period = 'P01' then @ProgramName end
		set @P02 = case when @Period = 'P02' then @ProgramName end
		set @P03 = case when @Period = 'P03' then @ProgramName end
		set @P04 = case when @Period = 'P04' then @ProgramName end
		set @P05 = case when @Period = 'P05' then @ProgramName end
		set @P06 = case when @Period = 'P06' then @ProgramName end
		set @P07 = case when @Period = 'P07' then @ProgramName end
		set @P08 = case when @Period = 'P08' then @ProgramName end
		set @P09 = case when @Period = 'P09' then @ProgramName end
		set @P10 = case when @Period = 'P10' then @ProgramName end
		set @P11 = case when @Period = 'P11' then @ProgramName end
		set @P12 = case when @Period = 'P12' then @ProgramName end
		set @P13 = case when @Period = 'P13' then @ProgramName end

		insert into @View (Code, Year, BrandName, AlternateName, ContainerVolume, SKUSpecific, ProgramType, P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12, P13)
		values (@Code, @Year, @BrandName, @AlternateName, @ContainerVolume, @SKU, @ProgramType, @P01, @P02, @P03, @P04, @P05, @P06, @P07, @P08, @P09, @P10, @P11, @P12, @P13)

		fetch next from cCal into @RowNum, @Code, @Year, @Period, @BrandName, @AlternateName, @ContainerVolume, @IsBrandBased, @IsSkuBased, @ProgramType, @ProgramName
	end
	close cCal
	deallocate cCal

	select * from @View
END
GO


