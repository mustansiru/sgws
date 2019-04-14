using Newtonsoft.Json;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Hosting;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;

public partial class adminsection_MasterSKUList : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                if (SessionFacade.LoggedInUser.Role == RoleIDs.Admin)
                {
                    HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                    h2PageTitle.InnerText = AdminPageTitles.MasterSKUList;
                    HtmlGenericControl liSKUImport = (HtmlGenericControl)Page.Master.FindControl("liSKUImport");
                    liSKUImport.Attributes.Add("class", "active");
                    HtmlGenericControl spanSKU = (HtmlGenericControl)Page.Master.FindControl("spanSKU");
                    spanSKU.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                    SetBreadCrumb(AdminPageTitles.MasterSKUList, null, null);
                }
                else
                {
                    Response.Redirect(Page.ResolveUrl(AdminUrls.Dashboard));
                }
            }
            else
            {
                Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
            }
        }
        Page.Title = AdminPageTitles.MasterSKUList;

    }

    [System.Web.Services.WebMethod]
    [ScriptMethod(UseHttpGet = false)]
    public static string GetFileData(string fileName)
    {
        try
        {
            var jsonString = ExcelHelper.NewImportMasterSKUList(HostingEnvironment.MapPath("~/UploadedFiles/") + fileName);

            List<SQLErrorInfo> _errorList = MasterSKUListBAL.InsertMasterSkuListData(AppStaticData.ConnectionString, jsonString, fileName, SessionFacade.LoggedInUser.UserId);

            if (!_errorList[0].ErrorMessage.Equals("success"))
            {
                SGWSPromoPlan.DAL.log.WriteLog("MasterSKUList => InsertMasterSkuListData ===> Message: " + _errorList[0].ErrorMessage);
                return string.Empty;
            }
            else
            {
                List<TMP_ProductInfoNew> list = MasterSKUListBAL.GetProductInfoData(AppStaticData.ConnectionString);

                List<TMP_ParseError> parseErrorDataList = null;
                StringBuilder ErrorString = new StringBuilder();
                parseErrorDataList = MasterSKUListBAL.GetParseErrorData(AppStaticData.ConnectionString);

                if (parseErrorDataList != null)
                {
                    foreach (var data in parseErrorDataList)
                    {
                        ErrorString.Append("<tr>");
                        ErrorString.Append("<td>" + data.GID + "</td>");
                        ErrorString.Append("<td>" + data.ColumnName + "</td>");
                        ErrorString.Append("<td>" + data.ColumnValue + "</td>");
                        ErrorString.Append("<td>" + data.ErrroMsg + "</td>");
                        ErrorString.Append("</tr>");
                    }
                }

                var updatedRecords = 0;

                jsonString = string.Empty;
                jsonString = Newtonsoft.Json.JsonConvert.SerializeObject(list);

                return JsonConvert.SerializeObject(new { jsonData = list, TotalRec = updatedRecords.ToString(), ErrorList = ErrorString.ToString() });
            }
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("MasterSKUList => GetFileData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    [System.Web.Services.WebMethod]
    [ScriptMethod(UseHttpGet = false)]
    public static string GetProductData()
    {
        try
        {
            List<TMP_ProductInfoNew> list = MasterSKUListBAL.GetProductInfoData(AppStaticData.ConnectionString);
            string josnString = Newtonsoft.Json.JsonConvert.SerializeObject(list);

            return josnString;
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("MasterSKUList => GetProductData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    protected void ExportExcel_Click(object sender, EventArgs e)
    {
       
        ExcelPackage excel = new ExcelPackage();
        var workSheet = excel.Workbook.Worksheets.Add("Master List");
        workSheet.TabColor = System.Drawing.Color.Black;
        workSheet.DefaultRowHeight = 12;
        int _sheetColumn = 1;
        //Header of table  
        //  
        workSheet.Row(1).Height = 20;
        workSheet.Row(1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        workSheet.Row(1).Style.Font.Bold = true;
        workSheet.Cells[1, _sheetColumn++].Value = "Category Code";
        workSheet.Cells[1, _sheetColumn++].Value = "Subcategory Code";
        workSheet.Cells[1, _sheetColumn++].Value = "Supplier Code";
        workSheet.Cells[1, _sheetColumn++].Value = "Brand Code";
        workSheet.Cells[1, _sheetColumn++].Value = "Item Code";
        workSheet.Cells[1, _sheetColumn++].Value = "GLAZERS PRODUCT CODE";
        workSheet.Cells[1, _sheetColumn++].Value = "Supplier Name";
        workSheet.Cells[1, _sheetColumn++].Value = "Brand Name";
        workSheet.Cells[1, _sheetColumn++].Value = "Product Name";
        workSheet.Cells[1, _sheetColumn++].Value = "Alternate Name";
        workSheet.Cells[1, _sheetColumn++].Value = "Supplier Legal Names";
        workSheet.Cells[1, _sheetColumn++].Value = "UPC/EAN-13";
        workSheet.Cells[1, _sheetColumn++].Value = "SCC-14";
        workSheet.Cells[1, _sheetColumn++].Value = "ABV%";
        workSheet.Cells[1, _sheetColumn++].Value = "Category";
        workSheet.Cells[1, _sheetColumn++].Value = "Sub Category";
        workSheet.Cells[1, _sheetColumn++].Value = "Container Type";
        workSheet.Cells[1, _sheetColumn++].Value = "Container Volume (ml)";
        workSheet.Cells[1, _sheetColumn++].Value = "Containers/Selling Unit";
        workSheet.Cells[1, _sheetColumn++].Value = "Selling Units/Case";
        workSheet.Cells[1, _sheetColumn++].Value = "Supplier Internal Code";
        workSheet.Cells[1, _sheetColumn++].Value = "Supplier Internal Code 2";
        workSheet.Cells[1, _sheetColumn++].Value = "Supplier Internal Code 3";
        workSheet.Cells[1, _sheetColumn++].Value = "BRITISH COLUMBIA";
        workSheet.Cells[1, _sheetColumn++].Value = "ALBERTA";
        workSheet.Cells[1, _sheetColumn++].Value = "SASKATCHEWAN";
        workSheet.Cells[1, _sheetColumn++].Value = "MANITOBA";
        workSheet.Cells[1, _sheetColumn++].Value = "ONTARIO";
        workSheet.Cells[1, _sheetColumn++].Value = "QUEBEC";
        workSheet.Cells[1, _sheetColumn++].Value = "NEWFOUNDLAND";
        workSheet.Cells[1, _sheetColumn++].Value = "NEW BRUNSWICK";
        workSheet.Cells[1, _sheetColumn++].Value = "NOVA SCOTIA";
        workSheet.Cells[1, _sheetColumn++].Value = "PRINCE EDWARD ISLAND";
        workSheet.Cells[1, _sheetColumn++].Value = "NORTHWEST TERRITORIES";
        workSheet.Cells[1, _sheetColumn++].Value = "NUNAVUT";
        workSheet.Cells[1, _sheetColumn++].Value = "YUKON";
        workSheet.Cells[1, _sheetColumn++].Value = "BRITISH COLUMBIA";
        workSheet.Cells[1, _sheetColumn++].Value = "ALBERTA";
        workSheet.Cells[1, _sheetColumn++].Value = "SASKATCHEWAN";
        workSheet.Cells[1, _sheetColumn++].Value = "MANITOBA";
        workSheet.Cells[1, _sheetColumn++].Value = "ONTARIO";
        workSheet.Cells[1, _sheetColumn++].Value = "QUEBEC";
        workSheet.Cells[1, _sheetColumn++].Value = "NEWFOUNDLAND";
        workSheet.Cells[1, _sheetColumn++].Value = "NEW BRUNSWICK";
        workSheet.Cells[1, _sheetColumn++].Value = "NOVA SCOTIA";
        workSheet.Cells[1, _sheetColumn++].Value = "PRINCE EDWARD ISLAND";
        workSheet.Cells[1, _sheetColumn++].Value = "NORTHWEST TERRITORIES";
        workSheet.Cells[1, _sheetColumn++].Value = "NUNAVUT";
        workSheet.Cells[1, _sheetColumn++].Value = "YUKON";
        workSheet.Cells[1, _sheetColumn++].Value = "QUEBEC PRIVATE ORDER";
        workSheet.Cells[1, _sheetColumn++].Value = "ONTARIO CONSIGNMENT";
        workSheet.Cells[1, _sheetColumn++].Value = "PM OWNER";
        workSheet.Cells[1, _sheetColumn++].Value = "Closure Type";
        workSheet.Cells[1, _sheetColumn++].Value = "Closure Weight (grams)";
        workSheet.Cells[1, _sheetColumn++].Value = "Bottle Weight (grams)";
        workSheet.Cells[1, _sheetColumn++].Value = "Bottle Height (cm)";
        workSheet.Cells[1, _sheetColumn++].Value = "Bottle Length (cm)";
        workSheet.Cells[1, _sheetColumn++].Value = "Bottle Width (cm)";
        workSheet.Cells[1, _sheetColumn++].Value = "Empty Bottle Weight (grams)";
        workSheet.Cells[1, _sheetColumn++].Value = "Lead Time (Days)";
        workSheet.Cells[1, _sheetColumn++].Value = "Shipping Term";
        workSheet.Cells[1, _sheetColumn++].Value = "Product Designation";
        workSheet.Cells[1, _sheetColumn++].Value = "Origin Country";
        workSheet.Cells[1, _sheetColumn++].Value = "Case Height (cm)";
        workSheet.Cells[1, _sheetColumn++].Value = "Case Width (cm)";
        workSheet.Cells[1, _sheetColumn++].Value = "Case Length (cm)";
        workSheet.Cells[1, _sheetColumn++].Value = "Case Weight (kg)";
        workSheet.Cells[1, _sheetColumn++].Value = "Cases Per Pallet";
        workSheet.Cells[1, _sheetColumn++].Value = "Layers Per Pallet";
        workSheet.Cells[1, _sheetColumn++].Value = "Cases Per Layer";
        workSheet.Cells[1, _sheetColumn++].Value = "Cases / 20ft Container";
        workSheet.Cells[1, _sheetColumn++].Value = "Cases / 40ft Container";
        workSheet.Cells[1, _sheetColumn++].Value = "Cases / 40ft Heated Container";
        workSheet.Cells[1, _sheetColumn++].Value = "Appellation";
        workSheet.Cells[1, _sheetColumn++].Value = "Colour";
        workSheet.Cells[1, _sheetColumn++].Value = "Residual Sugar";
        workSheet.Cells[1, _sheetColumn++].Value = "Grape Varietals (% each)";
        workSheet.Cells[1, _sheetColumn++].Value = "Variety (% of each) (Barley, Corn, Oats, Rye, Wheat)";
        workSheet.Cells[1, _sheetColumn++].Value = "Aroma/Flavour";
        workSheet.Cells[1, _sheetColumn++].Value = "HQ Contact Name";
        workSheet.Cells[1, _sheetColumn++].Value = "HQ Contact Name Position";
        workSheet.Cells[1, _sheetColumn++].Value = "HQ Address";
        workSheet.Cells[1, _sheetColumn++].Value = "HQ City";
        workSheet.Cells[1, _sheetColumn++].Value = "HQ Postal Code";
        workSheet.Cells[1, _sheetColumn++].Value = "HQ Country";
        workSheet.Cells[1, _sheetColumn++].Value = "HQ Phone Number";
        workSheet.Cells[1, _sheetColumn++].Value = "HQ Email";

        for (int i = 24; i <= 36; i++)
        {
            workSheet.Cells[1, i].Style.Font.Color.SetColor(System.Drawing.Color.White);
            workSheet.Cells[1, i].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
            workSheet.Cells[1, i].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(226, 107, 10));
        }
        for (int i = 37; i <= 51; i++)
        {
            workSheet.Cells[1, i].Style.Font.Color.SetColor(System.Drawing.Color.White);
            workSheet.Cells[1, i].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
            workSheet.Cells[1, i].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(112, 48, 160));
        }
        
        List<TMP_ProductInfoNew> list = MasterSKUListBAL.GetProductInfoData(AppStaticData.ConnectionString);
        int recordIndex = 2;

        foreach (var item in list)
        {
            _sheetColumn = 1;

            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CategoryCode;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.SubCategoryCode;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.SupplierCode;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.BrandCode;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ItemCode;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.GlazersProductCode;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.SupplierName;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.BrandName;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ProductName;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.AlternateName;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.SupplierLegalName;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.UPC_EAN_13;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.SCC_14;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ABV_Per;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Category;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.SubCategory;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ContainerType;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ContainerVolume;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Containers_Selling_Unit;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Containers_Selling_Unit;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Supplier_Internal_Code;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Supplier_Internal_Code2;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Supplier_Internal_Code3;
            
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_British_Columbia;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Alberta;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Saskatchewan;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Manitoba;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Ontario;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Quebec;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Newfoundland;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_New_Brunswick;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Nova_Scotia;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Prince_Edward_Island;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Northwest_Territories;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Nunavut;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.ACD_Yukon;

            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_British_Columbia;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Alberta;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Saskatchewan;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Manitoba;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Ontario;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Quebec;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Newfoundland;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_New_Brunswick;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Nova_Scotia;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Prince_Edward_Island;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Northwest_Territories;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Nunavut;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Yukon;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Quebec_Private_Order;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.CSPC_Ontario_Consignment;
            
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.PM_Owner;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Closure_Type;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Closure_Weight;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Bottle_Weight;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Bottle_Height;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Bottle_Length;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Bottle_Width;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Empty_Bottle_Weight;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Lead_Time;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Shipping_Term;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Product_Designation;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Origin_Country;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Case_Height;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Case_Width;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Case_Length;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Case_Weight;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Cases_Per_Pallet;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Layers_Per_Pallet;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Cases_Per_Layer;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Cases_20ft_Container;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Cases_40ft_Container;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Cases_40ft_Heated_Container;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Appellation;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Colour;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Residual_Sugar;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Grape_Varietals;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Variety;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.Flavour;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.HQ_Contact_Name;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.HQ_Contact_Name_Position;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.HQ_Address;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.HQ_City;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.HQ_Postal_Code;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.HQ_Country;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.HQ_Phone_Number;
            workSheet.Cells[recordIndex, _sheetColumn++].Value = item.HQ_Email;

            recordIndex++;
        }

        for (int i = 1; i < 86; i++)
        {
            workSheet.Column(i).AutoFit();
        }
        
        string excelName = "SGWS Master Item List";
        using (var memoryStream = new MemoryStream())
        {
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment; filename=" + excelName + ".csv");
            excel.SaveAs(memoryStream);
            memoryStream.WriteTo(Response.OutputStream);
            Response.Flush();
            Response.End();
        }
    }

}