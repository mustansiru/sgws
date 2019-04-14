using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class AllocateExpenses : BasePage
{

    public long ProgramId
    {
        get
        {
            if (ViewState["ProgramId"] != null)
                return Convert.ToInt64(ViewState["ProgramId"]);
            else
                return 0;
        }
        set { ViewState["ProgramId"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                //if (SessionFacade.LoggedInUser.Role == RoleIDs.Admin)
                //{
                    HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");

                    HtmlGenericControl liManageProgram = (HtmlGenericControl)Page.Master.FindControl("liManageProgram");
                    liManageProgram.Attributes.Add("class", "active");
                    HtmlGenericControl spanManageProgram = (HtmlGenericControl)Page.Master.FindControl("spanManageProgram");
                    spanManageProgram.Attributes.Add("class", "caret-right-active fa fa-caret-right");
                    Page.Title = AdminPageTitles.AllocateExpenses;
                    h2PageTitle.InnerText = AdminPageTitles.AllocateExpenses;
                    SetBreadCrumb(AdminPageTitles.RegionalView, AdminPageTitles.AllocateExpenses, AdminUrls.Regional_View);

                    if (!string.IsNullOrWhiteSpace(Request.QueryString["ProgramId"]))
                    {
                        long programId = 0;
                        if (long.TryParse(Request.QueryString["ProgramId"], out programId))
                        {
                            ProgramId = programId;
                            LoadDetails(programId);
                        }
                    }
                //}
                //else
                //{
                //    Response.Redirect(Page.ResolveUrl(AdminUrls.Dashboard));
                //}
            }
            else
            {
                Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
            }
        }
    }

    private void LoadDetails(long programId)
    {
        DataSet ds = ManageProgramBAL.GetAllocatedExpenses(AppStaticData.ConnectionString, programId);
        if (ds != null && ds.Tables.Count > 0)
        {
            if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                lblProgName.Text = Convert.ToString(dr["ProgramTypeName"]);
                lblProvince.Text = Convert.ToString(dr["Code"]);
                lblSGWSYear.Text = Convert.ToString(dr["Year"]);
                lblSGWSPeriod.Text = Convert.ToString(dr["Period"]);
                lblLiquorPeriod.Text = Convert.ToString(dr["LiquorBoardPeriod"]);
                lblStartdate.Text = Convert.ToString(dr["StartDate"]);
                lblEnddate.Text = Convert.ToString(dr["EndDate"]);
                lblSGID.Text = Convert.ToString(dr["GID"]);
                lblProductDesc.Text = Convert.ToString(dr["AlternateName"]);
            }
            

            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
            {
                rptAllocateExpenses.DataSource = ds.Tables[1];
                rptAllocateExpenses.DataBind();
            }
            if (ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
            {
                rptNotAllocateExpenses.DataSource = ds.Tables[2];
                rptNotAllocateExpenses.DataBind();
            }
        }
    }
}