using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class RegionalView : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                BindDropdown();
                Page.Title = AdminPageTitles.RegionalView;

                HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                h2PageTitle.InnerText = AdminPageTitles.RegionalView;
                HtmlGenericControl liRegionalViewByBrand = (HtmlGenericControl)Page.Master.FindControl("liRegionalViewByBrand");
                liRegionalViewByBrand.Attributes.Add("class", "active");
                HtmlGenericControl spanRegionalViewByBrand = (HtmlGenericControl)Page.Master.FindControl("spanRegionalViewByBrand");
                spanRegionalViewByBrand.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                SetBreadCrumb(AdminPageTitles.RegionalView, null, null);
            }
            else
            {
                Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
            }
        }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object LoadData()
    {
        try
        {
            DataTables result = new DataTables();
            int totalRecords = 0;

            string search = HttpContext.Current.Request.Params["search[value]"];
            string draw = HttpContext.Current.Request.Params["draw"];
            int order = Convert.ToInt32(HttpContext.Current.Request.Params["order[0][column]"]);
            string orderDir = HttpContext.Current.Request.Params["order[0][dir]"];
            int startRec = Convert.ToInt32(HttpContext.Current.Request.Params["start"]);
            int pageSize = Convert.ToInt32(HttpContext.Current.Request.Params["length"]);

            if (!string.IsNullOrEmpty(search))
            {
                SessionFacade.RegionalViewFilters = new SessionFacade.RegionalViewFilterSelection();
                string[] strArr = search.Split('|');
                int length = 0;
                foreach (string item in strArr)
                {
                    length = item.IndexOf(")") - item.IndexOf("(") - 1;

                    if (item.Contains("SGWS_Calendar_Year"))
                    {
                        SessionFacade.RegionalViewFilters.SGWS_Period_DDL = item.Substring(item.IndexOf(":") + 1, 4);
                    }
                    //if (item.Contains("FiscalYearByLiquorBoardId"))
                    //{
                    //    length = item.Length - item.IndexOf(":")  - 1;
                    //    SessionFacade.RegionalViewFilters.Liquor_Board_Period = item.Substring(item.IndexOf(":") + 1, length);
                    //}
                    if (item.Contains("ProvinceCode"))
                    {
                        SessionFacade.RegionalViewFilters.Province = item.Substring(item.IndexOf("(") + 1, length);
                    }
                    if (item.Contains("CategoryId"))
                    {
                        SessionFacade.RegionalViewFilters.Category = item.Substring(item.IndexOf("(") + 1, length);
                    }
                    if (item.Contains("SupplierId"))
                    {
                        SessionFacade.RegionalViewFilters.Supplier = item.Substring(item.IndexOf("(") + 1, length);
                    }
                    if (item.Contains("BrandId"))
                    {
                        SessionFacade.RegionalViewFilters.Brand = item.Substring(item.IndexOf("(") + 1, length);
                    }
                    if (item.Contains("RDB"))
                    {
                        if (item.Substring(item.IndexOf(":") + 1, 4) == "SGWS")
                        {
                            SessionFacade.RegionalViewFilters.SGWS_Period = "true";
                            SessionFacade.RegionalViewFilters.Liquor_Board_Period = "";
                        }
                        else
                        {
                            SessionFacade.RegionalViewFilters.Liquor_Board_Period = "true";
                            SessionFacade.RegionalViewFilters.SGWS_Period = "";
                        }

                    }
                }
            }
            search = search.Replace("|RDB:SGWS", "").Replace("|RDB:LIQR", "");
            List<USP_Reports_GetRegionalViewByBrand> list = ManageProgramBAL.GetRegionalViewByBrandData(AppStaticData.ConnectionString, pageSize
                , startRec, order, orderDir, search, SessionFacade.LoggedInUser.UserId);

            if (SessionFacade.RegionalViewFilters != null &&
                  !string.IsNullOrEmpty(SessionFacade.RegionalViewFilters.Liquor_Board_Period))
            {
                list = list.Select(c => { c.Custom_SGWS_Period_Or_Liquor_Period = c.LiquorBoardPeriod; return c; }).ToList();
            }
            else
            {
                list = list.Select(c => { c.Custom_SGWS_Period_Or_Liquor_Period = c.SGWS_Calendar_Period; return c; }).ToList();
            }

            SessionFacade.RegionalViewDetailsDataList = list;

            if (list == null)
            {
                list = new List<USP_Reports_GetRegionalViewByBrand>();
                totalRecords = 0;
            }
            else
            {
                if (list.Count() > 0)
                    totalRecords = list.FirstOrDefault().TotalRecords;
            }


            List<USP_Reports_GetRegionalViewByBrand> listGroup = new List<USP_Reports_GetRegionalViewByBrand>();

            if (SessionFacade.RegionalViewFilters != null &&
                    !string.IsNullOrEmpty(SessionFacade.RegionalViewFilters.Liquor_Board_Period))
            {
                var groupList = list.GroupBy(t => new { t.LiquorBoardPeriod })
               .Select(x => new
               {
                   x.FirstOrDefault().SGWS_Calendar_Period,
                   x.FirstOrDefault().LiquorBoardPeriod,
                   x.FirstOrDefault().Custom_SGWS_Period_Or_Liquor_Period,
                   TotalProgramSpend = x.Where(t => !t.ProgramStatusCode.Contains("REJECTED")).Sum(p => p.TotalProgramSpend)
               });


                foreach (var item in groupList)
                {
                    listGroup.Add(new USP_Reports_GetRegionalViewByBrand()
                    {
                        Custom_SGWS_Calendar_Period = item.LiquorBoardPeriod + "(" + item.SGWS_Calendar_Period + ")",
                        SGWS_Calendar_Period = item.SGWS_Calendar_Period,
                        LiquorBoardPeriod = item.LiquorBoardPeriod,
                        Custom_SGWS_Period_Or_Liquor_Period = item.Custom_SGWS_Period_Or_Liquor_Period,
                        TotalProgramSpend = item.TotalProgramSpend
                    });

                }
            }
            else
            {
                var groupList = list.GroupBy(t => new { t.SGWS_Calendar_Period })
              .Select(x => new
              {
                  x.FirstOrDefault().SGWS_Calendar_Period,
                  x.FirstOrDefault().LiquorBoardPeriod,
                  x.FirstOrDefault().Custom_SGWS_Period_Or_Liquor_Period,
                  TotalProgramSpend = x.Where(t => !t.ProgramStatusCode.Contains("REJECTED")).Sum(p => p.TotalProgramSpend)
              });


                foreach (var item in groupList)
                {
                    listGroup.Add(new USP_Reports_GetRegionalViewByBrand()
                    {
                        Custom_SGWS_Calendar_Period = item.SGWS_Calendar_Period + "(" + item.LiquorBoardPeriod + ")",
                        SGWS_Calendar_Period = item.SGWS_Calendar_Period,
                        LiquorBoardPeriod = item.LiquorBoardPeriod,
                        Custom_SGWS_Period_Or_Liquor_Period = item.Custom_SGWS_Period_Or_Liquor_Period,
                        TotalProgramSpend = item.TotalProgramSpend
                    });

                }
            }

            result.draw = Convert.ToInt32(draw);
            result.recordsTotal = totalRecords;
            result.recordsFiltered = totalRecords;
            result.data = listGroup;

            return result;
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("RegionalView.cs => GetRegionalViewByBrandData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static string LoadCampaign(string _SGWSPeriod, string _LiquorBoardPeriod)
    {
        DataTables result = new DataTables();
        try
        {
            string jsonString = string.Empty;
            string tableName = string.Empty;
            StringBuilder sb = new StringBuilder();
            List<USP_Reports_GetRegionalViewByBrand> list = SessionFacade.RegionalViewDetailsDataList;

            if (list != null)
            {
                if (SessionFacade.RegionalViewFilters != null &&
                    !string.IsNullOrEmpty(SessionFacade.RegionalViewFilters.Liquor_Board_Period))
                {

                    var compaign = list.Where(t => t.LiquorBoardPeriod == _LiquorBoardPeriod).GroupBy(t => t.LiquorBoardPeriod)
                        .Select(x => new
                        {
                            x.FirstOrDefault().SuperProgramId,
                            x.FirstOrDefault().SuperProgramName,
                            x.FirstOrDefault().SGWS_Calendar_Period,
                            x.FirstOrDefault().LiquorBoardPeriod,
                            x.FirstOrDefault().Custom_SGWS_Period_Or_Liquor_Period
                        });


                    foreach (var item in compaign)
                    {

                        sb.Append("<tr>");

                        sb.Append("<td>");
                        sb.Append(item.SuperProgramName);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(item.SuperProgramId);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(item.SGWS_Calendar_Period);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(item.LiquorBoardPeriod);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(item.Custom_SGWS_Period_Or_Liquor_Period);
                        sb.Append("</td>");

                        sb.Append("</tr>");
                    }
                    tableName = _LiquorBoardPeriod;
                }
                else
                {
                    var compaign = list.Where(t => t.SGWS_Calendar_Period == _SGWSPeriod).GroupBy(t => t.SGWS_Calendar_Period)
                       .Select(x => new
                       {
                           x.FirstOrDefault().SuperProgramId,
                           x.FirstOrDefault().SuperProgramName,
                           x.FirstOrDefault().SGWS_Calendar_Period,
                           x.FirstOrDefault().LiquorBoardPeriod,
                           x.FirstOrDefault().Custom_SGWS_Period_Or_Liquor_Period
                       });


                    foreach (var item in compaign)
                    {
                        sb.Append("<tr>");

                        sb.Append("<td>");
                        sb.Append(item.SuperProgramName);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(item.SuperProgramId);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(item.SGWS_Calendar_Period);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(item.LiquorBoardPeriod);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(item.Custom_SGWS_Period_Or_Liquor_Period);
                        sb.Append("</td>");

                        sb.Append("</tr>");
                    }
                    tableName = _SGWSPeriod;
                }
                return "<table id='tblCompaign" + tableName + "'><tbody>" + sb.ToString() + "</tbody></table>";
            }
            else
            {
                return string.Empty;
            }
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("RegionalView.cs => LoadCampaign ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static string LoadDetailData(string _SGWSPeriod, string _LiquorBoardPeriod)
    {
        try
        {
            string jsonString = string.Empty;
            List<USP_Reports_GetRegionalViewByBrand> list = SessionFacade.RegionalViewDetailsDataList;
            if (list != null)
            {
                if (SessionFacade.RegionalViewFilters != null &&
                   !string.IsNullOrEmpty(SessionFacade.RegionalViewFilters.Liquor_Board_Period))
                {
                    list = list.Where(t => t.LiquorBoardPeriod == _LiquorBoardPeriod).ToList();
                }
                else
                {
                    list = list.Where(t => t.SGWS_Calendar_Period == _SGWSPeriod).ToList();
                }
                string headers = string.Empty;

                StringBuilder sb = new StringBuilder();
                sb.Append("<thead><tr>");
                sb.Append("<th>");
                sb.Append("");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Start Date");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("End Date");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Above The Line");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Program Type");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Activity");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Is The Program SKU");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Product Description");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Size");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Containers Selling Units");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Selling Units/Case");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Status");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Sum of Total Program Spend");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("Sum of actual spend");
                sb.Append("</th>");
                sb.Append("<th>");
                sb.Append("");
                sb.Append("</th>");

                sb.Append("</tr></thead>");

                //headers = sb.ToString();
                sb = new StringBuilder();
                int counter = 0;
                foreach (var item in list)
                {
                    if (item.ProgramStatusCode.Contains("REJECTED"))
                    {
                        sb.Append("<tr class='rejected'>");
                    }
                    else
                    {
                        sb.Append("<tr>");
                    }
                    if (counter == 0)
                    {
                        sb.Append("<td class='size_Period'>");
                        if (SessionFacade.RegionalViewFilters != null &&
                            !string.IsNullOrEmpty(SessionFacade.RegionalViewFilters.Liquor_Board_Period))
                        {
                            sb.Append(item.LiquorBoardPeriod);
                        }
                        else
                        {
                            //sb.Append(item.SGWS_Calendar_Period);
                        }
                        sb.Append("</td>");

                        sb.Append("<td class='size_StartDate'>");
                        if (item.StartDate.HasValue)
                            sb.Append(item.StartDate.Value.ToString("yyyyMMdd"));
                        sb.Append("</td>");

                        sb.Append("<td class='size_EndDate'>");
                        if (item.EndDate.HasValue)
                            sb.Append(item.EndDate.Value.ToString("yyyyMMdd"));
                        sb.Append("</td>");
                    }
                    else
                    {
                        sb.Append("<td class='size_Period'>");
                        //if (item.IsAccess)
                        //    sb.Append("<a class='linkAllocateExpenses' href=\"/AllocateExpenses.aspx?ProgramId=" + item.ProgramId + "\">Allocate</a>");
                        //else
                        //    sb.Append("<span>Allocate</span>");
                        sb.Append(" ");
                        sb.Append("</td>");
                        sb.Append("<td class='size_StartDate'>");
                        sb.Append(" ");
                        sb.Append("</td>");
                        sb.Append("<td class='size_EndDate'>");
                        sb.Append(" ");
                        sb.Append("</td>");
                    }
                    counter++;
                    sb.Append("<td class='size_ATLBTL'>");
                    sb.Append(item.AboveTheLineBelowTheLineName);
                    sb.Append("</td>");
                    sb.Append("<td class='size_PType'>");
                    sb.Append(item.ProgramType);
                    sb.Append("</td>");
                    //sb.Append("<td class='size_Activity'>");
                    //sb.Append(item.ProgramId);
                    //sb.Append("</td>");
                    sb.Append("<td class='size_IsSkuBased'>");
                    if (item.IsSkuBased)
                        sb.Append("SKU");
                    else
                        sb.Append("Brand");
                    sb.Append("</td>");

                    sb.Append("<td class='size_ProgramDescription'>");
                    sb.Append(item.Comment);
                    sb.Append("</td>");

                    sb.Append("<td class='size_AlternateName'>");
                    sb.Append(item.AlternateName);
                    sb.Append("</td>");
                    //sb.Append("<td class='size_ContainerVolume'>");
                    //sb.Append(item.ContainerVolume);
                    //sb.Append("</td>");
                    //sb.Append("<td class='size_Selling_Unit'>");
                    //sb.Append(item.Containers_Selling_Unit);
                    //sb.Append("</td>");
                    //sb.Append("<td class='size_Units_Case'>");
                    //sb.Append(item.Selling_Units_Case);
                    //sb.Append("</td>");
                    sb.Append("<td class='size_StatusCode'>");
                    sb.Append(GetPrograStatusDDLHTML(item.ProgramId.ToString(), item.ProgramStatusCode));
                    sb.Append("</td>");
                    sb.Append("<td class='size_ProgramSpend'>");
                    sb.Append(String.Format("{0:0.##}", item.TotalProgramSpend));
                    sb.Append("</td>");
                    sb.Append("<td class='size_ActualSpend'>");
                    sb.Append("0.00");
                    sb.Append("</td>");

                    if (item.IsAccess)
                        sb.Append("<td class='size_Period'><a class='linkAllocateExpenses' href=\"/AllocateExpenses.aspx?ProgramId=" + item.ProgramId + "\">Allocate</a>");
                    else
                        sb.Append("<td class='size_Period'><span>Allocate</span>");
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }
                string Cols = string.Empty;
                //Cols = "<colgroup>";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";
                //Cols = Cols + "<col span=\"1\" style=\"width: 100px; \">";

                //Cols = Cols + "</colgroup>";

                Cols = Cols + "<tbody class='FixedLayout' id='SP" + _SGWSPeriod.ToString() + "'>" + sb.ToString() + "</tbody>";
                //jsonString = "<div><input type=\"button\" id=\"btnAdd\" value=\"Add\" data-toggle=\"modal\" class=\"btn btn-primary\" onclick=\"ShowPopUp('" + superProgramId.ToString() + "');\" /></div>";
                jsonString = jsonString + "<div style=\"height: auto; width:100%;\">";
                jsonString = jsonString + "<table>" + headers + Cols + "</table>";
                jsonString = jsonString + "</div>";
            }
            else
            {
                jsonString = "<div> No Data</div>";
            }
            return jsonString;
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("RegionalView.cs => LoadDetailData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object UpdateProgramStatus(long programId, int programStatusId)
    {
        try
        {
            ManageProgramBAL.UpdateProgramStatus(AppStaticData.ConnectionString, programId, programStatusId);
            return "sucess";
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("RegionalView.cs => UpdateProgramStatus ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static string GetBrand(string SupplierId)
    {
        try
        {
            var list = SupplierId.Split(',');

            if (string.IsNullOrEmpty(SupplierId))
                return Newtonsoft.Json.JsonConvert.SerializeObject(SessionFacade.RegionalSupplierBrandData);
            else
                return Newtonsoft.Json.JsonConvert.SerializeObject(SessionFacade.RegionalSupplierBrandData.Where(t => list.Contains(t.SupplierId.ToString())).ToList());
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("RegionalView.cs => GetBrand ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    private void BindDropdown()
    {
        DataSet ds = new DataSet();
        ds = ManageProgramBAL.GetRegionalViewDropdowns(AppStaticData.ConnectionString);
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
            ddlProvince.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlCategory.DataTextField = "Category";
            ddlCategory.DataValueField = "Id";
            ddlCategory.DataSource = ds.Tables[2];
            ddlCategory.DataBind();
            //ddlCategory.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlSuppliers.DataTextField = "SupplierName";
            ddlSuppliers.DataValueField = "Id";
            ddlSuppliers.DataSource = ds.Tables[3];
            ddlSuppliers.DataBind();
            //ddlSuppliers.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlBrand.DataTextField = "BrandName";
            ddlBrand.DataValueField = "Id";
            ddlBrand.DataSource = ds.Tables[4];
            ddlBrand.DataBind();
            //ddlBrand.Items.Insert(0, new ListItem("--Select--", "0"));

            //ddlLiquorBoardPeriod.DataTextField = "Period";
            //ddlLiquorBoardPeriod.DataValueField = "Period";
            //ddlLiquorBoardPeriod.DataSource = ds.Tables[5];
            //ddlLiquorBoardPeriod.DataBind();
            //ddlLiquorBoardPeriod.Items.Insert(0, new ListItem("--Select--", "0"));

            SessionFacade.RegionalProgramStatusData = new List<ProgramStatus>();
            for (int i = 0; i < ds.Tables[6].Rows.Count; i++)
            {
                SessionFacade.RegionalProgramStatusData.Add(new ProgramStatus()
                {
                    Id = Convert.ToInt64(ds.Tables[6].Rows[i]["Id"]),
                    Code = Convert.ToString(ds.Tables[6].Rows[i]["Code"])
                });
            }

            SessionFacade.RegionalSupplierBrandData = new List<SupplierBrand>();
            for (int i = 0; i < ds.Tables[4].Rows.Count; i++)
            {
                SessionFacade.RegionalSupplierBrandData.Add(new SupplierBrand()
                {
                    Id = Convert.ToInt64(ds.Tables[4].Rows[i]["Id"]),
                    BrandName = Convert.ToString(ds.Tables[4].Rows[i]["BrandName"]),
                    SupplierId = Convert.ToInt64(ds.Tables[4].Rows[i]["SupplierId"])
                });
            }

            if (SessionFacade.RegionalViewFilters != null && Request.UrlReferrer != null && Request.UrlReferrer.AbsolutePath.Contains("AllocateExpenses"))
            {
                hdnProvince.Value = SessionFacade.RegionalViewFilters.Province;
                hdnSuppliers.Value = SessionFacade.RegionalViewFilters.Supplier;
                hdnBrand.Value = SessionFacade.RegionalViewFilters.Brand;
                hdnCategory.Value = SessionFacade.RegionalViewFilters.Category;
                ddlSGWSCalendar.SelectedValue = SessionFacade.RegionalViewFilters.SGWS_Period_DDL;
                if (!string.IsNullOrEmpty(SessionFacade.RegionalViewFilters.SGWS_Period))
                    rdoSGWSPeriod.Checked = true;
                else
                    rdoLiquorPeriod.Checked = true;

            }
            else
            {
                DataTable dtUser = ManageUserBAL.GetUser(AppStaticData.ConnectionString, SessionFacade.LoggedInUser.UserId.ToString());
                if (dtUser.Rows[0]["ProvinceId"] != DBNull.Value)
                    hdnProvince.Value = Convert.ToString(dtUser.Rows[0]["ProvinceId"]);

                if (hdnProvince.Value.Contains(","))
                    hdnProvince.Value = "";//If multiple provinces assigned to User then select to none

                if (dtUser.Rows[0]["SupplierId"] != DBNull.Value)
                    hdnSuppliers.Value = Convert.ToString(dtUser.Rows[0]["SupplierId"]);

                if (dtUser.Rows[0]["Brand"] != DBNull.Value)
                    hdnBrand.Value = Convert.ToString(dtUser.Rows[0]["Brand"]);
            }
        }
    }

    private static string GetPrograStatusDDLHTML(string programId, string code)
    {
        StringBuilder sb = new StringBuilder();
        foreach (ProgramStatus item in SessionFacade.RegionalProgramStatusData)
        {
            if (item.Code.Equals(code))
                sb.Append("<option value='" + item.Id.ToString() + "' selected='selected'>" + item.Code + "</option>");
            else
                sb.Append("<option value='" + item.Id.ToString() + "'>" + item.Code + "</option>");

        }
        string html = "<select  id='ddlProgramStatus' onchange='ChangeProgramStatus(this)' prgoramid='" + programId + "'>" + sb.ToString() + "</select>";
        return html;
    }
    private class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<USP_Reports_GetRegionalViewByBrand> data { get; set; }
    }
}

