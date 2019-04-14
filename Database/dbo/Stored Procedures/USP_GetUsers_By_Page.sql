
CREATE proc [dbo].[USP_GetUsers_By_Page] --100,0,1,'asc','j'
(
  @iDisplayLength int = 10,
  @iDisplayStart int = 1,
  @iSortCol_0 int = 1,
  @sSortDir_0 varchar(4) = null,
  @sSearch nvarchar(max) = null
)
as
Begin
Declare @SQL Nvarchar(Max) = '', @col varchar(50) = 'FirstName'

	
	declare @iTotalRecords bigint = 0; 
	declare @iTotalSearchRecords bigint = 0; 

Select @iSortCol_0 = @iSortCol_0  + 1

If @iSortCol_0 = 1
Begin
	Select @col = 'FirstName'
End

If @iSortCol_0 = 2
Begin
	Select @col = 'LastName'
End

If @iSortCol_0 = 3
Begin
	Select @col = 'Email'
End

If @iSortCol_0 = 4
Begin
	Select @col = 'RoleName'
End

		 
	--Select @iDisplayStart = @iDisplayStart + 1;

	Select @iTotalRecords = Count(1) From dbo.aspnet_Membership With(Nolock)

Select @SQL = 'Select ' + Cast(@iTotalRecords As Varchar(100)) + ' TotalRecords,' + Cast(@iTotalRecords As Varchar(100)) + ' TotalSearchRecords,UserId, FirstName, LastName,Email,R.RoleName,IsApproved From 
		(
			Select ROW_NUMBER() OVER (ORDER BY U.Email desc) 
			as RowNum, U.UserId,U.Email,R.RoleName,U.IsApproved,US.FirstName,US.LastName
			FROM aspnet_Membership as U
			Inner Join Users US On U.UserId = US.UserId
			Inner Join aspnet_UsersInRoles UR On U.UserId = UR.UserId
			Inner Join aspnet_Roles R On UR.RoleId = R.RoleId
		) As R	
	
	Where RowNum >= ' + Cast((@iDisplayStart + 1) As Varchar(100)) + 'And RowNum <= ' + Cast((@iDisplayStart + @iDisplayLength) As Varchar(100)) +
	      ' And (R.FirstName like ''%' + @sSearch + '%''' + ' Or R.LastName like ''%' + @sSearch + '%''' + 
	      ' Or R.Email like ''%' + @sSearch + '%'')' +
		  ' Order By ' + @col + ' ' + @sSortDir_0
	--Print(@sql)
	exec( @sql)

end

