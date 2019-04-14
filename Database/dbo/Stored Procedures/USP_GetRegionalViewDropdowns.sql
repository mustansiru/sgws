USE [dev-promoplan]
GO
/****** Object:  StoredProcedure [dbo].[USP_GetRegionalViewDropdowns]    Script Date: 4/11/2019 3:32:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[USP_GetRegionalViewDropdowns]
As
Begin
	SET NOCOUNT ON;

	Select Year From dbo.SGWSFiscal With(Nolock) Group By Year
	Select Id,Province From dbo.Province With(Nolock) order by Province
	Select Id,Category From dbo.Category order by Category
	
	Select Id,SupplierName From dbo.Supplier where Active=1 
	Group by Id,SupplierName order by SupplierName

	Select B.Id,BrandName,S.Id SupplierId 
	From dbo.Brand B With(Nolock) 
	Inner Join dbo.Supplier S With (Nolock) On B.SupplierCode = S.SupplierCode
	Order By BrandName
	
	--Select Id,Period From dbo.SGWSFiscal With(Nolock) 
	Select Period From FiscalYearByLiquorBoard With(Nolock)
	Where Period Is Not Null
	Group by Period
	Order By Period

	Select Id,Code From dbo.ProgramStatus With(Nolock)

End


