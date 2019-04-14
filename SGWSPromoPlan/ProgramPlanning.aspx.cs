using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class ProgramPlanning : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                Page.Title = AdminPageTitles.ProgramPlanning;

                if (SessionFacade.LoggedInUser.Role == RoleIDs.Admin)
                {
                    HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                    h2PageTitle.InnerText = AdminPageTitles.ProgramPlanning;
                    HtmlGenericControl liProgramPlanning = (HtmlGenericControl)Page.Master.FindControl("liProgramPlanning");
                    liProgramPlanning.Attributes.Add("class", "active");
                    HtmlGenericControl spanProgramPlanning = (HtmlGenericControl)Page.Master.FindControl("spanProgramPlanning");
                    spanProgramPlanning.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                    SetBreadCrumb(AdminPageTitles.ProgramPlanning, null, null);
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
}