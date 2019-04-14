using System;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.HtmlControls;

public partial class adminsection_MasterPage : System.Web.UI.MasterPage
{
    public int miliseconds_earlier = Convert.ToInt32(ConfigurationManager.AppSettings["SessionExpirationMessageTime"]);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            SetInitials();
        }
        else if (Request.RawUrl.ToLower().Contains("equipmentt.aspx"))
        {
            SetInitials();
        }
    }
    private void SetInitials()
    {
        if (SessionFacade.LoggedInUser != null)
        {
            HtmlGenericControl spanUserName = (HtmlGenericControl)Page.Master.FindControl("spanUserName");
            spanUserName.InnerText = SessionFacade.LoggedInUser.FirstName;

            //if (SessionFacade.LoggedInUser.Role.ToLower() == RoleIDs.Admin.ToString().ToLower())
            //{
            hlDashboard.NavigateUrl = Page.ResolveUrl(AdminUrls.Dashboard);
            hllogout.NavigateUrl = Page.ResolveUrl(AdminUrls.Logout);
            //hlChangePasword.NavigateUrl = Page.ResolveUrl(AdminUrls.ChangePassword);
            hlChangePasswordTop.NavigateUrl = Page.ResolveUrl(AdminUrls.ChangePassword);
            //hlProfile.NavigateUrl = Page.ResolveUrl(AdminUrls.Profile);
            hlProfileTop.NavigateUrl = Page.ResolveUrl(AdminUrls.Profile);

            hlManageProgram.NavigateUrl = Page.ResolveUrl(AdminUrls.Manage_Program);
            //hlUpdateProgramDetails.NavigateUrl = Page.ResolveUrl(AdminUrls.Update_Program);
            hlProgramPlanning.NavigateUrl = Page.ResolveUrl(AdminUrls.Program_Planning);
            //hlSetProgramThreshold.NavigateUrl = Page.ResolveUrl(AdminUrls.Set_Program_Threshold);


            hlAllocateExpenses1.NavigateUrl = Page.ResolveUrl(AdminUrls.Allocate_Expenses1);
            hlDeallocateExpenses.NavigateUrl = Page.ResolveUrl(AdminUrls.Deallocate_Expenses);

            hlCalendarView.NavigateUrl = Page.ResolveUrl(AdminUrls.Calendar_View);
            hlRegionalViewByBrand.NavigateUrl = Page.ResolveUrl(AdminUrls.Regional_View);
            hlActualSpend.NavigateUrl = Page.ResolveUrl(AdminUrls.Actual_Spend);

            if (SessionFacade.LoggedInUser.Role.ToLower() == RoleIDs.Admin.ToString().ToLower())
            {
                hlSKU.NavigateUrl = Page.ResolveUrl(AdminUrls.Master_SKU_List);
                hlImportVolData.NavigateUrl = Page.ResolveUrl(AdminUrls.Import_Vol_Data);
                hlImportExpenseData.NavigateUrl = Page.ResolveUrl(AdminUrls.Import_Expense_Data);
                //hlImportProgramData.NavigateUrl = Page.ResolveUrl(AdminUrls.Import_Program_Data);
                hlFiscalYearData.NavigateUrl = Page.ResolveUrl(AdminUrls.Import_FiscalYear_Data);

                hlManageUsers.NavigateUrl = Page.ResolveUrl(AdminUrls.Manage_User);
                hlManageRoles.NavigateUrl = Page.ResolveUrl(AdminUrls.Manage_Roles);

                hlImportExpenseData.NavigateUrl = Page.ResolveUrl(AdminUrls.ImportExpenseData);
            }

            //Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
            //SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");
            //int timeout = (int)section.Timeout.TotalMinutes * 1000 * 60;
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "SessionAlert", "SessionExpireAlert(" + timeout + ");", true);


            //}
        }
        else
        {
            Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
        }
    }
}
