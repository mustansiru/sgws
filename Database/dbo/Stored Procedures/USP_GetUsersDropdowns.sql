
Create proc [dbo].[USP_GetUsersDropdowns]
As
Begin
	SET NOCOUNT ON;

	Select RoleID,RoleName From dbo.aspnet_Roles With(Nolock) 
	
	Select Id,SupplierName From dbo.Supplier where Active=1 
	Group by Id,SupplierName
	
	Select Id,Province From dbo.Province With(Nolock)

	Select Id,BusinessType From dbo.BusinessType
		
	Select Id,BrandName From dbo.Brand With(Nolock) 
	Order By BrandName
		
End
