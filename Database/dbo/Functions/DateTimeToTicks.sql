
CREATE FUNCTION [dbo].[DateTimeToTicks] (@d datetime)
RETURNS bigint
WITH SCHEMABINDING
AS
BEGIN 
RETURN 
	dbo.DateToTicks(DATEPART(yyyy, @d), DATEPART(mm, @d), DATEPART(dd, @d)) +
	dbo.TimeToTicks(DATEPART(hh, @d), DATEPART(mi, @d), DATEPART(ss, @d)) +
	(CONVERT(bigint, DATEPART(ms, @d)) * CONVERT(bigint,10000));
END


