using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class adminsection_change_password : BasePage
{

    protected void Page_PreInit(object sender, EventArgs e)
    {
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                h2PageTitle.InnerText = AdminPageTitles.ChangePassword;

                //HtmlGenericControl liChangePasword = (HtmlGenericControl)Page.Master.FindControl("liChangePasword");
                //liChangePasword.Attributes.Add("class", "active");
                //HtmlGenericControl spanChangePasword = (HtmlGenericControl)Page.Master.FindControl("spanChangePasword");
                //spanChangePasword.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                SetBreadCrumb(AdminPageTitles.ChangePassword, null, null);
            }
            else
            {
                Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
            }
        }
        Page.Title = AdminPageTitles.ChangePassword;
    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        bool flag = false;
        MembershipUser objUser = Membership.GetUser(SessionFacade.LoggedInUser.Email);

        try
        {
            flag = objUser.ChangePassword(txtOldPassword.Text, txtNewPassword.Text);
        }
        catch (Exception ex)
        {
            flag = false;
        }
        if (flag)
        {
            divMessage.InnerHtml = string.Format(Messages.SuccessMessage, "Password changed successfully");
        }
        else
        {
            divMessage.InnerHtml = string.Format(Messages.ErrorMessage, "Incorrect old password");
        }
    }
}