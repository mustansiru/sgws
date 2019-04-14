CREATE proc [dbo].[GetBAMCostByProvince]
(
@ProvinceId bigint =0
)
As
Begin
	select BAMCost from [dbo].[Province_BAMCost] where ProvinceId=@ProvinceId
End
