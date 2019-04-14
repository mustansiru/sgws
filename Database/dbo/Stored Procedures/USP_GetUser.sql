

CREATE proc [dbo].[USP_GetUser] --'54B31D3F-2C5D-4B14-ADF4-20C277738747'
(
	@UserID nvarchar(300) = Null	
)
as
begin
	
Select U.UserId,U.FirstName,U.LastName,M.Email,UR.RoleId,U.PhoneNo,M.IsApproved--,U.BusinessType
		,STUFF((SELECT ',' + CAST(ProvinceId AS VARCHAR(10)) [text()]
         FROM dbo.UserProvince 
         WHERE UserId = UP.UserId
         FOR XML PATH(''), TYPE)
        .value('.','NVARCHAR(MAX)'),1,1,'') ProvinceId
		,STUFF((SELECT ',' + CAST(SupplierId AS VARCHAR(10)) [text()]
         FROM dbo.UserSupplier 
         WHERE UserId = S.UserId
         FOR XML PATH(''), TYPE)
        .value('.','NVARCHAR(MAX)'),1,1,'') SupplierId
		,STUFF((SELECT ',' + CAST(BusinessTypeId AS VARCHAR(10)) [text()]
         FROM dbo.UserBusinessType 
         WHERE UserId = B.UserId
         FOR XML PATH(''), TYPE)
        .value('.','NVARCHAR(MAX)'),1,1,'') BusinessType
		,STUFF((SELECT ',' + CAST(BrandId AS VARCHAR(10)) [text()]
         FROM dbo.UserBrand 
         WHERE UserId = UB.UserId
         FOR XML PATH(''), TYPE)
        .value('.','NVARCHAR(MAX)'),1,1,'') Brand
From [users] as U 
Inner join aspnet_UsersInRoles as UR on U.UserId=UR.UserId and convert(nvarchar(50), U.UserId) = @UserID
Inner Join aspnet_Membership as M on U.UserId = M.UserId
Left Join dbo.UserProvince UP On U.UserId = UP.UserId
Left Join dbo.UserSupplier S On U.UserId = S.UserId
Left Join dbo.UserBusinessType B On U.UserId = B.UserId
Left Join dbo.UserBrand UB On U.UserId = UB.UserId
Group By U.UserId,UP.UserId,S.UserId,B.UserId,UB.UserId,FirstName,U.LastName,M.Email,UR.RoleId,U.PhoneNo,M.IsApproved

end

