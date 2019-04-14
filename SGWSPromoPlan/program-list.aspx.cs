using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class program_list : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                Page.Title = AdminPageTitles.ProgramList;

                //if (SessionFacade.LoggedInUser.Role == RoleIDs.Admin)
                //{
                //    HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                //    h2PageTitle.InnerText = AdminPageTitles.ProgramList;

                //    hlManageProgram.NavigateUrl = Page.ResolveUrl(AdminUrls.Manage_Program);
                //    SetBreadCrumb(AdminPageTitles.ProgramList, null, null);
                //}
                //else
                //{
                //    Response.Redirect(Page.ResolveUrl(AdminUrls.Dashboard));
                //}
                HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                h2PageTitle.InnerText = AdminPageTitles.ProgramList;
                //hlAdd.NavigateUrl = Page.ResolveUrl(AdminUrls.Program);
                hlManageProgram.NavigateUrl = Page.ResolveUrl(AdminUrls.Manage_Program);
                SetBreadCrumb(AdminPageTitles.ProgramList, null, null);
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

            List<USP_Program_GetProgramSpendData> list = ManageProgramBAL.GetProgramSpendData(AppStaticData.ConnectionString, pageSize
                , startRec, order, orderDir, search,SessionFacade.LoggedInUser.UserId);
            if (list == null)
            {
                list = new List<USP_Program_GetProgramSpendData>();
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
            SGWSPromoPlan.DAL.log.WriteLog("program_list.cs => LoadData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }

    private class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<USP_Program_GetProgramSpendData> data { get; set; }
    }
}