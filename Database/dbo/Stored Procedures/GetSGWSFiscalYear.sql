CREATE proc [dbo].[GetSGWSFiscalYear]
As
Begin
	select Year from SGWSFiscal group by Year
End

