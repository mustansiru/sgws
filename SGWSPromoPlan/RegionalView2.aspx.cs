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
using SGWSPromoPlan.DAL.Entities;

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

            // Store search criteria in session for subsequent child table loads from other methods
            SessionFacade.Criteria = new SessionFacade.SearchFilter
            {
                PageSize = pageSize,
                Order = order,
                OrderDirection = orderDir,
                SearchString = search,
                StartRecord = startRec
            };

            List<USP_Reports_GetRegionalViewByBrand_Periods> list = ManageProgramBAL.GetRegionalViewByBrandData_Periods(AppStaticData.ConnectionString, pageSize
                , startRec, order, orderDir, search, SessionFacade.LoggedInUser.UserId);

            if (list == null)
            {
                list = new List<USP_Reports_GetRegionalViewByBrand_Periods>();
                totalRecords = 0;
            }
            else
            {
                if (list.Any())
                {
                    totalRecords = list[0].TotalRecords;
                }
            }

            if (SessionFacade.RegionalViewFilters != null &&
                  !string.IsNullOrEmpty(SessionFacade.RegionalViewFilters.Liquor_Board_Period))
            {
                list = list.Select(c => { c.Custom_SGWS_Period_Or_Liquor_Period = c.LiquorBoardPeriod; return c; }).ToList();
            }
            else
            {
                list = list.Select(c => { c.Custom_SGWS_Period_Or_Liquor_Period = c.SGWS_Calendar_Period; return c; }).ToList();
            }

            //SessionFacade.RegionalViewDetailsDataList = list;

            


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
            SessionFacade.SearchFilter filter = SessionFacade.Criteria;

            string jsonString = string.Empty;
            string tableName = string.Empty;
            StringBuilder sb = new StringBuilder();
            List<USP_Reports_GetRegionalViewByBrand> list = ManageProgramBAL.GetRegionalViewByBrandData(
                AppStaticData.ConnectionString, filter.PageSize,
                filter.StartRecord, filter.Order, filter.OrderDirection, filter.SearchString,
                SessionFacade.LoggedInUser.UserId);
            
            //SessionFacade.RegionalViewDetailsDataList;

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
                            x.FirstOrDefault().Custom_SGWS_Period_Or_Liquor_Period,
                            x.FirstOrDefault().StartDate,
                            x.FirstOrDefault().EndDate
                        });


                    foreach (var item in compaign)
                    {

                        sb.Append("<tr>");

                        sb.Append("<td>");
                        sb.Append(item.SuperProgramName + " " + item.StartDate + " " + item.EndDate);
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
                           x.FirstOrDefault().Custom_SGWS_Period_Or_Liquor_Period,
                           x.FirstOrDefault().StartDate,
                           x.FirstOrDefault().EndDate
                       });


                    foreach (var item in compaign)
                    {
                        string nonBreakingSpace = string.Concat(Enumerable.Repeat("&nbsp;", 3));
                        sb.Append("<tr>");

                        sb.Append("<td>");
                        sb.Append(string.Format("<b>{0}</b>{1} Starts on: {2:yyyy-MMM-dd}, {1}Ends on: {3:yyyy-MMM-dd}", item.SuperProgramName,
                            nonBreakingSpace, item.StartDate, item.EndDate));
                        //sb.Append("<b>" + item.SuperProgramName + "</b>" + nonBreakingSpace + "Starts on:" + string.Format("{0:yyyy-MM-dd}", item.StartDate.Value) + "," + nonBreakingSpace + " Ends:" + string.Format("{0:yyyy-MM-dd}", item.EndDate.Value));
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
            SessionFacade.SearchFilter filter = SessionFacade.Criteria;

            string jsonString = string.Empty;
            //List<USP_Reports_GetRegionalViewByBrand> list = SessionFacade.RegionalViewDetailsDataList;
            List<USP_Reports_GetRegionalViewByBrand> list = ManageProgramBAL.GetRegionalViewByBrandData(
                AppStaticData.ConnectionString, filter.PageSize,
                filter.StartRecord, filter.Order, filter.OrderDirection, filter.SearchString,
                SessionFacade.LoggedInUser.UserId);
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
                //sb.Append("<th>");
                //sb.Append("");
                //sb.Append("</th>");
                //sb.Append("<th>");
                //sb.Append("Start Date");
                //sb.Append("</th>");
                //sb.Append("<th>");
                //sb.Append("End Date");
                //sb.Append("</th>");
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
                    sb.Append(item.ProgramStatusCode.Contains("REJECTED") ? "<tr class='rejected'>" : "<tr>");

                    sb.Append("<td class='size_Period'>&nbsp;</td>");

                    sb.Append("<td class='size_PType'>");
                    sb.Append(item.ProgramType);
                    sb.Append("</td>");

                    sb.Append("<td class='size_ProgramDescription'>");
                    sb.Append(item.ProgramTypeName);
                    sb.Append("</td>");

                    sb.Append("<td class='size_ATLBTL'>");
                    sb.Append(item.AboveTheLineBelowTheLineName);
                    sb.Append("</td>");

                    sb.Append("<td class='size_IsSkuBased'>");
                    sb.Append(item.IsSkuBased ? "SKU Specific" : "Brand Family");
                    sb.Append("</td>");

                    sb.Append("<td class='size_AlternateName'>");
                    sb.Append(item.AlternateName);
                    sb.Append("</td>");

                    sb.Append("<td class='size_StatusCode'>");
                    sb.Append(GetPrograStatusDDLHTML(item.ProgramId.ToString(), item.ProgramStatusCode));
                    sb.Append("</td>");

                    sb.Append("<td id='totalProgramSpend' class='size_ProgramSpend'>");
                    var totalSpend = String.Format("{0:C}", item.TotalProgramSpend);
                    var hoverTable = new StringBuilder();

                    //< a href = "javascript:void(0);" data - toggle = "tooltip" id = "aTotalProgramSpend" class="TotalProgramSpend_ToolTip" onmouseover="TotalProgramSpend_ToolTip();" onfocus="TotalProgramSpend_ToolTip();" data-original-title="<div style='z-index:99999!important;'><table class='TotalProgramSpend_Table'><tr><td class='text-left'>Quantity of spend</td><td class='text-right'></td></tr><tr><td class='text-left'>Spend per quantity</td><td class='text-right'></td></tr><tr><td class='text-left'>Other Fixed Cost/Fee</td><td class='text-right'></td></tr></table></div>" title="">
                    //<span id = "lblTotalProgramSpend" > 0 </ span >
                    //</ a >

                    var html =
                        string.Format(
                            "<a href='javascript:void(0);' data-toggle='tooltip' id='rvbbTotalProgramSpend_{0}' class='TotalProgramSpend_ToolTip' onmouseover='GetCostBreakupByProgramType(\"{2}\", rvbbTotalProgramSpend_{0});' onfocus='GetCostBreakupByProgramType(\"{2}\");' data-original-title=\"<div style='z-index:99999!important;'></div>\" title='{1}'><span id = 'lblTotalProgramSpend'>{1}</span></a>",
                            DateTime.Now.Ticks, item.TotalProgramSpend, item.ProgramId);

                    //var html =
                    //    string.Format(
                    //        "<a href='javascript:void(0);' data-toggle='tooltip' id='rvbbTotalProgramSpend' class='TotalProgramSpend_ToolTip' data-original-title=\"<div style='z-index:99999!important;'></div>\" title='{1}'><span id = 'lblTotalProgramSpend'>{1}</span></a>",
                    //        DateTime.Now.Ticks, item.TotalProgramSpend, item.ProgramType);

                    hoverTable.Append(html);

                    //hoverTable.Append(String.Format(
                    //    "<a onmouseover=\"nhpup.popup($('#hidden-table" + DateTime.Now.Ticks +
                    //    "').html());\" href='somewhere.html'>{0}</a>",
                    //    totalSpend));

                    //hoverTable.Append("<div id='hidden-table" + DateTime.Now.Ticks + "' style='display:none;'>");
                    ////hoverTable.Append("<table class='hoverTable'>");
                    //hoverTable.Append("<table class='TotalProgramSpend_ToolTip'>");

                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField'>Depth</td><td class='hoverField' class='hoverField'>{0:F}</td></tr>",
                    //    item.Depth));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField hoverAltRow'>Forecast Case Sales (base)</td><td class='hoverField hoverAltRow' class='hoverField'>{0:F}</td></tr>",
                    //    item.ForecastCaseSalesBase));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField'>Forecast Case Sales (lift)</td><td class='hoverField' class='hoverField'>{0:F}</td></tr>",
                    //    item.ForecastCaseSalesLift));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField hoverAltRow'>Forecast Total Sales (Phys)</td><td class='hoverField hoverAltRow' class='hoverField'>{0:F}</td></tr>",
                    //    item.ForecastTotalCaseSalesPhysCs));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField'>Forecast Total Sales (9L)</td><td class='hoverField'>{0:F}</td></tr>",
                    //    item.ForecastTotalCaseSales9LCsConverted));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField hoverAltRow'>Variable Cost</td><td class='hoverField hoverAltRow'>{0:F}</td></tr>",
                    //    item.VariableCostPerCase));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField'>Upfront Fees</td><td class='hoverField'>{0:F}</td></tr>",
                    //    item.UpforntFees_LTO_BAM));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField hoverAltRow'>% Redemption</td><td class='hoverField hoverAltRow'>{0:F}</td></tr>",
                    //    item.RedemptionBAM));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField'>Quantity of spend</td><td class='hoverField'>{0:F}</td></tr>",
                    //    item.SpendQuantity));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField hoverAltRow'>Spend per quantity</td><td class='hoverField hoverAltRow'>{0:F}</td></tr>",
                    //    item.SpendPerQuantity));
                    //hoverTable.Append(String.Format(
                    //    "<tr><td class='hoverField'>Other Fixed Cost/Fee</td><td class='hoverField'>{0:F}</td></tr>",
                    //    item.OtherFixedCost));

                    //hoverTable.Append("</table></div>");
                    sb.Append(hoverTable);
                    sb.Append("</td>");

                    sb.Append("<td class='size_ActualSpend'>");
                    sb.Append("0.00");
                    sb.Append("</td>");

                    if (item.IsAccess && item.ProgramStatusCode == "APPROVED - OPEN")
                        //sb.Append(
                        //    "<td class='size_Action'><a class='linkAllocateExpenses' href=\"/AllocateExpenses.aspx?ProgramId=" +
                        //    item.ProgramId + "\">Allocate</a>");
                        sb.Append("<td class='size_Action'><a class='linkAllocateExpenses' href=\"javascript:void(0); onclick=ShowAllocateexpensePopup(" + item.ProgramId + ");\">Allocate</a>");
                        //sb.Append("<td class='size_Period'><a class='linkAllocateExpenses' href=\"/AllocateExpenses.aspx?ProgramId=" + item.ProgramId + "\">Allocate</a>");
                    else
                        sb.Append("<td class='size_Action'>-");
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

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static string GetCostBreakupByProgramType(string ProgramId)
    {
        try
        {
            DataSet ds = ManageProgramBAL.GetCostBreakupByProgramType(AppStaticData.ConnectionString, ProgramId);
            DataTable dtProgramCost = ds.Tables[0];
            DataTable dtRPP = ds.Tables[1];

            //< a href = "javascript:void(0);" data - toggle = "tooltip" id = "aTotalProgramSpend" class="TotalProgramSpend_ToolTip" onmouseover="TotalProgramSpend_ToolTip();" onfocus="TotalProgramSpend_ToolTip();" data-original-title="<div style='z-index:99999!important;'><table class='TotalProgramSpend_Table'><tr><td class='text-left'>Quantity of spend</td><td class='text-right'></td></tr><tr><td class='text-left'>Spend per quantity</td><td class='text-right'></td></tr><tr><td class='text-left'>Other Fixed Cost/Fee</td><td class='text-right'></td></tr></table></div>" title="">
            //<span id = "lblTotalProgramSpend" > 0 </ span >
            //</ a >

            string html =
                "<div style='z-index:99999!important;'><table class='TotalProgramSpend_Table'><tr><td class='text-left'>Quantity of spend</td><td class='text-right'></td></tr><tr><td class='text-left'>Spend per quantity</td><td class='text-right'></td></tr><tr><td class='text-left'>Other Fixed Cost/Fee</td><td class='text-right'></td></tr></table></div>";

            return html;
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("RegionalView.cs => GetCostBreakupByProgramType ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
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
            ddlSGWSCalendar.Items.Insert(0, new ListItem("--SGWS Calendar--", "0"));
            ddlSGWSCalendar.SelectedValue = DateTime.Now.Year.ToString();

            ddlProvince.DataTextField = "Province";
            ddlProvince.DataValueField = "Id";
            ddlProvince.DataSource = ds.Tables[1];
            ddlProvince.DataBind();
            ddlProvince.Items.Insert(0, new ListItem("--Province--", "0"));

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

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static string GetSummaryRollup(string searchParameters)
    {
        DataTables result = new DataTables();
        try
        {
            string htmlStr = string.Empty;
            List<GetSummaryRollup> _list = ManageProgramBAL.GetSummaryRollup(AppStaticData.ConnectionString, 0, 0, 0, "", searchParameters, SessionFacade.LoggedInUser.UserId);
            StringBuilder sb = new StringBuilder();
            decimal ATL_Planned_Spend = 0;
            decimal BTL_Planned_Spend = 0;
            decimal ATL_Actual_Spend = 0;
            decimal BTL_Actual_Spend = 0;
            decimal Actual_Total = 0;
            decimal Planned_Total = 0;

            if (_list != null && _list.Count() > 0)
            {

                var ATL_Planned = _list.Where(t => t.ATL_BTL.Equals("ATL")
                  && t.SpendType.Equals("PlannedSpend")).ToList();

                if (ATL_Planned.Count() > 0)
                {
                    ATL_Planned_Spend = ATL_Planned.FirstOrDefault().Spend;
                }

                var BTL_Planned = _list.Where(t => t.ATL_BTL.Equals("BTL")
                && t.SpendType.Equals("PlannedSpend")).ToList();

                if (BTL_Planned.Count() > 0)
                {
                    BTL_Planned_Spend = BTL_Planned.FirstOrDefault().Spend;
                }

                var ATL_Actual = _list.Where(t => t.ATL_BTL.Equals("ATL")
                && t.SpendType.Equals("ActualSpend")).ToList();

                if (ATL_Actual.Count() > 0)
                {
                    ATL_Actual_Spend = ATL_Actual.FirstOrDefault().Spend;
                }

                var BTL_Actual = _list.Where(t => t.ATL_BTL.Equals("BTL")
                && t.SpendType.Equals("ActualSpend")).ToList();

                if (BTL_Actual.Count() > 0)
                {
                    BTL_Actual_Spend = BTL_Actual.FirstOrDefault().Spend;
                }

                Actual_Total = ATL_Actual_Spend + BTL_Actual_Spend;
                Planned_Total = ATL_Planned_Spend + BTL_Planned_Spend;
            }

            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("ATL");
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append(string.Format("{0:C}", ATL_Actual_Spend));
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append(string.Format("{0:C}", ATL_Planned_Spend));
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append("-");
            sb.Append("</td>");

            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("BTL");
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append(string.Format("{0:C}",BTL_Actual_Spend));
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append(string.Format("{0:C}", BTL_Planned_Spend));
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append("-");
            sb.Append("</td>");
            sb.Append("</tr>");

            sb.Append("<tr>");
            sb.Append("<td><b>");
            sb.Append("Total" +
                      "</b>");
            sb.Append("</td>");
            sb.Append("<td><b>");
            sb.Append(string.Format("{0:C}", Actual_Total));
            sb.Append("</b></td>");
            sb.Append("<td><b>");
            sb.Append(string.Format("{0:C}", Planned_Total));
            sb.Append("</b></td>");
            sb.Append("<td><b>");
            sb.Append("-");
            sb.Append("</b></td>");
            sb.Append("</tr>");

            htmlStr = "<table class='blueTable'><thead><tr><th width='40px'></th><th width='160px'>Actual Spend</th><th width='160px'>Planned Spend</th><th width='160px'>Threshold Spend(PTO)</th><tbody>" + sb.ToString() + "</tbody></table><p></p>";
            return htmlStr;
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("RegionalView.cs => GetSummaryRollup ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }
}

