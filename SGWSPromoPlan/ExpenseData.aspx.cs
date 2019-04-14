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
using System.Web.UI.WebControls;

public partial class ExpenseData : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                Page.Title = AdminPageTitles.ImportExpenseData;

                if (SessionFacade.LoggedInUser.Role == RoleIDs.Admin)
                {
                    HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                    h2PageTitle.InnerText = AdminPageTitles.ImportExpenseData;

                    HtmlGenericControl liImportExpenseData = (HtmlGenericControl)Page.Master.FindControl("liImportExpenseData");
                    liImportExpenseData.Attributes.Add("class", "active");

                    HtmlGenericControl spanImportExpenseData = (HtmlGenericControl)Page.Master.FindControl("spanImportExpenseData");
                    spanImportExpenseData.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                    //BindSGWSFiscal();
                    BindDropdowns();
                    SetBreadCrumb(AdminPageTitles.ImportExpenseData, null, null);
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
    }

    private void BindDropdowns()
    {
        DataSet ds = new DataSet();
        ExpenseDataBAL oBAL = new ExpenseDataBAL();       
        ds = oBAL.GetImportExpenseDropdown(AppStaticData.ConnectionString, Convert.ToString(SessionFacade.LoggedInUser.UserId));
        if (ds != null)
        {
            ddlSGWSCalendar.DataTextField = "Year";
            ddlSGWSCalendar.DataValueField = "Year";
            ddlSGWSCalendar.DataSource = ds.Tables[0];
            ddlSGWSCalendar.DataBind();
            ddlSGWSCalendar.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlSGWSCalendar.SelectedValue = DateTime.Now.Year.ToString();

            ddlProvince.DataTextField = "Province";
            ddlProvince.DataValueField = "Id";
            ddlProvince.DataSource = ds.Tables[1];
            ddlProvince.DataBind();
            if(ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    if (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectedProvince"]))
                    {
                        if (i == 0)
                            hdnProvince.Value = Convert.ToString(ds.Tables[1].Rows[i]["Id"]);
                        else
                            hdnProvince.Value = hdnProvince.Value + "," + Convert.ToString(ds.Tables[1].Rows[i]["Id"]);
                    }
                }
            }
            //    ddlProvince.SelectedValue = Convert.ToString(ds.Tables[1].Rows[0]["Id"]);
            //ddlProvince.Items.Insert(0, new ListItem("--Select--", "0"));


            ddlSuppliers.DataTextField = "SupplierName";
            ddlSuppliers.DataValueField = "Id";
            ddlSuppliers.DataSource = ds.Tables[2];
            ddlSuppliers.DataBind();
            if (ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                {
                    if (Convert.ToBoolean(ds.Tables[2].Rows[i]["SelectedSupplier"]))
                    {
                        if (i == 0)
                            hdnSuppliers.Value = Convert.ToString(ds.Tables[2].Rows[i]["Id"]);
                        else
                            hdnSuppliers.Value = hdnProvince.Value + "," + Convert.ToString(ds.Tables[2].Rows[i]["Id"]);
                    }
                }
            }
            //if (ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
            //    ddlSuppliers.SelectedValue = Convert.ToString(ds.Tables[2].Rows[0]["Id"]);
            //ddlSuppliers.Items.Insert(0, new ListItem("--Select--", "0"));
        }
    }

        
    [System.Web.Services.WebMethod]
    [ScriptMethod(UseHttpGet = false)]
    public static string GetFileData(string fileName, int year, string province, string suppliers)
    {
        try
        {
            var jsonString = ExcelHelper.ImportExpenseData(HostingEnvironment.MapPath("~/UploadedFiles/") + fileName);

            ExpenseDataBAL oExpenseDataBAL = new ExpenseDataBAL();
            int result = oExpenseDataBAL.InsertExpenseData(AppStaticData.ConnectionString, jsonString,
                                                                            fileName, SessionFacade.LoggedInUser.UserId);
            if (result > 0)
            {
                List<Expense> list = oExpenseDataBAL.GetExpenseData(AppStaticData.ConnectionString,year, province, suppliers, Convert.ToString(SessionFacade.LoggedInUser.UserId));

                return JsonConvert.SerializeObject(new { jsonData = list });
                //return JsonConvert.SerializeObject(new { jsonData = jsonString });
            }
            else
            {
                return JsonConvert.SerializeObject(new { jsonData = "[]" });
            }
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("ExpenseData.cs => GetFileData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    [System.Web.Services.WebMethod(EnableSession =true)]
    [ScriptMethod(UseHttpGet = true)]
    public static string GetExpenseData(int year, string province, string suppliers)
    {
        try
        {
            //if (province.Length > 0 || suppliers.Length > 0)
            //{
                ExpenseDataBAL oExpenseDataBAL = new ExpenseDataBAL();
                List<Expense> list = oExpenseDataBAL.GetExpenseData(AppStaticData.ConnectionString, year, province, suppliers,Convert.ToString(SessionFacade.LoggedInUser.UserId));
                string josnString = JsonConvert.SerializeObject(list);

                return josnString;
            //}
            //else
            //    return "";
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("ExpenseData => GetProductData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    protected void ExportExcel_Click(object sender, EventArgs e)
    {

        ExcelPackage excel = new ExcelPackage();
        var workSheet = excel.Workbook.Worksheets.Add("Master List");
        workSheet.TabColor = System.Drawing.Color.Black;
        workSheet.DefaultRowHeight = 12;
        //Header of table  
        //  
        workSheet.Row(1).Height = 20;
        workSheet.Row(1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        workSheet.Row(1).Style.Font.Bold = true;
        workSheet.Cells[1, 1].Value = "Category Code";
        workSheet.Cells[1, 2].Value = "Subcategory Code";
        workSheet.Cells[1, 3].Value = "Supplier Code";
        workSheet.Cells[1, 4].Value = "Brand Code";
        workSheet.Cells[1, 5].Value = "Item Code";
        workSheet.Cells[1, 6].Value = "GLAZERS PRODUCT CODE";
        workSheet.Cells[1, 7].Value = "Supplier Name";
        workSheet.Cells[1, 8].Value = "Brand Name";
        workSheet.Cells[1, 9].Value = "Product Name";
        workSheet.Cells[1, 10].Value = "Alternate Name";
        workSheet.Cells[1, 11].Value = "Supplier Legal Names";
        workSheet.Cells[1, 12].Value = "UPC/EAN-13";
        workSheet.Cells[1, 13].Value = "SCC-14";
        workSheet.Cells[1, 14].Value = "ABV%";
        workSheet.Cells[1, 15].Value = "Category";
        workSheet.Cells[1, 16].Value = "Sub Category";
        workSheet.Cells[1, 17].Value = "Container Type";
        workSheet.Cells[1, 18].Value = "Container Volume (ml)";
        workSheet.Cells[1, 19].Value = "Containers/Selling Unit";
        workSheet.Cells[1, 20].Value = "Selling Units/Case";
        workSheet.Cells[1, 21].Value = "Supplier Internal Code";
        workSheet.Cells[1, 22].Value = "Supplier Internal Code 2";
        workSheet.Cells[1, 23].Value = "Supplier Internal Code 3";
        workSheet.Cells[1, 24].Value = "BRITISH COLUMBIA";
        workSheet.Cells[1, 25].Value = "ALBERTA";
        workSheet.Cells[1, 26].Value = "SASKATCHEWAN";
        workSheet.Cells[1, 27].Value = "MANITOBA";
        workSheet.Cells[1, 28].Value = "ONTARIO";
        workSheet.Cells[1, 29].Value = "QUEBEC";
        workSheet.Cells[1, 30].Value = "NEWFOUNDLAND";
        workSheet.Cells[1, 31].Value = "NEW BRUNSWICK";
        workSheet.Cells[1, 32].Value = "NOVA SCOTIA";
        workSheet.Cells[1, 33].Value = "PRINCE EDWARD ISLAND";
        workSheet.Cells[1, 34].Value = "NORTHWEST TERRITORIES";
        workSheet.Cells[1, 35].Value = "NUNAVUT";
        workSheet.Cells[1, 36].Value = "YUKON";
        workSheet.Cells[1, 37].Value = "BRITISH COLUMBIA";
        workSheet.Cells[1, 38].Value = "ALBERTA";
        workSheet.Cells[1, 39].Value = "SASKATCHEWAN";
        workSheet.Cells[1, 40].Value = "MANITOBA";
        workSheet.Cells[1, 41].Value = "ONTARIO";
        workSheet.Cells[1, 42].Value = "QUEBEC";
        workSheet.Cells[1, 43].Value = "NEWFOUNDLAND";
        workSheet.Cells[1, 44].Value = "NEW BRUNSWICK";
        workSheet.Cells[1, 45].Value = "NOVA SCOTIA";
        workSheet.Cells[1, 46].Value = "PRINCE EDWARD ISLAND";
        workSheet.Cells[1, 47].Value = "NORTHWEST TERRITORIES";
        workSheet.Cells[1, 48].Value = "NUNAVUT";
        workSheet.Cells[1, 49].Value = "YUKON";
        workSheet.Cells[1, 50].Value = "QUEBEC PRIVATE ORDER";
        workSheet.Cells[1, 51].Value = "Closure Type";
        workSheet.Cells[1, 52].Value = "Closure Weight (grams)";
        workSheet.Cells[1, 53].Value = "Bottle Weight (grams)";
        workSheet.Cells[1, 54].Value = "Bottle Height (cm)";
        workSheet.Cells[1, 55].Value = "Bottle Length (cm)";
        workSheet.Cells[1, 56].Value = "Bottle Width (cm)";
        workSheet.Cells[1, 57].Value = "Empty Bottle Weight (grams)";
        workSheet.Cells[1, 58].Value = "Lead Time (Days)";
        workSheet.Cells[1, 59].Value = "Shipping Term";
        workSheet.Cells[1, 60].Value = "Product Designation";
        workSheet.Cells[1, 61].Value = "Origin Country";
        workSheet.Cells[1, 62].Value = "Case Height (cm)";
        workSheet.Cells[1, 63].Value = "Case Width (cm)";
        workSheet.Cells[1, 64].Value = "Case Length (cm)";
        workSheet.Cells[1, 65].Value = "Case Weight (kg)";
        workSheet.Cells[1, 66].Value = "Cases Per Pallet";
        workSheet.Cells[1, 67].Value = "Layers Per Pallet";
        workSheet.Cells[1, 68].Value = "Cases Per Layer";
        workSheet.Cells[1, 69].Value = "Cases / 20ft Container";
        workSheet.Cells[1, 70].Value = "Cases / 40ft Container";
        workSheet.Cells[1, 71].Value = "Cases / 40ft Heated Container";
        workSheet.Cells[1, 72].Value = "Appellation";
        workSheet.Cells[1, 73].Value = "Colour";
        workSheet.Cells[1, 74].Value = "Residual Sugar";
        workSheet.Cells[1, 75].Value = "Grape Varietals (% each)";
        workSheet.Cells[1, 76].Value = "Variety (% of each) (Barley, Corn, Oats, Rye, Wheat)";
        workSheet.Cells[1, 77].Value = "Aroma/Flavour";
        workSheet.Cells[1, 78].Value = "HQ Contact Name";
        workSheet.Cells[1, 79].Value = "HQ Contact Name Position";
        workSheet.Cells[1, 80].Value = "HQ Address";
        workSheet.Cells[1, 81].Value = "HQ City";
        workSheet.Cells[1, 82].Value = "HQ Postal Code";
        workSheet.Cells[1, 83].Value = "HQ Country";
        workSheet.Cells[1, 84].Value = "HQ Phone Number";
        workSheet.Cells[1, 85].Value = "HQ Email";

        for (int i = 25; i <= 36; i++)
        {
            workSheet.Cells[1, i].Style.Font.Color.SetColor(System.Drawing.Color.White);
            workSheet.Cells[1, i].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
            workSheet.Cells[1, i].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(226, 107, 10));
        }
        for (int i = 37; i <= 50; i++)
        {
            workSheet.Cells[1, i].Style.Font.Color.SetColor(System.Drawing.Color.White);
            workSheet.Cells[1, i].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
            workSheet.Cells[1, i].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(112, 48, 160));
        }

        List<TMP_ProductInfoNew> list = MasterSKUListBAL.GetProductInfoData(AppStaticData.ConnectionString);
        int recordIndex = 2;
        foreach (var item in list)
        {
            workSheet.Cells[recordIndex, 1].Value = item.CategoryCode;
            workSheet.Cells[recordIndex, 2].Value = item.SubCategoryCode;
            workSheet.Cells[recordIndex, 3].Value = item.SupplierCode;
            workSheet.Cells[recordIndex, 4].Value = item.BrandCode;
            workSheet.Cells[recordIndex, 5].Value = item.ItemCode;
            workSheet.Cells[recordIndex, 6].Value = item.GlazersProductCode;
            workSheet.Cells[recordIndex, 7].Value = item.SupplierName;
            workSheet.Cells[recordIndex, 8].Value = item.BrandName;
            workSheet.Cells[recordIndex, 9].Value = item.ProductName;
            workSheet.Cells[recordIndex, 10].Value = item.AlternateName;
            workSheet.Cells[recordIndex, 11].Value = item.SupplierLegalName;
            workSheet.Cells[recordIndex, 12].Value = item.UPC_EAN_13;
            workSheet.Cells[recordIndex, 13].Value = item.SCC_14;
            workSheet.Cells[recordIndex, 14].Value = item.ABV_Per;
            workSheet.Cells[recordIndex, 15].Value = item.Category;
            workSheet.Cells[recordIndex, 16].Value = item.SubCategory;
            workSheet.Cells[recordIndex, 17].Value = item.ContainerType;
            workSheet.Cells[recordIndex, 18].Value = item.ContainerVolume;
            workSheet.Cells[recordIndex, 19].Value = item.Containers_Selling_Unit;
            workSheet.Cells[recordIndex, 20].Value = item.Containers_Selling_Unit;
            workSheet.Cells[recordIndex, 21].Value = item.Supplier_Internal_Code;
            workSheet.Cells[recordIndex, 22].Value = item.Supplier_Internal_Code2;
            workSheet.Cells[recordIndex, 23].Value = item.Supplier_Internal_Code3;
            workSheet.Cells[recordIndex, 24].Value = item.CSPC_British_Columbia;
            workSheet.Cells[recordIndex, 25].Value = item.CSPC_Alberta;
            workSheet.Cells[recordIndex, 26].Value = item.CSPC_Saskatchewan;
            workSheet.Cells[recordIndex, 27].Value = item.CSPC_Manitoba;
            workSheet.Cells[recordIndex, 28].Value = item.CSPC_Ontario;
            workSheet.Cells[recordIndex, 29].Value = item.CSPC_Quebec;
            workSheet.Cells[recordIndex, 30].Value = item.CSPC_Newfoundland;
            workSheet.Cells[recordIndex, 31].Value = item.CSPC_New_Brunswick;
            workSheet.Cells[recordIndex, 32].Value = item.CSPC_Nova_Scotia;
            workSheet.Cells[recordIndex, 33].Value = item.CSPC_Prince_Edward_Island;
            workSheet.Cells[recordIndex, 34].Value = item.CSPC_Northwest_Territories;
            workSheet.Cells[recordIndex, 35].Value = item.CSPC_Nunavut;
            workSheet.Cells[recordIndex, 36].Value = item.CSPC_Yukon;
            workSheet.Cells[recordIndex, 37].Value = item.ACD_British_Columbia;
            workSheet.Cells[recordIndex, 38].Value = item.ACD_Alberta;
            workSheet.Cells[recordIndex, 39].Value = item.ACD_Saskatchewan;
            workSheet.Cells[recordIndex, 40].Value = item.ACD_Manitoba;
            workSheet.Cells[recordIndex, 41].Value = item.ACD_Ontario;
            workSheet.Cells[recordIndex, 42].Value = item.ACD_Quebec;
            workSheet.Cells[recordIndex, 43].Value = item.ACD_Newfoundland;
            workSheet.Cells[recordIndex, 44].Value = item.ACD_New_Brunswick;
            workSheet.Cells[recordIndex, 45].Value = item.ACD_Nova_Scotia;
            workSheet.Cells[recordIndex, 46].Value = item.ACD_Prince_Edward_Island;
            workSheet.Cells[recordIndex, 47].Value = item.ACD_Northwest_Territories;
            workSheet.Cells[recordIndex, 48].Value = item.ACD_Nunavut;
            workSheet.Cells[recordIndex, 49].Value = item.ACD_Yukon;
            workSheet.Cells[recordIndex, 50].Value = item.ACD_Quebec;
            workSheet.Cells[recordIndex, 51].Value = item.Closure_Type;
            workSheet.Cells[recordIndex, 52].Value = item.Closure_Weight;
            workSheet.Cells[recordIndex, 53].Value = item.Bottle_Weight;
            workSheet.Cells[recordIndex, 54].Value = item.Bottle_Height;
            workSheet.Cells[recordIndex, 55].Value = item.Bottle_Length;
            workSheet.Cells[recordIndex, 56].Value = item.Bottle_Width;
            workSheet.Cells[recordIndex, 57].Value = item.Empty_Bottle_Weight;
            workSheet.Cells[recordIndex, 58].Value = item.Lead_Time;
            workSheet.Cells[recordIndex, 59].Value = item.Shipping_Term;
            workSheet.Cells[recordIndex, 60].Value = item.Product_Designation;
            workSheet.Cells[recordIndex, 61].Value = item.Origin_Country;
            workSheet.Cells[recordIndex, 62].Value = item.Case_Height;
            workSheet.Cells[recordIndex, 63].Value = item.Case_Width;
            workSheet.Cells[recordIndex, 64].Value = item.Case_Length;
            workSheet.Cells[recordIndex, 65].Value = item.Case_Weight;
            workSheet.Cells[recordIndex, 66].Value = item.Cases_Per_Pallet;
            workSheet.Cells[recordIndex, 67].Value = item.Layers_Per_Pallet;
            workSheet.Cells[recordIndex, 68].Value = item.Cases_Per_Layer;
            workSheet.Cells[recordIndex, 69].Value = item.Cases_20ft_Container;
            workSheet.Cells[recordIndex, 70].Value = item.Cases_40ft_Container;
            workSheet.Cells[recordIndex, 71].Value = item.Cases_40ft_Heated_Container;
            workSheet.Cells[recordIndex, 72].Value = item.Appellation;
            workSheet.Cells[recordIndex, 73].Value = item.Colour;
            workSheet.Cells[recordIndex, 74].Value = item.Residual_Sugar;
            workSheet.Cells[recordIndex, 75].Value = item.Grape_Varietals;
            workSheet.Cells[recordIndex, 76].Value = item.Variety;
            workSheet.Cells[recordIndex, 77].Value = item.Flavour;
            workSheet.Cells[recordIndex, 78].Value = item.HQ_Contact_Name;
            workSheet.Cells[recordIndex, 79].Value = item.HQ_Contact_Name_Position;
            workSheet.Cells[recordIndex, 80].Value = item.HQ_Address;
            workSheet.Cells[recordIndex, 81].Value = item.HQ_City;
            workSheet.Cells[recordIndex, 82].Value = item.HQ_Postal_Code;
            workSheet.Cells[recordIndex, 83].Value = item.HQ_Country;
            workSheet.Cells[recordIndex, 84].Value = item.HQ_Phone_Number;
            workSheet.Cells[recordIndex, 85].Value = item.HQ_Email;


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