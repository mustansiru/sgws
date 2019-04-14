
Create proc [dbo].[USP_GetRoles]
(
 @UserID nvarchar(100) = ''
)
as
begin

	Select RoleName,RoleID from aspnet_Roles

end

