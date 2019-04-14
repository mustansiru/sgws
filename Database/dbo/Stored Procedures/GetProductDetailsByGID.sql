Create proc [dbo].[GetProductDetailsByGID]
(
@GID varchar(20)=null
)
As
begin

	select ContainerVolume as Size,Containers_Selling_Unit as UnitsPerPk,
	Selling_Units_Case as Units
	from ProductDetails PD where GID=@GID
	group by ContainerVolume,Containers_Selling_Unit,Selling_Units_Case 
end
