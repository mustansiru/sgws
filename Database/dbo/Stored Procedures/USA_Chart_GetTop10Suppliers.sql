
create proc [dbo].[USA_Chart_GetTop10Suppliers]
As
Begin
		SET NOCOUNT ON;
		Select Top 10 Count(1) Total,A.SupplierName
		From
			(
				Select P.GID,S.SupplierName
				From dbo.Product P With (Nolock)
				Inner Join dbo.Supplier S With (Nolock) On P.SupplierCode = S.SupplierCode
				Group By P.GID,S.SupplierCode,S.SupplierName
			) A
		Group By A.SupplierName
		Order By Total Desc
End
