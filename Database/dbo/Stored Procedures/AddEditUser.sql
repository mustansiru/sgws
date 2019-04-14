CREATE proc [dbo].[AddEditUser]
(
  @UserID nvarchar(300)=null,
  @FirstName nvarchar(200)=null,
  @LastName nvarchar(200)=null,
  @PhoneNo nvarchar(50)=null,
  @CompanyID bigint=0,
  @RoleID nvarchar(300)=null,
  @Mode int=0,
  @IsActive bit=0,
  @LoggedInUserID nvarchar(300)=null,
  @ProvinceId varchar(500) = null,
  @SupplierId varchar(500) = null,
  @BusinessType varchar(50) = Null,
  @Brand varchar(500) = null
)
as
begin

Delete From dbo.UserSupplier Where UserId = @UserID
If(Len(Isnull(@SupplierId,'')) > 0)
Begin		
	Insert Into dbo.UserSupplier(UserId,SupplierId)
	Select @UserID,Item From dbo.SplitString(@SupplierId,',')	
End
	
Delete From dbo.UserProvince Where UserId = @UserID
If(Len(Isnull(@ProvinceId,'')) > 0)
Begin	
	Insert Into dbo.UserProvince(UserId,ProvinceId)
	Select @UserID,Item From dbo.SplitString(@ProvinceId,',')
End
	
Delete From dbo.UserBusinessType Where UserId = @UserID
If(Len(Isnull(@BusinessType,'')) > 0)
Begin	
	Insert Into dbo.UserBusinessType(UserId,BusinessTypeId)
	Select @UserID,Item From dbo.SplitString(@BusinessType,',')
End

Delete From dbo.UserBrand Where UserId = @UserID
If(Len(Isnull(@Brand,'')) > 0)
Begin	
	Insert Into dbo.UserBrand(UserId,BrandId)
	Select @UserID,Item From dbo.SplitString(@Brand,',')
End

Update aspnet_Membership set IsApproved=@IsActive, IsLockedOut=0 where  UserId=@UserID

 if(@Mode=1) -- 1=insert
  begin

   delete from aspnet_UsersInRoles where UserId=@UserID

	-- Insert role for Current User
	insert into aspnet_UsersInRoles (Roleid,UserId) values(@RoleID,@UserID)


   INSERT INTO [dbo].[Users]
           ([UserId]
           ,[FirstName]
           ,[LastName]
           ,[PhoneNo]
           ,[CompanyID]
           ,[CreatedOn]
           ,[CreatedBy]
           ,[IsDeleted]				   
		   )
     VALUES
           (@UserId
           ,@FirstName
           ,@LastName
           ,@PhoneNo
           ,@CompanyID
           ,getdate()
           ,@LoggedInUserID
           ,0		   		   
		   )

  end
  else if(@Mode=2) -- 2=update
  begin

	-- update role for Current User
   Update aspnet_UsersInRoles set Roleid=@RoleID where UserId=@UserID

   Update [users] set
   FirstName=@FirstName,
   LastName=@LastName,
   PhoneNo=@PhoneNo,
   CompanyID=@CompanyID,
   ModifiedOn=getdate(),
   ModifiedBy=@LoggedInUserID  
   where UserID=@UserID

  end

end

