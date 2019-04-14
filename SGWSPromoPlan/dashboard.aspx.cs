using Newtonsoft.Json;
using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class adminsection_dashboard : BasePage
{
    public string Co2eCategories = string.Empty;
    public string Co2eData = string.Empty;
    public string FuelConsumptionCategories = string.Empty;
    public string FuelConsumptionData = string.Empty;
    public string FederalReportData = string.Empty;
    public string FederalReportFacilities = string.Empty;
    public string CarbonLevyData = string.Empty;
    public string CarbonLevyCategories = string.Empty;
    public string CarbonLevyProvinces = string.Empty;
    public string CarbonLevyLink = string.Empty;
    private DateTime FromDate
    {
        get
        {
            if (ViewState["FromDate"] != null)
                return Convert.ToDateTime(ViewState["FromDate"]);
            else
                return DateTime.Now;
        }
        set { ViewState["FromDate"] = value; }
    }

    private DateTime ToDate
    {
        get
        {
            if (ViewState["ToDate"] != null)
                return Convert.ToDateTime(ViewState["ToDate"]);
            else
                return DateTime.Now;
        }
        set { ViewState["ToDate"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        loadInitials();
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                BindDropdown();
            }
            else
                Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
        }
    }

    private void loadInitials()
    {
        HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
        h2PageTitle.InnerText = AdminPageTitles.Dashboard;
        Page.Title = AdminPageTitles.Dashboard;
      
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
    public static string LoadCategoryProductData()
    {
        try
        {
            List<Chart_GetProductCountByCategory> list = ChartRepositoryBAL.GetProgramDetail(AppStaticData.ConnectionString);
            if (list == null)
            {
                list = new List<Chart_GetProductCountByCategory>();
            }

            List<string> xaxis = new List<string>();

            foreach (Chart_GetProductCountByCategory item in list)
            {
                xaxis.Add(item.Category);
            }


            string jsonString = Newtonsoft.Json.JsonConvert.SerializeObject(list);
            jsonString = jsonString.Replace("Total", "y");
            return JsonConvert.SerializeObject(new { xaxisData = xaxis, yaxisData = jsonString });
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("Dashboard.cs => LoadCategoryProductData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
    public static string LoadTop10Suppliers()
    {
        try
        {
            List<Chart_GetTop10Suppliers> list = ChartRepositoryBAL.GetTop10Suppliers(AppStaticData.ConnectionString);
            if (list == null)
            {
                list = new List<Chart_GetTop10Suppliers>();
            }

            List<string> xaxis = new List<string>();

            foreach (Chart_GetTop10Suppliers item in list)
            {
                xaxis.Add(item.SupplierName);
            }


            string jsonString = Newtonsoft.Json.JsonConvert.SerializeObject(list);
            jsonString = jsonString.Replace("Total", "y");
            return JsonConvert.SerializeObject(new { xaxisData = xaxis, yaxisData = jsonString });
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("Dashboard.cs => LoadTop10Suppliers ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    private void BindDropdown()
    {
        if (string.IsNullOrWhiteSpace(Convert.ToString(Session["ddlProgramTypes"])) ||
            string.IsNullOrWhiteSpace(Convert.ToString(Session["ddlATL_BTL"])) ||
            string.IsNullOrWhiteSpace(Convert.ToString(Session["ddlProgramStatus"])))
        {
            DataSet ds = new DataSet();
            ds = ManageProgramBAL.GetProgramPopupDropdowns(AppStaticData.ConnectionString);
            if (ds != null && ds.Tables.Count > 0)
            {
                Session["ddlProgramTypes"] = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
                Session["ddlATL_BTL"] = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);
                Session["ddlProgramStatus"] = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[2]);
            }
        }
    }


}