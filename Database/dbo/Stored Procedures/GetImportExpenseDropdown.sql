CREATE proc [dbo].[GetImportExpenseDropdown] --'e0e48589-b8c9-46c1-889f-42395c3a1d79'
(
	@userId uniqueidentifier =null
)
As
Begin
	select Year from SGWSFiscal group by Year

	select P.Id,P.Province,(case when isnull(UP.ProvinceId,0) >0 then 1 else 0 end) as SelectedProvince from  Province P
	left outer join UserProvince UP on P.Id=UP.ProvinceId and UP.UserId =@userId


	select S.Id,S.SupplierName,(case when isnull(US.SupplierId,0) >0 then 1 else 0 end) as SelectedSupplier from Supplier S 
	left outer join UserSupplier Us on s.Id=us.SupplierId and us.UserId=@userId

End
