

  CREATE VIEW [dbo].[vw_ACD_CSPC_Code]
  AS 
  
  SELECT GlazersProductCode,ACD_British_Columbia ACD_Code,CSPC_British_Columbia CSPC_Code, 'BC' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Alberta ACD_Code, CSPC_Alberta CSPC_Code,'AB' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Saskatchewan ACD_Code, CSPC_Saskatchewan CSPC_Code,'SK' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Manitoba ACD_Code,CSPC_Manitoba CSPC_Code, 'MB' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Ontario ACD_Code,CSPC_Ontario CSPC_Code, 'ON' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Quebec ACD_Code,CSPC_Quebec CSPC_Code, 'QC' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Prince_Edward_Island ACD_Code,CSPC_Prince_Edward_Island CSPC_Code, 'PE' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Newfoundland ACD_Code,CSPC_Newfoundland CSPC_Code, 'NL' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_New_Brunswick ACD_Code,CSPC_New_Brunswick CSPC_Code, 'NB' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Nova_Scotia ACD_Code,CSPC_Nova_Scotia CSPC_Code, 'NS' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Northwest_Territories ACD_Code,CSPC_Northwest_Territories, 'NT' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Nunavut ACD_Code,CSPC_Nunavut, 'NU' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,ACD_Yukon ACD_Code,CSPC_Yukon, 'YU' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,0 ACD_Code,CSPC_Quebec_Private_Order, 'QP' Province
  from dbo.TMP_ProductInfo TP With(Nolock)
union all
  SELECT GlazersProductCode,0 ACD_Code,CSPC_Ontario_Consignment, 'OC' Province
  from dbo.TMP_ProductInfo TP With(Nolock)  
