using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class adminsection_login : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //aForgotPassword.HRef = Page.ResolveUrl(AdminUrls.ForgotPassword);

            if (SessionFacade.LoggedInUser != null)
                Response.Redirect(Page.ResolveUrl(AdminUrls.Home));

            Page.Title = AdminPageTitles.Login;

        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (Membership.ValidateUser(txtUserName.Text.Trim(), txtPassword.Text.Trim()))
        {
            AppStaticData.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Con"].ToString();            
            DataSet dtUser = ManageUserBAL.ValidateUser(AppStaticData.ConnectionString, txtUserName.Text.Trim(), txtPassword.Text.Trim());
            if (dtUser != null)
            {
                if (dtUser.Tables[0] != null && dtUser.Tables[0].Rows.Count > 0)
                {
                    UserMaster objUserMaster = new UserMaster();
                    objUserMaster.UserId = (Guid)(dtUser.Tables[0].Rows[0]["UserID"]);
                    objUserMaster.Email = Convert.ToString(dtUser.Tables[0].Rows[0]["Email"]);
                    objUserMaster.Role = Convert.ToString(dtUser.Tables[0].Rows[0]["RoleName"]);
                    objUserMaster.FirstName = Convert.ToString(dtUser.Tables[0].Rows[0]["FirstName"]);
                    objUserMaster.LastName = Convert.ToString(dtUser.Tables[0].Rows[0]["LastName"]);
                    objUserMaster.RoleId = (Guid)(dtUser.Tables[0].Rows[0]["RoleId"]);

                    SessionFacade.LoggedInUser = objUserMaster;
                    if (dtUser.Tables[1] != null && dtUser.Tables[1].Rows.Count > 0)
                        SessionFacade.LoggedInUser_Province = Convert.ToString(dtUser.Tables[1].Rows[0]["ProvinceIds"]);

                    Response.Redirect(Page.ResolveUrl(AdminUrls.Home));
                }
                else
                {
                    divMessage.InnerHtml = "Invalid User";
                }
            }
        }
        else
        {
            divMessage.InnerHtml = "Invalid User";
        }
        
    }
}