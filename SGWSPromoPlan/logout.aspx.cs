using System;
using System.Web.UI;

public partial class adminsection_logout : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            SessionFacade.LoggedInUser = null;
            Session.Abandon();

            Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
        }
        Page.Title = PageTitles.Logout;
    }
}