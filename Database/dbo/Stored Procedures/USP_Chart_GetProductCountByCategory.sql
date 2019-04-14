create Proc [dbo].[USP_Chart_GetProductCountByCategory]
As
Begin
	SET NOCOUNT ON;
	Select Count(1) Total,Category
	From
	(
		Select C.Category,P.GID
		From dbo.Product P With(Nolock)
		Inner Join dbo.Category C With(Nolock) On P.CategoryId = C.Id
		Group By Category,GID
	) A
	Group By Category
	Order By Total
End
