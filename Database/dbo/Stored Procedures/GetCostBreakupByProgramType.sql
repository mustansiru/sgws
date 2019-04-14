/****** Object:  StoredProcedure [dbo].[GetCostBreakupByProgramType]    Script Date: 4/12/2019 9:36:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCostBreakupByProgramType] 
	-- Add the parameters for the stored procedure here
	@ProgramId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @programTypeId int

	select @ProgramId = P.Id, @programTypeId = P.ProgramTypeId from Program P where P.Id = @ProgramId

	select PC.* from ProgramCost PC where PC.ProgramId = @ProgramId
	select RPP.* from Relation_ProgramType_ProgramCost RPP where RPP.ProgramTypeId = @programTypeId

END
GO


