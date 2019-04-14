using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class ManageProgram : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                if (SessionFacade.RegionalProgramStatusData == null)
                {
                    DataSet ds = new DataSet();
                    ds = ManageProgramBAL.GetRegionalViewDropdowns(AppStaticData.ConnectionString);
                    if (ds != null)
                    {
                        SessionFacade.RegionalProgramStatusData = new List<ProgramStatus>();
                        for (int i = 0; i < ds.Tables[6].Rows.Count; i++)
                        {
                            SessionFacade.RegionalProgramStatusData.Add(new ProgramStatus()
                            {
                                Id = Convert.ToInt64(ds.Tables[6].Rows[i]["Id"]),
                                Code = Convert.ToString(ds.Tables[6].Rows[i]["Code"])
                            });
                        }
                    }
                }
                Page.Title = AdminPageTitles.ManageProgram;

                HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                h2PageTitle.InnerText = AdminPageTitles.ManageProgram;
                HtmlGenericControl liManageProgram = (HtmlGenericControl)Page.Master.FindControl("liManageProgram");
                liManageProgram.Attributes.Add("class", "active");
                HtmlGenericControl spanManageProgram = (HtmlGenericControl)Page.Master.FindControl("spanManageProgram");
                spanManageProgram.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                //hlAdd.NavigateUrl = Page.ResolveUrl(AdminUrls.Program);
                hlProgramList.NavigateUrl = Page.ResolveUrl(AdminUrls.Program_List);

                SetBreadCrumb(AdminPageTitles.ManageProgram, null, null);
            }
            else
            {
                Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
            }
        }
    }

    private void BindDropdown()
    {
        //DataSet ds = new DataSet();
        //ds = ManageProgramBAL.GetProgramDropdowns(AppStaticData.ConnectionString);
        //if (ds != null)
        //{
        //    ddlBusinessType.DataTextField = "BusinessType";
        //    ddlBusinessType.DataValueField = "Id";
        //    ddlBusinessType.DataSource = ds.Tables[0];
        //    ddlBusinessType.DataBind();
        //    ddlBusinessType.Items.Insert(0, new ListItem("--Select--", "0"));
        //    ddlBusinessType.SelectedValue = "2";//Liquor

        //    ddlProvince.DataTextField = "Province";
        //    ddlProvince.DataValueField = "Id";
        //    ddlProvince.DataSource = ds.Tables[1];
        //    ddlProvince.DataBind();
        //    ddlProvince.Items.Insert(0, new ListItem("--Select--", "0"));

        //    ddlSGWSCalendarYear.DataTextField = "Year";
        //    ddlSGWSCalendarYear.DataValueField = "Year";
        //    ddlSGWSCalendarYear.DataSource = ds.Tables[2];
        //    ddlSGWSCalendarYear.DataBind();
        //    ddlSGWSCalendarYear.Items.Insert(0, new ListItem("--Select--", "0"));

        //    ddlSGWSCalendarPeriod.DataTextField = "Period";
        //    ddlSGWSCalendarPeriod.DataValueField = "Period";
        //    ddlSGWSCalendarPeriod.DataSource = ds.Tables[3];
        //    ddlSGWSCalendarPeriod.DataBind();
        //    ddlSGWSCalendarPeriod.Items.Insert(0, new ListItem("--Select--", "0"));

        //    ddlSKUSpecificOrBrandFamily.DataTextField = "Name";
        //    ddlSKUSpecificOrBrandFamily.DataValueField = "Id";
        //    ddlSKUSpecificOrBrandFamily.DataSource = ds.Tables[4];
        //    ddlSKUSpecificOrBrandFamily.DataBind();
        //    ddlSKUSpecificOrBrandFamily.Items.Insert(0, new ListItem("--Select--", "0"));

        //    ddlProgramType.DataTextField = "ProgramType";
        //    ddlProgramType.DataValueField = "Id";
        //    ddlProgramType.DataSource = ds.Tables[5];
        //    ddlProgramType.DataBind();
        //    ddlProgramType.Items.Insert(0, new ListItem("--Select--", "0"));

        //    ddlAboveTheLineOrBelowTheLine.DataTextField = "Name";
        //    ddlAboveTheLineOrBelowTheLine.DataValueField = "Id";
        //    ddlAboveTheLineOrBelowTheLine.DataSource = ds.Tables[6];
        //    ddlAboveTheLineOrBelowTheLine.DataBind();
        //    ddlAboveTheLineOrBelowTheLine.Items.Insert(0, new ListItem("--Select--", "0"));

        //    ddlProgramStatus.DataTextField = "Code";
        //    ddlProgramStatus.DataValueField = "Id";
        //    ddlProgramStatus.DataSource = ds.Tables[7];
        //    ddlProgramStatus.DataBind();
        //    ddlProgramStatus.Items.Insert(0, new ListItem("--Select--", "0"));

        //    ddlBrand.DataTextField = "BrandName";
        //    ddlBrand.DataValueField = "Id";
        //    ddlBrand.DataSource = ds.Tables[8];
        //    ddlBrand.DataBind();
        //    ddlBrand.Items.Insert(0, new ListItem("--Select--", "0"));

        //    //ddlSGID.DataTextField = "GID";
        //    //ddlSGID.DataValueField = "GID";
        //    //ddlSGID.DataSource = ds.Tables[9];
        //    //ddlSGID.DataBind();
        //    //ddlSGID.Items.Insert(0, new ListItem("--Select--", "0"));

        //    ddlSupplierName.DataTextField = "SupplierName";
        //    ddlSupplierName.DataValueField = "Id";
        //    ddlSupplierName.DataSource = ds.Tables[10];
        //    ddlSupplierName.DataBind();
        //    ddlSupplierName.Items.Insert(0, new ListItem("--Select--", "0"));
        //}
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

            List<USP_Program_GetData> list = ManageProgramBAL.GetData(AppStaticData.ConnectionString, pageSize
                , startRec, order, orderDir, search, SessionFacade.LoggedInUser.UserId);
            if (list == null)
            {
                list = new List<USP_Program_GetData>();
            }
            else
            {
                if (list.Count > 0)
                    totalRecords = list[0].TotalRecords;
            }

            result.draw = Convert.ToInt32(draw);
            result.recordsTotal = totalRecords;
            result.recordsFiltered = totalRecords;
            result.data = list;

            return result;
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("ManageProgram.cs => GetProgramData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static string LoadDetailData(long superProgramId)
    {
        try
        {
            string jsonString = string.Empty;
            List<USP_Program_GetData_Detail> list = ManageProgramBAL.GetProgramDetail(AppStaticData.ConnectionString, superProgramId, SessionFacade.LoggedInUser.UserId);
            if (list != null)
            {
                StringBuilder sb = new StringBuilder();

                foreach (var item in list)
                {
                    sb.Append("<tr>");
                    sb.Append("<td class='text-center'>");
                    if (item.IsAccess)
                        sb.Append("<a href =\"javascript:void(0);\" title=\"Edit Program\" onclick = 'return GetProgramDetailsByProgramId(" + item.ProgramId.ToString() + ")'>" + "<i class=\"fa fa-pencil\"></i></a>");
                    else
                        sb.Append("");
                    // | <a href=\"javascript:void(0);\" onclick=\"return CopyProgram(" + item.ProgramId + ")\"><i class=\"fa fa-files-o\"></i></a>
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(item.ProgramTypeName);
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(item.ProgramType);
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(item.AboveTheLineBelowTheLineName);
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(item.Comment);
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(GetPrograStatusDDLHTML(item.ProgramId.ToString(), item.ProgramStatusCode));
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }
                string Cols = string.Empty;
                Cols = "<colgroup>";
                Cols = Cols + "<col span=\"1\" style=\"width: 5%; \">";
                Cols = Cols + "<col span=\"1\" style=\"width: 20%; \">";
                Cols = Cols + "<col span=\"1\" style=\"width: 15%; \">";
                Cols = Cols + "<col span=\"1\" style=\"width: 15%; \">";
                Cols = Cols + "<col span=\"1\" style=\"width: 15%; \">";
                Cols = Cols + "<col span=\"1\" style=\"width: 15%; \">";
                Cols = Cols + "</colgroup>";

                Cols = Cols + "<tbody id='SP" + superProgramId.ToString() + "'>" + sb.ToString() + "</tbody>";
                //jsonString = "<div><input type=\"button\" id=\"btnAdd\" value=\"Add\" data-toggle=\"modal\" class=\"btn btn-primary\" onclick=\"ShowPopUp('" + superProgramId.ToString() + "');\" /></div>";
                jsonString = jsonString + "<div style=\"height: auto; width:70%;\">";
                jsonString = jsonString + "<table class='blueTable'><thead><tr><th>Action</th><th>Program Type Name</th><th>Program Type</th><th>ATL/BTL</th><th>Comments</th><th>Status</th>" + Cols + "</table>";
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
            SGWSPromoPlan.DAL.log.WriteLog("ManageProgram.cs => GetProgramData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
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
            SGWSPromoPlan.DAL.log.WriteLog("ManageProgram.cs => UpdateProgramStatus ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
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
        public List<USP_Program_GetData> data { get; set; }
    }
}