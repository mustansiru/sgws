CREATE proc [dbo].[CheckEmailIDExistUser] --'Test@gmail.com'
(
 @UserID nvarchar(100)=null,
 @EmailID nvarchar(200)=null
)
as
begin


 if(@UserID is not null)
  begin

   select isnull(count(UserId),0) from aspnet_Membership where convert(nvarchar(100),UserID)<>@UserID and lower(Email)=lower(@EmailID)

  end
  else
   begin

   select isnull(count(UserId),0) from aspnet_Membership where lower(Email)=lower(@EmailID)

   end

end
