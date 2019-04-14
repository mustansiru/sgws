using SGWSPromoPlan.BAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class adminsection_manage_user : BasePage
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
                    h2PageTitle.InnerText = AdminPageTitles.ManageUsers;

                    hlAdd.NavigateUrl = Page.ResolveUrl(AdminUrls.Add_User);
                    HtmlGenericControl liManageUsers = (HtmlGenericControl)Page.Master.FindControl("liManageUsers");
                    liManageUsers.Attributes.Add("class", "active");
                    HtmlGenericControl spanManageUsers = (HtmlGenericControl)Page.Master.FindControl("spanManageUsers");
                    spanManageUsers.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                    SetBreadCrumb(AdminPageTitles.ManageUsers, null, null);
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
        Page.Title = AdminPageTitles.ManageUsers;
    }

    [System.Web.Services.WebMethod]
    public static bool DeleteRecord(string UserId)
    {
        return ManageUserBAL.DeleteRecord(AppStaticData.ConnectionString, UserId);
    }
}