using OfficeOpenXml;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.IO;

/// <summary>
/// Summary description for ExcelHelper
/// </summary>
public static class ExcelHelper
{

    //public static string ImportMasterSKUList(string fileName)
    //{
    //    string josnString = string.Empty;

    //    FileInfo fileInfo = new FileInfo(fileName);

    //    List<TMP_ProductInfo> _listProducts = new List<TMP_ProductInfo>();
    //    TMP_ProductInfo _TMP_ProductInfo;

    //    using (ExcelPackage excelPackage = new ExcelPackage(fileInfo))
    //    {
    //        ExcelWorksheet workSheet = excelPackage.Workbook.Worksheets["Master"];
    //        int totalRows = workSheet.Dimension.Rows;

    //        for (int row = 3; row < totalRows; row++)
    //        {
    //            try
    //            {
    //                _TMP_ProductInfo = new TMP_ProductInfo();
    //                _TMP_ProductInfo.GlazersProductCode = workSheet.Cells["F" + row.ToString()].Value.CellValueToString();

    //                if (!string.IsNullOrEmpty(_TMP_ProductInfo.GlazersProductCode))
    //                {
    //                    _TMP_ProductInfo.CategoryCode = ParseStringValue(workSheet.Cells["A" + row.ToString()].Value);
    //                    _TMP_ProductInfo.SubCategoryCode = ParseIntValue(workSheet.Cells["B" + row.ToString()].Value);
    //                    _TMP_ProductInfo.SupplierCode = ParseStringValue(workSheet.Cells["C" + row.ToString()].Value);
    //                    _TMP_ProductInfo.BrandCode = ParseIntValue(workSheet.Cells["D" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ItemCode = ParseIntValue(workSheet.Cells["E" + row.ToString()].Value);


    //                    _TMP_ProductInfo.SupplierName = ParseStringValue(workSheet.Cells["G" + row.ToString()].Value);
    //                    _TMP_ProductInfo.BrandName = ParseStringValue(workSheet.Cells["H" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ProductName = ParseStringValue(workSheet.Cells["I" + row.ToString()].Value);
    //                    _TMP_ProductInfo.AlternateName = ParseStringValue(workSheet.Cells["J" + row.ToString()].Value);
    //                    _TMP_ProductInfo.SupplierLegalName = ParseStringValue(workSheet.Cells["K" + row.ToString()].Value);
    //                    _TMP_ProductInfo.UPC_EAN_13 = ParseStringValue(workSheet.Cells["L" + row.ToString()].Value);
    //                    _TMP_ProductInfo.SCC_14 = ParseStringValue(workSheet.Cells["M" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ABV_Per = ParseDecimalValue(workSheet.Cells["N" + row.ToString()].Value);

    //                    _TMP_ProductInfo.Category = ParseStringValue(workSheet.Cells["O" + row.ToString()].Value);
    //                    _TMP_ProductInfo.SubCategory = ParseStringValue(workSheet.Cells["P" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ContainerType = ParseStringValue(workSheet.Cells["Q" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ContainerVolume = ParseIntValue(workSheet.Cells["R" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Containers_Selling_Unit = ParseIntValue(workSheet.Cells["S" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Selling_Units_Case = ParseIntValue(workSheet.Cells["T" + row.ToString()].Value);

    //                    _TMP_ProductInfo.Supplier_Internal_Code = ParseStringValue(workSheet.Cells["U" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Supplier_Internal_Code2 = ParseStringValue(workSheet.Cells["V" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Supplier_Internal_Code3 = ParseStringValue(workSheet.Cells["W" + row.ToString()].Value);

    //                    _TMP_ProductInfo.ACD_British_Columbia = ParseIntValue(workSheet.Cells["X" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Alberta = ParseIntValue(workSheet.Cells["Y" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Saskatchewan = ParseIntValue(workSheet.Cells["Z" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Manitoba = ParseIntValue(workSheet.Cells["AA" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Ontario = ParseIntValue(workSheet.Cells["AB" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Quebec = ParseIntValue(workSheet.Cells["AC" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Newfoundland = ParseIntValue(workSheet.Cells["AD" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_New_Brunswick = ParseIntValue(workSheet.Cells["AE" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Nova_Scotia = ParseIntValue(workSheet.Cells["AF" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Prince_Edward_Island = ParseIntValue(workSheet.Cells["AG" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Northwest_Territories = ParseIntValue(workSheet.Cells["AH" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Nunavut = ParseIntValue(workSheet.Cells["AI" + row.ToString()].Value);
    //                    _TMP_ProductInfo.ACD_Yukon = ParseIntValue(workSheet.Cells["AJ" + row.ToString()].Value);

    //                    _TMP_ProductInfo.CSPC_British_Columbia = ParseIntValue(workSheet.Cells["AK" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Alberta = ParseIntValue(workSheet.Cells["AL" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Saskatchewan = ParseIntValue(workSheet.Cells["AM" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Manitoba = ParseIntValue(workSheet.Cells["AN" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Ontario = ParseIntValue(workSheet.Cells["AO" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Quebec = ParseIntValue(workSheet.Cells["AP" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Newfoundland = ParseIntValue(workSheet.Cells["AQ" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_New_Brunswick = ParseIntValue(workSheet.Cells["AR" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Nova_Scotia = ParseIntValue(workSheet.Cells["AS" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Prince_Edward_Island = ParseIntValue(workSheet.Cells["AT" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Northwest_Territories = ParseIntValue(workSheet.Cells["AU" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Nunavut = ParseIntValue(workSheet.Cells["AV" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Yukon = ParseIntValue(workSheet.Cells["AW" + row.ToString()].Value);
    //                    _TMP_ProductInfo.CSPC_Quebec_Private_Order = ParseIntValue(workSheet.Cells["AW" + row.ToString()].Value);

    //                    _TMP_ProductInfo.Closure_Type = ParseStringValue(workSheet.Cells["BL" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Closure_Weight = ParseDecimalValue(workSheet.Cells["BM" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Bottle_Weight = ParseDecimalValue(workSheet.Cells["BN" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Bottle_Height = ParseDecimalValue(workSheet.Cells["BO" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Bottle_Length = ParseDecimalValue(workSheet.Cells["BP" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Bottle_Width = ParseDecimalValue(workSheet.Cells["BQ" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Empty_Bottle_Weight = ParseDecimalValue(workSheet.Cells["BR" + row.ToString()].Value);

    //                    _TMP_ProductInfo.Lead_Time = ParseIntValue(workSheet.Cells["BS" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Shipping_Term = ParseStringValue(workSheet.Cells["BT" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Product_Designation = ParseStringValue(workSheet.Cells["BU" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Origin_Country = ParseStringValue(workSheet.Cells["BW" + row.ToString()].Value);

    //                    _TMP_ProductInfo.Case_Height = ParseDecimalValue(workSheet.Cells["CC" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Case_Width = ParseDecimalValue(workSheet.Cells["CD" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Case_Length = ParseDecimalValue(workSheet.Cells["CE" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Case_Weight = ParseDecimalValue(workSheet.Cells["CF" + row.ToString()].Value);

    //                    _TMP_ProductInfo.Cases_Per_Pallet = ParseIntValue(workSheet.Cells["CG" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Layers_Per_Pallet = ParseIntValue(workSheet.Cells["CH" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Cases_Per_Layer = ParseIntValue(workSheet.Cells["CI" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Cases_20ft_Container = ParseIntValue(workSheet.Cells["CJ" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Cases_40ft_Container = ParseIntValue(workSheet.Cells["CK" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Cases_40ft_Heated_Container = ParseIntValue(workSheet.Cells["CL" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Appellation = ParseStringValue(workSheet.Cells["CM" + row.ToString()].Value);

    //                    _TMP_ProductInfo.Colour = ParseStringValue(workSheet.Cells["CN" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Residual_Sugar = ParseStringValue(workSheet.Cells["CO" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Grape_Varietals = ParseDecimalValue(workSheet.Cells["CP" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Variety = ParseDecimalValue(workSheet.Cells["CQ" + row.ToString()].Value);
    //                    _TMP_ProductInfo.Flavour = ParseStringValue(workSheet.Cells["CR" + row.ToString()].Value);

    //                    _TMP_ProductInfo.HQ_Contact_Name = ParseStringValue(workSheet.Cells["CS" + row.ToString()].Value);
    //                    _TMP_ProductInfo.HQ_Contact_Name_Position = ParseStringValue(workSheet.Cells["CT" + row.ToString()].Value);
    //                    _TMP_ProductInfo.HQ_Address = ParseStringValue(workSheet.Cells["CU" + row.ToString()].Value);
    //                    _TMP_ProductInfo.HQ_City = ParseStringValue(workSheet.Cells["CV" + row.ToString()].Value);
    //                    _TMP_ProductInfo.HQ_Postal_Code = ParseStringValue(workSheet.Cells["CW" + row.ToString()].Value);
    //                    _TMP_ProductInfo.HQ_Country = ParseStringValue(workSheet.Cells["CX" + row.ToString()].Value);
    //                    _TMP_ProductInfo.HQ_Phone_Number = ParseStringValue(workSheet.Cells["CY" + row.ToString()].Value);
    //                    _TMP_ProductInfo.HQ_Email = ParseStringValue(workSheet.Cells["CZ" + row.ToString()].Value);



    //                    _listProducts.Add(_TMP_ProductInfo);
    //                }
    //            }
    //            catch (Exception ex)
    //            {
    //                _listProducts = null;
    //                _TMP_ProductInfo = null;
    //                throw;
    //            }
    //        }

    //    }

    //    josnString = Newtonsoft.Json.JsonConvert.SerializeObject(_listProducts);

    //    return josnString;
    //}

    //private static string ParseStringValue(object obj)
    //{
    //    string finalVal = string.Empty;
    //    try
    //    {
    //        finalVal = Convert.ToString(obj);
    //    }
    //    catch
    //    {
    //        //ignore value
    //    }
    //    return finalVal;
    //}

    //private static int ParseIntValue(object obj)
    //{
    //    int finalVal = 0;
    //    try
    //    {
    //        finalVal = Convert.ToInt32(obj.ToString().Replace("%", ""));
    //    }
    //    catch
    //    {
    //        //ignore value
    //    }
    //    return finalVal;
    //}

    //private static decimal ParseDecimalValue(object obj)
    //{
    //    decimal finalVal = 0;
    //    try
    //    {
    //        finalVal = Convert.ToDecimal(obj.ToString().Replace("%", "").Replace("\"", "").Replace("gr", "").Replace("grams", "").Replace("lbs", ""));
    //    }
    //    catch
    //    {
    //        //ignore value
    //    }
    //    return finalVal;
    //}

    //private static string GetCellValue(string cellValue)
    //{
    //    cellValue = cellValue.Replace(@"\", "")
    //             .Replace("\n", "")
    //             .Replace(@"\&", "")
    //             .Replace("\r", "")
    //             .Replace("\t", "")
    //             .Replace("\b", "")
    //             .Replace("\f", "")
    //             .Replace("\"", "");


    //    return cellValue;
    //}

    //public static DataTable GetDataTableFromExcel(string path, bool hasHeader = true)
    //{
    //    using (var pck = new OfficeOpenXml.ExcelPackage())
    //    {
    //        using (var stream = File.OpenRead(path))
    //        {
    //            pck.Load(stream);
    //        }
    //        var ws = pck.Workbook.Worksheets.First();
    //        DataTable tbl = new DataTable();
    //        foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
    //        {
    //            tbl.Columns.Add(hasHeader ? firstRowCell.Text : string.Format("Column {0}", firstRowCell.Start.Column));
    //        }
    //        var startRow = hasHeader ? 2 : 1;
    //        for (int rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
    //        {
    //            var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
    //            DataRow row = tbl.Rows.Add();
    //            foreach (var cell in wsRow)
    //            {
    //                row[cell.Start.Column - 1] = cell.Text;
    //            }
    //        }
    //        return tbl;
    //    }
    //}

    //public static string ImportMasterSKUData(string filePath, ArrayList sheetColl)
    //{
    //    //IEnumerable<Dictionary<string, object>> excelData = null;
    //    string josnString = string.Empty;
    //    string strcon = string.Empty;
    //    string StrFileType = Path.GetExtension(filePath);
    //    if (StrFileType == ".xls")
    //    {
    //        strcon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="
    //                        + filePath +
    //                        ";Extended Properties=\"Excel 8.0;HDR=YES;IMEX=1;TypeGuessRows=0;ImportMixedTypes=Text\"";
    //    }
    //    else
    //    {
    //        strcon = @"Provider=Microsoft.ACE.OLEDB.12.0;";
    //        strcon += @"Data Source=" + filePath + ";";
    //        strcon += @"Extended Properties=""Excel 12.0 xml;HDR=YES;Imex=1;""";
    //        strcon = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source="
    //                      + filePath +
    //                      ";Extended Properties=\"Excel 12.0 xml;HDR=YES;IMEX=1;TypeGuessRows=0;ImportMixedTypes=Text\"";

    //        strcon = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath +
    //                      ";Extended Properties=\"Excel 12.0 xml;HDR=YES;IMEX=1;TypeGuessRows=0;ImportMixedTypes=Text\"";
    //    }
    //    DataTable dtexcel = new DataTable();
    //    OleDbCommand oledbCmd = null;
    //    string strselect = "";
    //    OleDbDataReader oledbReader = null;


    //    //using (OleDbConnection excelCon = new OleDbConnection(strcon))
    //    //{
    //    //    try
    //    //    {
    //    //        excelCon.Open();

    //    //        //Start::Get Sheet Name Dynamically
    //    //        DataTable dtSheetNames = excelCon.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
    //    //        if (dtSheetNames == null)
    //    //        {
    //    //            return null;
    //    //        }
    //    //        strselect = "Select * from [" + dtSheetNames.Rows[5]["TABLE_NAME"] + "]";

    //    //        using (OleDbDataAdapter exDA = new OleDbDataAdapter(strselect, excelCon))
    //    //        {
    //    //            exDA.Fill(dtexcel);
    //    //            dtexcel.TableName = "ProductData";
    //    //            dtexcel.WriteXml(System.Web.Hosting.HostingEnvironment.MapPath("~/UploadedFiles/DataTableXML.xml"), true);
    //    //        }
    //    //    }
    //    //    catch (OleDbException oledb)
    //    //    {
    //    //        throw new Exception(oledb.Message.ToString());
    //    //    }
    //    //    finally
    //    //    {
    //    //        excelCon.Close();
    //    //    }
    //    //}

    //    using (OleDbConnection excelCon = new OleDbConnection(strcon))
    //    {
    //        try
    //        {
    //            excelCon.Open();

    //            //Start::Get Sheet Name Dynamically
    //            DataTable dtSheetNames = excelCon.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);


    //            if (dtSheetNames == null)
    //            {
    //                return null;
    //            }


    //            //foreach (DataRow dr in dtSheetNames.Rows)
    //            //{
    //            //    foreach (string sheetName in sheetColl)
    //            //    {
    //            //        if (dr["TABLE_NAME"].ToString() == (sheetName + "$"))
    //            //        {
    //            //            strselect = "Select * from [" + dr["TABLE_NAME"] + "]";
    //            //            oledbCmd = new OleDbCommand(strselect, excelCon);
    //            //            oledbReader = oledbCmd.ExecuteReader();
    //            //            if (excelData == null)
    //            //                excelData = Serialize(oledbReader);
    //            //            else
    //            //                excelData.Concat(Serialize(oledbReader));
    //            //        }
    //            //    }
    //            //}

    //            strselect = "Select * from [" + dtSheetNames.Rows[5]["TABLE_NAME"] + "]";
    //            oledbCmd = new OleDbCommand(strselect, excelCon);
    //            oledbReader = oledbCmd.ExecuteReader();

    //            josnString = GetMasterSKUJson(oledbReader);

    //            //if (excelData == null)
    //            //    excelData = Serialize(oledbReader);

    //            oledbReader.Close();
    //            oledbCmd.Dispose();
    //            excelCon.Close();
    //        }
    //        catch (OleDbException oledb)
    //        {
    //            throw new Exception(oledb.Message.ToString());
    //        }
    //        finally
    //        {
    //            excelCon.Close();
    //        }
    //    }

    //    return josnString;
    //}

    //private static string GetMasterSKUJson(OleDbDataReader reader)
    //{
    //    string jsonString = string.Empty;
    //    StringBuilder strRow = new StringBuilder();
    //    StringBuilder sb = new StringBuilder();
    //    List<TMP_ProductInfo> _listProducts = new List<TMP_ProductInfo>();
    //    TMP_ProductInfo _TMP_ProductInfo;

    //    reader.Read();

    //    var cols = new List<string>();
    //    for (var i = 0; i < reader.FieldCount; i++)
    //        cols.Add(reader.GetName(i));



    //    int intVal = 0;
    //    long longVal = 0;
    //    decimal decimalVal = 0;

    //    string strVal = string.Empty;

    //    while (reader.Read())
    //    {
    //        intVal = 0;
    //        _TMP_ProductInfo = new TMP_ProductInfo();

    //        for (var i = 0; i < cols.Count; i++)
    //        {

    //            switch (cols[i].ToString())
    //            {
    //                case "F1":
    //                    _TMP_ProductInfo.CategoryCode = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F2":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.SubCategoryCode = intVal;
    //                    break;
    //                case "F3":
    //                    _TMP_ProductInfo.SupplierCode = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F4":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.BrandCode = intVal;
    //                    break;
    //                case "871":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.ItemCode = intVal;
    //                    break;
    //                case "F6":
    //                    _TMP_ProductInfo.GlazersProductCode = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "Basic Information":
    //                    _TMP_ProductInfo.SupplierName = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F8":
    //                    _TMP_ProductInfo.BrandName = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F9":
    //                    _TMP_ProductInfo.ProductName = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F10":
    //                    _TMP_ProductInfo.AlternateName = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F11":
    //                    _TMP_ProductInfo.SupplierLegalName = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F12":
    //                    _TMP_ProductInfo.UPC_EAN_13 = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F13":
    //                    _TMP_ProductInfo.SCC_14 = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F14":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("%", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.ABV_Per = decimalVal;
    //                    break;
    //                case "F15":
    //                    _TMP_ProductInfo.Category = GetCellValue(reader[i].ToString());
    //                    break;

    //                case "F16":
    //                    _TMP_ProductInfo.SubCategory = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F17":
    //                    _TMP_ProductInfo.ContainerType = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F18":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.ContainerVolume = intVal;
    //                    break;
    //                case "F19":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.Containers_Selling_Unit = intVal;
    //                    break;
    //                case "F20":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.Selling_Units_Case = intVal;
    //                    break;

    //                case "F21":
    //                    _TMP_ProductInfo.Supplier_Internal_Code = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F22":
    //                    _TMP_ProductInfo.Supplier_Internal_Code2 = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F23":
    //                    _TMP_ProductInfo.Supplier_Internal_Code3 = GetCellValue(reader[i].ToString());
    //                    break;


    //                case "ACDPROVINCEKEY":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_British_Columbia = longVal;
    //                    break;
    //                case "F25":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Alberta = longVal;
    //                    break;
    //                case "F26":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Saskatchewan = longVal;
    //                    break;
    //                case "F27":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Manitoba = longVal;
    //                    break;
    //                case "F28":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Ontario = longVal;
    //                    break;
    //                case "F29":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Quebec = longVal;
    //                    break;
    //                case "F30":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Newfoundland = longVal;
    //                    break;
    //                case "F31":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_New_Brunswick = longVal;
    //                    break;
    //                case "F32":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Nova_Scotia = longVal;
    //                    break;
    //                case "F33":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Prince_Edward_Island = longVal;
    //                    break;
    //                case "F34":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Northwest_Territories = longVal;
    //                    break;
    //                case "F35":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Nunavut = longVal;
    //                    break;
    //                case "F36":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.ACD_Yukon = longVal;
    //                    break;

    //                case "CSPC":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_British_Columbia = longVal;
    //                    break;
    //                case "F38":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Alberta = longVal;
    //                    break;
    //                case "F39":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Saskatchewan = longVal;
    //                    break;
    //                case "F40":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Manitoba = longVal;
    //                    break;
    //                case "F41":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Ontario = longVal;
    //                    break;
    //                case "F42":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Quebec = longVal;
    //                    break;
    //                case "F43":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Newfoundland = longVal;
    //                    break;
    //                case "F44":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_New_Brunswick = longVal;
    //                    break;
    //                case "F45":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Nova_Scotia = longVal;
    //                    break;
    //                case "F46":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Prince_Edward_Island = longVal;
    //                    break;
    //                case "F47":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Northwest_Territories = longVal;
    //                    break;
    //                case "F48":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Nunavut = longVal;
    //                    break;
    //                case "F49":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Yukon = longVal;
    //                    break;
    //                case "F50":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.CSPC_Quebec_Private_Order = longVal;
    //                    break;

    //                case "Logistics":
    //                    _TMP_ProductInfo.Closure_Type = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F65":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("grams", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Closure_Weight = decimalVal;
    //                    break;
    //                case "F66":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("gr", "").Replace("lbs", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Bottle_Weight = decimalVal;
    //                    break;
    //                case "F67":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("\"", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Bottle_Height = decimalVal;
    //                    break;
    //                case "F68":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("\"", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Bottle_Length = decimalVal;
    //                    break;
    //                case "F69":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("\"", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Bottle_Width = decimalVal;
    //                    break;
    //                case "F70":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("\"", "").Replace("grams", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Empty_Bottle_Weight = decimalVal;
    //                    break;

    //                case "F71":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.Lead_Time = intVal;
    //                    break;
    //                case "F72":
    //                    _TMP_ProductInfo.Shipping_Term = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F73":
    //                    _TMP_ProductInfo.Product_Designation = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F75":
    //                    _TMP_ProductInfo.Origin_Country = GetCellValue(reader[i].ToString());
    //                    break;

    //                case "F81":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("\"", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Case_Height = decimalVal;
    //                    break;
    //                case "F82":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("\"", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Case_Width = decimalVal;
    //                    break;
    //                case "F83":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("\"", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Case_Length = decimalVal;
    //                    break;
    //                case "F84":
    //                    strVal = reader[i].ToString();
    //                    strVal = strVal.Replace("lbs", "");
    //                    decimal.TryParse(strVal, out decimalVal);
    //                    _TMP_ProductInfo.Case_Weight = decimalVal;
    //                    break;

    //                case "F85":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.Cases_Per_Pallet = intVal;
    //                    break;
    //                case "F86":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.Layers_Per_Pallet = intVal;
    //                    break;
    //                case "F87":
    //                    int.TryParse(GetCellValue(reader[i].ToString()), out intVal);
    //                    _TMP_ProductInfo.Cases_Per_Layer = intVal;
    //                    break;

    //                //case "F88":
    //                //    _TMP_ProductInfo.Cases_20ft_Container = GetCellValue(reader[i].ToString());
    //                //    break;
    //                //case "F89":
    //                //    _TMP_ProductInfo.Cases_40ft_Container = GetCellValue(reader[i].ToString());
    //                //    break;
    //                //case "F90":
    //                //    _TMP_ProductInfo.Cases_40ft_Heated_Container = GetCellValue(reader[i].ToString());
    //                //    break;
    //                case "F91":
    //                    _TMP_ProductInfo.Appellation = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F92":
    //                    _TMP_ProductInfo.Colour = GetCellValue(reader[i].ToString());
    //                    break;
    //                case "F93":
    //                    _TMP_ProductInfo.Residual_Sugar = GetCellValue(reader[i].ToString());
    //                    break;

    //                case "F94":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.Grape_Varietals = longVal;
    //                    break;
    //                case "F95":
    //                    long.TryParse(GetCellValue(reader[i].ToString()), out longVal);
    //                    _TMP_ProductInfo.Variety = longVal;
    //                    break;
    //                case "F96":
    //                    _TMP_ProductInfo.Flavour = reader[i].ToString();
    //                    break;

    //                case "Listing":
    //                    _TMP_ProductInfo.HQ_Contact_Name = reader[i].ToString();
    //                    break;
    //                case "F98":
    //                    _TMP_ProductInfo.HQ_Contact_Name_Position = reader[i].ToString();
    //                    break;
    //                case "F99":
    //                    _TMP_ProductInfo.HQ_Address = reader[i].ToString();
    //                    break;
    //                case "F100":
    //                    _TMP_ProductInfo.HQ_City = reader[i].ToString();
    //                    break;
    //                case "F101":
    //                    _TMP_ProductInfo.HQ_Postal_Code = reader[i].ToString();
    //                    break;
    //                case "F102":
    //                    _TMP_ProductInfo.HQ_Country = reader[i].ToString();
    //                    break;
    //                case "F103":
    //                    _TMP_ProductInfo.HQ_Phone_Number = reader[i].ToString();
    //                    break;
    //                case "F104":
    //                    _TMP_ProductInfo.HQ_Email = reader[i].ToString();
    //                    break;
    //            }
    //        }
    //        _listProducts.Add(_TMP_ProductInfo);
    //    }

    //    if (_listProducts != null)
    //    {
    //        _listProducts = _listProducts.Where(t => !string.IsNullOrEmpty(t.GlazersProductCode)).ToList();
    //    }

    //    jsonString = Newtonsoft.Json.JsonConvert.SerializeObject(_listProducts);

    //    return jsonString;
    //}



    ////private static string GetJson(OleDbDataReader reader)
    ////{
    ////    string jsonString = string.Empty;

    ////    StringBuilder sb = new StringBuilder();
    ////    reader.Read();

    ////    var cols = new List<string>();
    ////    for (var i = 0; i < reader.FieldCount; i++)
    ////        cols.Add(reader[i].ToString());

    ////    StringBuilder strRow;

    ////    while (reader.Read())
    ////    {
    ////        strRow = new StringBuilder();
    ////        strRow.Append("{");
    ////        for (var i = 0; i < cols.Count; i++)
    ////        {

    ////            strRow.Append("\"" + cols[i] + "\":\"" + reader[i].ToString().Replace(@"\", "")
    ////                .Replace("\n", "")
    ////                .Replace(@"\&", "")
    ////                .Replace("\r", "")
    ////                .Replace("\t", "")
    ////                .Replace("\b", "")
    ////                .Replace("\f", "")
    ////                .Replace("\"", "")
    ////                + "\",");

    ////        }
    ////        strRow.Remove(strRow.Length - 1, 1);

    ////        strRow.Append("},");
    ////        sb.Append(strRow);
    ////    }
    ////    if (sb.Length > 0)
    ////    {
    ////        sb.Remove(sb.Length - 1, 1);
    ////        jsonString = "[" + sb.ToString() + "]";
    ////    }
    ////    return jsonString;
    ////}

    //private static IEnumerable<Dictionary<string, object>> Serialize(OleDbDataReader reader)
    //{
    //    var results = new List<Dictionary<string, object>>();
    //    reader.Read();

    //    var cols = new List<string>();
    //    for (var i = 0; i < reader.FieldCount; i++)
    //        cols.Add(reader[i].ToString());

    //    while (reader.Read())
    //        results.Add(SerializeRow(cols, reader));

    //    return results;
    //}
    //private static Dictionary<string, object> SerializeRow(List<string> cols,
    //                                                OleDbDataReader reader)
    //{
    //    var result = new Dictionary<string, object>();
    //    //foreach (var col in cols)
    //    //    result.Add(col, reader[col]);
    //    for (var i = 0; i < reader.FieldCount; i++)
    //    {
    //        if (cols[i].ToLower() != "not used")
    //            result.Add(cols[i], reader[i].ToString());
    //    }
    //    return result;
    //}

    //public static string GetFileDataAsStream(string fileName)
    //{
    //    List<string> excelData = new List<string>();

    //    //read the Excel file as byte array
    //    byte[] bin = File.ReadAllBytes(fileName);

    //    //or if you use asp.net, get the relative path
    //    //byte[] bin = File.ReadAllBytes(Server.MapPath("ExcelDemo.xlsx"));

    //    //create a new Excel package in a memorystream
    //    using (MemoryStream stream = new MemoryStream(bin))
    //    using (ExcelPackage excelPackage = new ExcelPackage(stream))
    //    {
    //        ExcelWorksheet worksheet = excelPackage.Workbook.Worksheets["Master"];

    //        for (int i = worksheet.Dimension.Start.Row; i <= worksheet.Dimension.End.Row; i++)
    //        {
    //            //loop all columns in a row
    //            for (int j = worksheet.Dimension.Start.Column; j <= worksheet.Dimension.End.Column; j++)
    //            {
    //                //add the cell data to the List
    //                if (worksheet.Cells[i, j].Value != null)
    //                {
    //                    excelData.Add(worksheet.Cells[i, j].Value.ToString());
    //                }
    //            }
    //        }

    //    }

    //    return excelData.ToString();
    //}


    public static string NewImportMasterSKUList(string fileName)
    {
        string josnString = string.Empty;

        FileInfo fileInfo = new FileInfo(fileName);

        List<TMP_ProductInfoNew> _listProducts = new List<TMP_ProductInfoNew>();
        TMP_ProductInfoNew _TMP_ProductInfo;

        using (ExcelPackage excelPackage = new ExcelPackage(fileInfo))
        {
            ExcelWorksheet workSheet = excelPackage.Workbook.Worksheets["Master"];
            int totalRows = workSheet.Dimension.Rows;

            for (int row = 3; row < totalRows; row++)
            {
                try
                {
                    _TMP_ProductInfo = new TMP_ProductInfoNew();
                    _TMP_ProductInfo.GlazersProductCode = workSheet.Cells["F" + row.ToString()].Value.ParseCellValueToString();

                    if (!string.IsNullOrEmpty(_TMP_ProductInfo.GlazersProductCode))
                    {
                        _TMP_ProductInfo.CategoryCode = workSheet.Cells["A" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.SubCategoryCode = workSheet.Cells["B" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.SupplierCode = workSheet.Cells["C" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.BrandCode = workSheet.Cells["D" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ItemCode = workSheet.Cells["E" + row.ToString()].Value.ParseCellValueToString();


                        _TMP_ProductInfo.SupplierName = workSheet.Cells["G" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.BrandName = workSheet.Cells["H" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ProductName = workSheet.Cells["I" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.AlternateName = workSheet.Cells["J" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.SupplierLegalName = workSheet.Cells["K" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.UPC_EAN_13 = workSheet.Cells["L" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.SCC_14 = workSheet.Cells["M" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ABV_Per = workSheet.Cells["N" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.Category = workSheet.Cells["O" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.SubCategory = workSheet.Cells["P" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ContainerType = workSheet.Cells["Q" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ContainerVolume = workSheet.Cells["R" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Containers_Selling_Unit = workSheet.Cells["S" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Selling_Units_Case = workSheet.Cells["T" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.Supplier_Internal_Code = workSheet.Cells["U" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Supplier_Internal_Code2 = workSheet.Cells["V" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Supplier_Internal_Code3 = workSheet.Cells["W" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.ACD_British_Columbia = workSheet.Cells["X" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Alberta = workSheet.Cells["Y" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Saskatchewan = workSheet.Cells["Z" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Manitoba = workSheet.Cells["AA" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Ontario = workSheet.Cells["AB" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Quebec = workSheet.Cells["AC" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Newfoundland = workSheet.Cells["AD" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_New_Brunswick = workSheet.Cells["AE" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Nova_Scotia = workSheet.Cells["AF" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Prince_Edward_Island = workSheet.Cells["AG" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Northwest_Territories = workSheet.Cells["AH" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Nunavut = workSheet.Cells["AI" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.ACD_Yukon = workSheet.Cells["AJ" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.CSPC_British_Columbia = workSheet.Cells["AK" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Alberta = workSheet.Cells["AL" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Saskatchewan = workSheet.Cells["AM" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Manitoba = workSheet.Cells["AN" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Ontario = workSheet.Cells["AO" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Quebec = workSheet.Cells["AP" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Newfoundland = workSheet.Cells["AQ" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_New_Brunswick = workSheet.Cells["AR" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Nova_Scotia = workSheet.Cells["AS" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Prince_Edward_Island = workSheet.Cells["AT" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Northwest_Territories = workSheet.Cells["AU" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Nunavut = workSheet.Cells["AV" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Yukon = workSheet.Cells["AW" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Quebec_Private_Order = workSheet.Cells["AX" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.CSPC_Ontario_Consignment = workSheet.Cells["AY" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.PM_Owner = workSheet.Cells["BK" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Closure_Type = workSheet.Cells["BL" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Closure_Weight = workSheet.Cells["BM" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Bottle_Weight = workSheet.Cells["BN" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Bottle_Height = workSheet.Cells["BO" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Bottle_Length = workSheet.Cells["BP" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Bottle_Width = workSheet.Cells["BQ" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Empty_Bottle_Weight = workSheet.Cells["BR" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.Lead_Time = workSheet.Cells["BS" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Shipping_Term = workSheet.Cells["BT" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Product_Designation = workSheet.Cells["BU" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Origin_Country = workSheet.Cells["BW" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.Case_Height = workSheet.Cells["CC" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Case_Width = workSheet.Cells["CD" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Case_Length = workSheet.Cells["CE" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Case_Weight = workSheet.Cells["CF" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.Cases_Per_Pallet = workSheet.Cells["CG" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Layers_Per_Pallet = workSheet.Cells["CH" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Cases_Per_Layer = workSheet.Cells["CI" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Cases_20ft_Container = workSheet.Cells["CJ" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Cases_40ft_Container = workSheet.Cells["CK" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Cases_40ft_Heated_Container = workSheet.Cells["CL" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Appellation = workSheet.Cells["CM" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.Colour = workSheet.Cells["CN" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Residual_Sugar = workSheet.Cells["CO" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Grape_Varietals = workSheet.Cells["CP" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Variety = workSheet.Cells["CQ" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.Flavour = workSheet.Cells["CR" + row.ToString()].Value.ParseCellValueToString();

                        _TMP_ProductInfo.HQ_Contact_Name = workSheet.Cells["CS" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.HQ_Contact_Name_Position = workSheet.Cells["CT" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.HQ_Address = workSheet.Cells["CU" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.HQ_City = workSheet.Cells["CV" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.HQ_Postal_Code = workSheet.Cells["CW" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.HQ_Country = workSheet.Cells["CX" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.HQ_Phone_Number = workSheet.Cells["CY" + row.ToString()].Value.ParseCellValueToString();
                        _TMP_ProductInfo.HQ_Email = workSheet.Cells["CZ" + row.ToString()].Value.ParseCellValueToString();



                        _listProducts.Add(_TMP_ProductInfo);
                    }
                }
                catch (Exception ex)
                {
                    _listProducts = null;
                    _TMP_ProductInfo = null;
                    throw;
                }
            }

        }


        josnString = Newtonsoft.Json.JsonConvert.SerializeObject(_listProducts);

        return josnString;
    }

    public static string ImportExpenseData(string fileName)
    {
        string josnString = string.Empty;

        FileInfo fileInfo = new FileInfo(fileName);

        List<Expense_Import> _listProducts = new List<Expense_Import>();
        Expense_Import _Expense_Import;

        using (ExcelPackage excelPackage = new ExcelPackage(fileInfo))
        {
            ExcelWorksheet workSheet = excelPackage.Workbook.Worksheets["Sheet1"];
            int totalRows = workSheet.Dimension.Rows;

            for (int row = 2; row <= totalRows; row++)
            {
                try
                {
                    _Expense_Import = new Expense_Import();

                    _Expense_Import.Record = workSheet.Cells["A" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Month = workSheet.Cells["B" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Date = workSheet.Cells["C" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Province = workSheet.Cells["D" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.ExpenseType = workSheet.Cells["E" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.InvoiceNo = workSheet.Cells["F" + row.ToString()].Value.ParseCellValueToString();


                    _Expense_Import.Vendor = workSheet.Cells["G" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.InvoiceDescription = workSheet.Cells["H" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Employee = workSheet.Cells["I" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Supplier = workSheet.Cells["J" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Brand = workSheet.Cells["K" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.ProgramType = workSheet.Cells["L" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.SupplierVendorName = workSheet.Cells["M" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.RemyClassification = workSheet.Cells["N" + row.ToString()].Value.ParseCellValueToString();

                    _Expense_Import.Patron_GL_Account = workSheet.Cells["O" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Grant_Applicable = workSheet.Cells["P" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Supplier_Coding = workSheet.Cells["Q" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Amount_Net = workSheet.Cells["R" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Tax = workSheet.Cells["S" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.Total = workSheet.Cells["T" + row.ToString()].Value.ParseCellValueToString();

                    _Expense_Import.BillBack = workSheet.Cells["U" + row.ToString()].Value.ParseCellValueToString();
                    _Expense_Import.AP_Structure = workSheet.Cells["V" + row.ToString()].Value.ParseCellValueToString();

                    _listProducts.Add(_Expense_Import);
                }
                catch (Exception ex)
                {
                    _listProducts = null;
                    _Expense_Import = null;
                    throw;
                }
            }

        }


        josnString = Newtonsoft.Json.JsonConvert.SerializeObject(_listProducts);

        return josnString;
    }

    public static string ImportProgramData(string fileName)
    {
        string josnString = string.Empty;

        FileInfo fileInfo = new FileInfo(fileName);

        List<TMP_ProgramImport> _listProgram = new List<TMP_ProgramImport>();
        TMP_ProgramImport _TMP_ProgramImport;

        using (ExcelPackage excelPackage = new ExcelPackage(fileInfo))
        {
            ExcelWorksheet workSheet = excelPackage.Workbook.Worksheets["Data Entry"];
            int totalRows = workSheet.Dimension.Rows;

            for (int row = 4; row <= totalRows; row++)
            {
                try
                {
                    _TMP_ProgramImport = new TMP_ProgramImport();

                    //_TMP_ProgramImport.ProvinceCode = workSheet.Cells["A" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.ProvinceCode = workSheet.Cells["B" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.SGWS_Calendar_Year = workSheet.Cells["C" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.SGWS_Calendar_Period = workSheet.Cells["D" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.Liquor_Board_Period = workSheet.Cells["E" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.Start_Date = workSheet.Cells["F" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.End_Date = workSheet.Cells["G" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.GID = workSheet.Cells["H" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.Is_SKU_Brand = workSheet.Cells["I" + row.ToString()].Value.ParseCellValueToString();

                    _TMP_ProgramImport.CSPC = workSheet.Cells["M" + row.ToString()].Value.ParseCellValueToString();

                    _TMP_ProgramImport.ProgramType = workSheet.Cells["R" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.Comments = workSheet.Cells["S" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.ATL_BTL = workSheet.Cells["T" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.Program_Status = workSheet.Cells["U" + row.ToString()].Value.ParseCellValueToString();


                    _TMP_ProgramImport.Depth = workSheet.Cells["V" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.ForecastCaseSalesBase = workSheet.Cells["W" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.ForecastCaseSalesLift = workSheet.Cells["X" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.ForecastTotalCaseSalesPhysCs = workSheet.Cells["Y" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.ForecastTotalCaseSales9LCsConverted = workSheet.Cells["Z" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.VariableCostPerCase = workSheet.Cells["AA" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.UpforntFees_LTO_BAM = workSheet.Cells["AB" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.RedemptionBAM = workSheet.Cells["AC" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.SpendQuantity = workSheet.Cells["AD" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.SpendPerQuantity = workSheet.Cells["AE" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.OtherFixedCost = workSheet.Cells["AF" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.TotalProgramSpend = workSheet.Cells["AG" + row.ToString()].Value.ParseCellValueToString();

                    _TMP_ProgramImport.Actual_Spend = workSheet.Cells["AH" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.Actual_Volume = workSheet.Cells["AI" + row.ToString()].Value.ParseCellValueToString();
                    _TMP_ProgramImport.UniqueID = workSheet.Cells["AV" + row.ToString()].Value.ParseCellValueToString();
                    _listProgram.Add(_TMP_ProgramImport);
                }
                catch (Exception ex)
                {
                    _listProgram = null;
                    _TMP_ProgramImport = null;

                    throw;
                }
                finally
                {                    
                    _TMP_ProgramImport = null;
                }
            }

        }


        josnString = Newtonsoft.Json.JsonConvert.SerializeObject(_listProgram);

        return josnString;
    }
}

