CREATE proc [dbo].[GetProgramCostFieldsByType]
(
	@ProgramTypeId bigint=0
)
As
begin
	select * from Relation_ProgramType_ProgramCost where ProgramTypeId=@ProgramTypeId
end
