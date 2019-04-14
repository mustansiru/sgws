using SGWSPromoPlan.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class adminsection_user : BasePage
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

                    GetDropdowns();

                    if (Request.QueryString["id"] != null)
                    {
                        h2PageTitle.InnerText = AdminPageTitles.EditUser;
                        Page.Title = AdminPageTitles.EditUser;

                        btnAdd.Text = "Update";
                        divEditPassword.Visible = true;
                        divAddPassword.Visible = false;

                        LoadUser(Request.QueryString["id"]);
                    }
                    else
                    {
                        h2PageTitle.InnerText = AdminPageTitles.AddUser;
                        Page.Title = AdminPageTitles.AddUser;
                        //UserID = string.Empty;

                        chkIsActive.Checked = true;

                        btnAdd.Text = "Add";
                        divEditPassword.Visible = false;
                        divAddPassword.Visible = true;
                    }

                    SetBreadCrumb(AdminPageTitles.ManageUsers, h2PageTitle.InnerText, AdminUrls.Manage_User);
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

    private void LoadUser(string id)
    {
        DataTable dtUser = ManageUserBAL.GetUser(AppStaticData.ConnectionString, id);
        if (dtUser != null)
        {
            hdUserID.Value = Convert.ToString(dtUser.Rows[0]["UserId"]);
            txtFirstName.Text = Convert.ToString(dtUser.Rows[0]["FirstName"]);
            txtLastName.Text = Convert.ToString(dtUser.Rows[0]["LastName"]);
            txtEmailID.Text = Convert.ToString(dtUser.Rows[0]["Email"]);
            if (dtUser.Rows[0]["RoleID"] != DBNull.Value)
                ddlRole.SelectedValue = Convert.ToString(dtUser.Rows[0]["RoleID"]);

            if (dtUser.Rows[0]["ProvinceId"] != DBNull.Value)
                hdnProvince.Value = Convert.ToString(dtUser.Rows[0]["ProvinceId"]);

            if (dtUser.Rows[0]["SupplierId"] != DBNull.Value)
                hdnSuppliers.Value = Convert.ToString(dtUser.Rows[0]["SupplierId"]);
            if (dtUser.Rows[0]["BusinessType"] != DBNull.Value)
                hdnBusinessType.Value = Convert.ToString(dtUser.Rows[0]["BusinessType"]);

            //if (dtUser.Rows[0]["Brand"] != DBNull.Value)
            //    hdnBrand.Value = Convert.ToString(dtUser.Rows[0]["Brand"]);

            
            chkIsActive.Checked = Convert.ToBoolean(dtUser.Rows[0]["IsApproved"]);
            txtPhoneNo.Text = Convert.ToString(dtUser.Rows[0]["PhoneNo"]);
            txtEmailID.Enabled = false;
            
            if (SessionFacade.LoggedInUser.Role != RoleIDs.Admin)
                ddlRole.Enabled = false;
        }


    }

    private void GetDropdowns()
    {
        DataSet ds = ManageProgramBAL.GetUsersDropdowns(AppStaticData.ConnectionString);

        if (ds != null && ds.Tables.Count > 0)
        {
            ddlRole.DataTextField = "RoleName";
            ddlRole.DataValueField = "RoleID";

            ddlRole.DataSource = ds.Tables[0]; //ManageUserBAL.GetRoles(AppStaticData.ConnectionString, SessionFacade.LoggedInUser.UserId.ToString());
            ddlRole.DataBind();

            ddlRole.Items.Insert(0, new ListItem("--Select Role--", "0"));

            ddlSuppliers.DataTextField = "SupplierName";
            ddlSuppliers.DataValueField = "Id";

            ddlSuppliers.DataSource = ds.Tables[1];// SupplierBAL.GetSuppliers(AppStaticData.ConnectionString);
            ddlSuppliers.DataBind();

            //ddlSuppliers.Items.Insert(0, new ListItem("--Select Supplier--", "0"));

            ddlProvince.DataTextField = "Province";
            ddlProvince.DataValueField = "Id";

            ddlProvince.DataSource = ds.Tables[2];
            ddlProvince.DataBind();

            ddlBusinessType.DataTextField = "BusinessType";
            ddlBusinessType.DataValueField = "Id";

            ddlBusinessType.DataSource = ds.Tables[3];
            ddlBusinessType.DataBind();

            //ddlBrand.DataTextField = "BrandName";
            //ddlBrand.DataValueField = "Id";
            //ddlBrand.DataSource = ds.Tables[4];
            //ddlBrand.DataBind();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {

        if (ddlRole.SelectedItem.Text != RoleIDs.Admin && string.IsNullOrEmpty(hdnSuppliers.Value) && string.IsNullOrEmpty(hdnProvince.Value))
        {
            divMessage.InnerHtml = string.Format(Messages.ErrorMessage, "Please select either Supplier or Province");
            return;
        }

        int result = 0;

        if (string.IsNullOrEmpty(hdUserID.Value))
        {
            if (ManageUserBAL.CheckEmailIDExistUser(AppStaticData.ConnectionString, txtEmailID.Text.Trim(), hdUserID.Value) == false)
            {
                MembershipCreateStatus membershipStatus = MembershipCreateStatus.UserRejected;
                Guid usedId = Guid.NewGuid();

                Membership.CreateUser(txtEmailID.Text.Trim(), txtPassword.Text.Trim(), txtEmailID.Text.Trim(), null, null,
                    chkIsActive.Checked, usedId, out membershipStatus);


                if (MembershipCreateStatus.Success == membershipStatus)
                {
                    result = ManageUserBAL.AddEditUser(AppStaticData.ConnectionString, usedId.ToString(),
                        txtFirstName.Text.Trim(), txtLastName.Text.Trim(),
                  txtPhoneNo.Text.Trim(), ddlRole.SelectedValue, chkIsActive.Checked, 1
                  , SessionFacade.LoggedInUser.UserId.ToString()
                  , hdnProvince.Value, hdnSuppliers.Value, hdnBusinessType.Value, "");

                }

                if (result > 0)
                {
                    SessionFacade.LoggedInUser_Province = hdnProvince.Value;
                    Response.Redirect(Page.ResolveUrl(string.Format(AdminUrls.Manage_User_RecordAdded_OR_Edited, "i", "yes")));
                }
                else
                {
                    divMessage.InnerHtml = string.Format(Messages.ErrorMessage, "User failed to add");
                }
            }
            else
            {
                divMessage.InnerHtml = string.Format(Messages.ErrorMessage, "Email Address already exist");
            }
        }
        else
        {

            result = ManageUserBAL.AddEditUser(AppStaticData.ConnectionString, hdUserID.Value,
                        txtFirstName.Text.Trim(), txtLastName.Text.Trim(),
                  txtPhoneNo.Text.Trim(), ddlRole.SelectedValue, chkIsActive.Checked, 2
                  , SessionFacade.LoggedInUser.UserId.ToString()
                  , hdnProvince.Value, hdnSuppliers.Value, hdnBusinessType.Value, "");

            if (result > 0)
            {
                SessionFacade.LoggedInUser_Province = hdnProvince.Value;
                Response.Redirect(Page.ResolveUrl(string.Format(AdminUrls.Manage_User_RecordAdded_OR_Edited, "u", "yes")));
            }
            else
            {
                divMessage.InnerHtml = string.Format(Messages.ErrorMessage, "User failed to update");
            }
        }



    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtEmailID.Text.Trim()))
        {
            MembershipUser mu = Membership.GetUser(txtEmailID.Text.Trim());
            if (mu != null)
            {
                string ResetedPassword = mu.ResetPassword();
                mu.ChangePassword(ResetedPassword, txtPopupPassword.Text.Trim());
                mpEditPassword.Hide();
                divMessage.InnerHtml = string.Format(Messages.SuccessMessage, "Password Changed Successfully");
            }
        }
    }
}