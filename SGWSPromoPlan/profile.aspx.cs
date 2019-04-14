using SGWSPromoPlan.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class adminsection_profile : BasePage
{
    private bool IsApproved
    {
        get
        {
            if (ViewState["IsApproved"] != null)
                return Convert.ToBoolean(ViewState["IsApproved"]);
            else
                return false;
        }
        set { ViewState["IsApproved"] = value; }
    }
    private string SupplierId
    {
        get
        {
            if (ViewState["SupplierId"] != null)
                return Convert.ToString(ViewState["SupplierId"]);
            else
                return "";
        }
        set { ViewState["SupplierId"] = value; }
    }
    private string ProvinceId
    {
        get
        {
            if (ViewState["ProvinceId"] != null)
                return Convert.ToString(ViewState["ProvinceId"]);
            else
                return "";
        }
        set { ViewState["ProvinceId"] = value; }
    }
    private string BusinessType
    {
        get
        {
            if (ViewState["BusinessType"] != null)
                return Convert.ToString(ViewState["BusinessType"]);
            else
                return "";
        }
        set { ViewState["BusinessType"] = value; }
    }
    private string Brand
    {
        get
        {
            if (ViewState["Brand"] != null)
                return Convert.ToString(ViewState["Brand"]);
            else
                return "";
        }
        set { ViewState["Brand"] = value; }
    }
    protected void Page_PreInit(object sender, EventArgs e)
    {
        //if (Convert.ToString(RoleId).ToUpper() == Convert.ToString(RoleIDs.Admin))
        //    this.MasterPageFile = "MasterInspector.master";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                //HtmlGenericControl liProfile = (HtmlGenericControl)Page.Master.FindControl("liProfile");
                //liProfile.Attributes.Add("class", "active");
                //HtmlGenericControl spanProfile = (HtmlGenericControl)Page.Master.FindControl("spanProfile");
                //spanProfile.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                h2PageTitle.InnerText = AdminPageTitles.EditProfile;

                LoadUser();

                SetBreadCrumb(AdminPageTitles.EditProfile, null, null);
            }
            else
            {
                Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
            }
        }
        Page.Title = AdminPageTitles.EditProfile;
    }

    private void LoadUser()
    {
        DataTable dtUser = ManageUserBAL.GetUser(AppStaticData.ConnectionString, SessionFacade.LoggedInUser.UserId.ToString());

        if (dtUser != null)
        {
            txtFirstName.Text = Convert.ToString(dtUser.Rows[0]["FirstName"]);
            txtLastName.Text = Convert.ToString(dtUser.Rows[0]["LastName"]);
            lblEmailID.Text = Convert.ToString(dtUser.Rows[0]["Email"]);
            txtPhoneNo.Text = Convert.ToString(dtUser.Rows[0]["PhoneNo"]);
            IsApproved = Convert.ToBoolean(dtUser.Rows[0]["IsApproved"]);

            if (dtUser.Rows[0]["ProvinceId"] != DBNull.Value)
                this.ProvinceId = Convert.ToString(dtUser.Rows[0]["ProvinceId"]);

            if (dtUser.Rows[0]["SupplierId"] != DBNull.Value)
                this.SupplierId = Convert.ToString(dtUser.Rows[0]["SupplierId"]);

            if (dtUser.Rows[0]["BusinessType"] != DBNull.Value)
                this.BusinessType = Convert.ToString(dtUser.Rows[0]["BusinessType"]);

            if (dtUser.Rows[0]["Brand"] != DBNull.Value)
                this.Brand = Convert.ToString(dtUser.Rows[0]["Brand"]);
        }
        dtUser = null;
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            int result = ManageUserBAL.AddEditUser(AppStaticData.ConnectionString, SessionFacade.LoggedInUser.UserId.ToString(), txtFirstName.Text.Trim(), txtLastName.Text.Trim(),
                txtPhoneNo.Text.Trim(), SessionFacade.LoggedInUser.RoleId.ToString(), IsApproved, 2
                , SessionFacade.LoggedInUser.UserId.ToString(),this.ProvinceId, this.SupplierId, this.BusinessType,this.Brand);

            if (result > 0)
                divMessage.InnerHtml = string.Format(Messages.SuccessMessage, "Profile updated successfully");
            else
                divMessage.InnerHtml = string.Format(Messages.ErrorMessage, "Profile failed to update");
        }
    }
}