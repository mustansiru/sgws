
create proc [dbo].[USP_Delete_Record]
(
  @UserId nvarchar(300) = null
)
As
Begin

	delete from aspnet_UsersInRoles where  UserId = @UserId
	delete from aspnet_Membership where  UserId = @UserId
	delete from aspnet_users where  UserId = @UserId
	delete from Users where  UserId = @UserId
	
	
End
