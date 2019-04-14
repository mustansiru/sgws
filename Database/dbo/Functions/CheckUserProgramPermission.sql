﻿
Create FUNCTION  [dbo].[CheckUserProgramPermission] 
(
	@UserId UniqueIdentifier,
	@SuperProgramId bigint
)
RETURNS bit
AS
BEGIN
	Declare @total Int = 0;

If (Select top 1 R.RoleName From 
			dbo.aspnet_Roles R With(Nolock)
			Inner Join dbo.aspnet_UsersInRoles UR With(Nolock) On R.RoleId = UR.RoleId 
			Where UR.UserId = @UserId) = 'Admin'
	Begin
		Select @total = 1
	End
Else
	Begin
		Select @total = count(SP.Id)
		From dbo.SuperProgram SP
		Left Join dbo.UserProvince UP With(Nolock) On UP.ProvinceId = SP.ProvinceId
		Left Join dbo.Product PR With (Nolock) On SP.GID = PR.GID
		Left Join dbo.UserSupplier US With(Nolock) On US.SupplierId = PR.SupplierId
		Left Join dbo.UserBusinessType UB With(Nolock) On UB.BusinessTypeId = SP.BusinessTypeId
		Left Join dbo.UserBrand B With(Nolock) On B.BrandId = PR.BrandId
		Left Join dbo.Users U With(Nolock) On U.UserId = UP.UserId Or US.UserId = U.UserId Or U.UserId = UB.UserId Or U.UserId = B.UserId 
		Where SP.Id = @SuperProgramId And U.UserId = @UserId
		If(@total > 0)
			Select @total = 1;
		Else
			Select @total = 0;
	End
	return @total;
END



