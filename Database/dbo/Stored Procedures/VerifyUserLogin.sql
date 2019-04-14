
CREATE proc [dbo].[VerifyUserLogin]  --'corey.cona@clairifi.com'--'rohit.zend@greenlightconsulting.com'

(

  @UserName nvarchar(200) = 'devTeamAdmin@gmail.com'

)

as

begin
	SET NOCOUNT ON
 Select U.UserId,U.Email,UR.RoleId,R.RoleName, I.FirstName, I.LastName
 From aspnet_Membership  as U With (Nolock)
 Inner Join aspnet_UsersInRoles  as UR With (Nolock) on U.UserId = UR.UserId  
 Inner Join aspnet_Roles R With (Nolock) On UR.RoleId = R.RoleId
 Inner Join dbo.Users I With (Nolock) On U.UserId = I.UserId
 where U.Email = @UserName


end



