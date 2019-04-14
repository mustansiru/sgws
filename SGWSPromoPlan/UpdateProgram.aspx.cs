using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class UpdateProgram : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                Page.Title = AdminPageTitles.UpdateProgram;

                if (SessionFacade.LoggedInUser.Role == RoleIDs.Admin)
                {
                    HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                    h2PageTitle.InnerText = AdminPageTitles.UpdateProgram;
                    //HtmlGenericControl liUpdateProgramDetails = (HtmlGenericControl)Page.Master.FindControl("liUpdateProgramDetails");
                    //liUpdateProgramDetails.Attributes.Add("class", "active");
                    //HtmlGenericControl spanUpdateProgramDetails = (HtmlGenericControl)Page.Master.FindControl("spanUpdateProgramDetails");
                    //spanUpdateProgramDetails.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                    SetBreadCrumb(AdminPageTitles.UpdateProgram, null, null);
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