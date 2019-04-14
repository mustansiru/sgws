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

public partial class program :BasePage
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
    public long SuperProgramId
    {
        get
        {
            if (ViewState["SuperProgramId"] != null)
                return Convert.ToInt64(ViewState["SuperProgramId"]);
            else
                return 0;
        }
        set { ViewState["SuperProgramId"] = value; }
    }
    private long ProgramCostId
    {
        get
        {
            if (ViewState["ProgramCostId"] != null)
                return Convert.ToInt64(ViewState["ProgramCostId"]);
            else
                return 0;
        }
        set { ViewState["ProgramCostId"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                BindDropdown();
                SetReadOnlyControls();
                if (SessionFacade.LoggedInUser.Role == RoleIDs.Admin)
                {
                    HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                    
                    HtmlGenericControl liManageProgram = (HtmlGenericControl)Page.Master.FindControl("liManageProgram");
                    liManageProgram.Attributes.Add("class", "active");
                    HtmlGenericControl spanManageProgram = (HtmlGenericControl)Page.Master.FindControl("spanManageProgram");
                    spanManageProgram.Attributes.Add("class", "caret-right-active fa fa-caret-right");
                    
                    if (!string.IsNullOrWhiteSpace(Request.QueryString["SuperProgramId"]))
                    {
                        SuperProgramId = Convert.ToInt64(Request.QueryString["SuperProgramId"]);
                        Page.Title = AdminPageTitles.UpdateProgram;
                        h2PageTitle.InnerText = AdminPageTitles.UpdateProgram;
                        SetBreadCrumb(AdminPageTitles.ManageProgram, AdminPageTitles.UpdateProgram, AdminUrls.Manage_Program);
                        LoadDetails();
                        SetProgramStatus(string.Empty, true);
                    }
                    else
                    {
                        Page.Title = AdminPageTitles.AddProgram;
                        h2PageTitle.InnerText = AdminPageTitles.AddProgram;
                        SetBreadCrumb(AdminPageTitles.ManageProgram, AdminPageTitles.AddProgram, AdminUrls.Manage_Program);
                        SetProgramStatus("3", false);
                    }
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
    private void SetReadOnlyControls()
    {
        //txtStartDate.Attributes.Add("readonly", "readonly");
        //txtEndDate.Attributes.Add("readonly", "readonly");
        txtGID.Attributes.Add("readonly", "readonly");
        txtLiquorBoardPeriod.Attributes.Add("readonly", "readonly");
        txtForecastTotalCaseSalesPhysCs.Attributes.Add("readonly", "readonly");
        txtForecastTotalCaseSales9LCsConverted.Attributes.Add("readonly", "readonly");
        txtVariableCostPerCase.Attributes.Add("readonly", "readonly");
    }
    private void SetProgramStatus(string value,bool isenabled)
    {
        if(!string.IsNullOrWhiteSpace(value))
            ddlProgramStatus.SelectedValue = value;
        ddlProgramStatus.Enabled = isenabled;
    }
    private void LoadDetails()
    {
        DataSet ds = ManageProgramBAL.GetProgramDetailsBySuperProgramId(AppStaticData.ConnectionString, SuperProgramId);
        if(ds != null && ds.Tables.Count>0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                //ProgramId = Convert.ToInt64(dr["ProgramId"]);
                ddlBusinessType.SelectedValue = Convert.ToString(dr["BusinessTypeId"]);
                ddlProvince.SelectedValue = Convert.ToString(dr["ProvinceId"]);
                ddlSGWSCalendarYear.SelectedValue = Convert.ToString(dr["SGWSYear"]);
                ddlSGWSCalendarPeriod.SelectedValue = Convert.ToString(dr["SGWSPeriod"]);
                ddlSKUSpecificOrBrandFamily.SelectedValue = Convert.ToBoolean(dr["IsSkuBased"]) == true ? Convert.ToString((int)Common.ProgramSKU_BrandBased.SKUSpecific) :
                                                            Convert.ToBoolean(dr["IsBrandBased"]) == true ? Convert.ToString((int)Common.ProgramSKU_BrandBased.BrandFamily) : "0";

                chkOverRideDate.Checked = Convert.ToBoolean(dr["IsOverrideDate"]) == true ? true : false;

                //ddlProgramType.SelectedValue = Convert.ToString(dr["ProgramTypeId"]);
                //ddlAboveTheLineOrBelowTheLine.SelectedValue = Convert.ToString(dr["AboveTheLineBelowTheLine"]);
                //ddlProgramStatus.SelectedValue = Convert.ToString(dr["ProgramStatusId"]);

                txtSuperProgramName.Text = Convert.ToString(dr["SuperProgramName"]);
                txtStartDate.Text = Convert.ToString(dr["StartDate"]);
                txtEndDate.Text = Convert.ToString(dr["EndDate"]);
                txtGID.Text = Convert.ToString(dr["GID"]);
                //txtProgramName.Text = Convert.ToString(dr["ProgramTypeName"]);
                //txtComment.Text = Convert.ToString(dr["Comment"]);

                //txtDepthLTOorBAM.Text = Convert.ToString(dr["Depth"]);
                //txtForecastCaseSalesBase.Text = Convert.ToString(dr["ForecastCaseSalesBase"]);
                //txtForecastCaseSalesLift.Text = Convert.ToString(dr["ForecastCaseSalesLift"]);
                //txtForecastTotalCaseSalesPhysCs.Text = Convert.ToString(dr["ForecastTotalCaseSalesPhysCs"]);
                //txtForecastTotalCaseSales9LCsConverted.Text = Convert.ToString(dr["ForecastTotalCaseSales9LCsConverted"]);
                //txtVariableCostPerCase.Text = Convert.ToString(dr["VariableCostPerCase"]);
                //txtUpFrontFeesforLTOorBAM.Text = Convert.ToString(dr["UpforntFees_LTO_BAM"]);
                //txtPercentRedemptionRateforBAMonly.Text = Convert.ToString(dr["RedemptionBAM"]);
                //txtQuantityofSpend.Text = Convert.ToString(dr["SpendQuantity"]);
                //txtSpendperQuantity.Text = Convert.ToString(dr["SpendPerQuantity"]);
                //txtOtherFixedCostorFee.Text = Convert.ToString(dr["OtherFixedCost"]);
                //lblTotalProgramSpend.Text = Convert.ToString(dr["TotalProgramSpend"]);

                hdn_ddlLiquorBoardPeriod.Value = Convert.ToString(dr["FiscalYearByLiquorBoardId"]);

                FillGIDDetails(Convert.ToString(dr["GID"]), Convert.ToInt64(dr["ProvinceId"]));
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                rptPrograms.DataSource = ds.Tables[1];
                rptPrograms.DataBind();
            }
            RegisterScripts("GetLiquorBoardPeriod(0,2);");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "$(function(){});", true);
        }
    }
    private void FillGIDDetails(string gid,long provinceId)
    {
        DataTable dt = ManageProgramBAL.GetProductDetailsBy_GID_Province(AppStaticData.ConnectionString, gid, provinceId);
        if (dt != null && dt.Rows.Count > 0)
        {
            txtGID.Text = Convert.ToString(dt.Rows[0]["GID"]);
            lblCategory.Text = Convert.ToString(dt.Rows[0]["Category"]);
            lblSupplier.Text = Convert.ToString(dt.Rows[0]["SupplierName"]);
            lblBrand.Text = Convert.ToString(dt.Rows[0]["BrandName"]);
            lblCSPC.Text = Convert.ToString(dt.Rows[0]["CSPC_Code"]);
            lblProductDescription.Text = Convert.ToString(dt.Rows[0]["ProductDescription"]);
            lblSize.Text = Convert.ToString(dt.Rows[0]["Size"]);
            lblUnitsPerPk.Text = Convert.ToString(dt.Rows[0]["UnitsPerPk"]);
            lblUnits.Text = Convert.ToString(dt.Rows[0]["Units"]);
        }
    }
    private void BindDropdown()
    {
        DataSet ds = new DataSet();
        ds = ManageProgramBAL.GetProgramDropdowns(AppStaticData.ConnectionString);
        if (ds != null)
        {
            ddlBusinessType.DataTextField = "BusinessType";
            ddlBusinessType.DataValueField = "Id";
            ddlBusinessType.DataSource = ds.Tables[0];
            ddlBusinessType.DataBind();
            ddlBusinessType.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlBusinessType.SelectedValue = "2";//Liquor

            ddlProvince.DataTextField = "Province";
            ddlProvince.DataValueField = "Id";
            ddlProvince.DataSource = ds.Tables[1];
            ddlProvince.DataBind();
            ddlProvince.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlSGWSCalendarYear.DataTextField = "Year";
            ddlSGWSCalendarYear.DataValueField = "Year";
            ddlSGWSCalendarYear.DataSource = ds.Tables[2];
            ddlSGWSCalendarYear.DataBind();
            ddlSGWSCalendarYear.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlSGWSCalendarPeriod.DataTextField = "Period";
            ddlSGWSCalendarPeriod.DataValueField = "Period";
            ddlSGWSCalendarPeriod.DataSource = ds.Tables[3];
            ddlSGWSCalendarPeriod.DataBind();
            ddlSGWSCalendarPeriod.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlSKUSpecificOrBrandFamily.DataTextField = "Name";
            ddlSKUSpecificOrBrandFamily.DataValueField = "Id";
            ddlSKUSpecificOrBrandFamily.DataSource = ds.Tables[4];
            ddlSKUSpecificOrBrandFamily.DataBind();
            ddlSKUSpecificOrBrandFamily.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlProgramType.DataTextField = "ProgramType";
            ddlProgramType.DataValueField = "Id";
            ddlProgramType.DataSource = ds.Tables[5];
            ddlProgramType.DataBind();
            ddlProgramType.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlAboveTheLineOrBelowTheLine.DataTextField = "Name";
            ddlAboveTheLineOrBelowTheLine.DataValueField = "Id";
            ddlAboveTheLineOrBelowTheLine.DataSource = ds.Tables[6];
            ddlAboveTheLineOrBelowTheLine.DataBind();
            ddlAboveTheLineOrBelowTheLine.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlProgramStatus.DataTextField = "Code";
            ddlProgramStatus.DataValueField = "Id";
            ddlProgramStatus.DataSource = ds.Tables[7];
            ddlProgramStatus.DataBind();
            ddlProgramStatus.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlBrand.DataTextField = "BrandName";
            ddlBrand.DataValueField = "Id";
            ddlBrand.DataSource = ds.Tables[8];
            ddlBrand.DataBind();
            ddlBrand.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlSGID.DataTextField = "GID";
            ddlSGID.DataValueField = "GID";
            ddlSGID.DataSource = ds.Tables[9];
            ddlSGID.DataBind();
            ddlSGID.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlSupplierName.DataTextField = "SupplierName";
            ddlSupplierName.DataValueField = "Id";
            ddlSupplierName.DataSource = ds.Tables[10];
            ddlSupplierName.DataBind();
            ddlSupplierName.Items.Insert(0, new ListItem("--Select--", "0"));
        }
    }

    //protected void btnSave_Click(object sender, EventArgs e)
    //{
    //    if (SessionFacade.LoggedInUser != null)
    //    {
    //        if (Page.IsValid)
    //        {
    //            DataSet dsResult = new DataSet();
    //            if (!string.IsNullOrWhiteSpace(Request.QueryString["SuperProgramId"]))
    //            {
    //                SuperProgramId = Convert.ToInt64(Request.QueryString["SuperProgramId"]);
    //            }
    //            bool isSKUBased = false;
    //            bool isBrandBased = false;
    //            if (ddlSKUSpecificOrBrandFamily.SelectedValue == "1")
    //                isSKUBased = true;
    //            else
    //                isBrandBased = true;

    //            DateTime StartDate = DateTime.ParseExact(txtStartDate.Text.Trim(), "MM/dd/yyyy", CultureInfo.InvariantCulture);
    //            DateTime EndDate = DateTime.ParseExact(txtEndDate.Text.Trim(), "MM/dd/yyyy", CultureInfo.InvariantCulture);

    //            dsResult = ManageProgramBAL.AddEditSuperProgram(AppStaticData.ConnectionString, SuperProgramId,
    //                Convert.ToInt64(ddlProvince.SelectedValue), Convert.ToInt32(ddlBusinessType.SelectedValue), txtSuperProgramName.Text.Trim(),
    //                Convert.ToInt32(ddlSGWSCalendarYear.SelectedValue), ddlSGWSCalendarPeriod.SelectedValue, StartDate, EndDate,
    //                !string.IsNullOrWhiteSpace(hdn_ddlLiquorBoardPeriod.Value) ? Convert.ToInt64(hdn_ddlLiquorBoardPeriod.Value) : 0,
    //                txtGID.Text.Trim(), isSKUBased, isBrandBased);

    //            if (dsResult != null && dsResult.Tables.Count > 0)
    //                Response.Redirect(Page.ResolveUrl(string.Format(AdminUrls.Manage_Program, SuperProgramId)));
    //            else
    //                divMessage.InnerHtml = string.Format(Messages.ErrorMessage, "Failed to update program!");


    //            //dsResult = ManageProgramBAL.AddEdit(AppStaticData.ConnectionString, ProgramId, SuperProgramId, 0, Convert.ToInt64(ddlProvince.SelectedValue),
    //            //    Convert.ToInt32(ddlBusinessType.SelectedValue), txtSuperProgramName.Text.Trim(), Convert.ToInt32(ddlSGWSCalendarYear.SelectedValue),
    //            //    ddlSGWSCalendarPeriod.SelectedValue, StartDate, EndDate,
    //            //    !string.IsNullOrWhiteSpace(hdn_ddlLiquorBoardPeriod.Value) ? Convert.ToInt64(hdn_ddlLiquorBoardPeriod.Value) : 0,
    //            //    txtGID.Text.Trim(), isSKUBased, isBrandBased, Convert.ToInt64(ddlProgramType.SelectedValue),
    //            //    txtProgramName.Text.Trim(), txtComment.Text.Trim(), Convert.ToInt32(ddlProgramStatus.SelectedValue),
    //            //    Convert.ToInt32(ddlAboveTheLineOrBelowTheLine.SelectedValue),
    //            //    !string.IsNullOrWhiteSpace(txtDepthLTOorBAM.Text) ? Convert.ToDecimal(txtDepthLTOorBAM.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtForecastCaseSalesBase.Text) ? Convert.ToDecimal(txtForecastCaseSalesBase.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtForecastCaseSalesLift.Text) ? Convert.ToDecimal(txtForecastCaseSalesLift.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtForecastTotalCaseSalesPhysCs.Text) ? Convert.ToDecimal(txtForecastTotalCaseSalesPhysCs.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtForecastTotalCaseSales9LCsConverted.Text) ? Convert.ToDecimal(txtForecastTotalCaseSales9LCsConverted.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtVariableCostPerCase.Text) ? Convert.ToDecimal(txtVariableCostPerCase.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtUpFrontFeesforLTOorBAM.Text) ? Convert.ToDecimal(txtUpFrontFeesforLTOorBAM.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtPercentRedemptionRateforBAMonly.Text) ? Convert.ToDecimal(txtPercentRedemptionRateforBAMonly.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtQuantityofSpend.Text) ? Convert.ToDecimal(txtQuantityofSpend.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtSpendperQuantity.Text) ? Convert.ToDecimal(txtSpendperQuantity.Text.Trim()) : 0,
    //            //    !string.IsNullOrWhiteSpace(txtOtherFixedCostorFee.Text) ? Convert.ToDecimal(txtOtherFixedCostorFee.Text.Trim()) : 0);

    //            //int mode = 0;
    //            //if (ProgramId > 0)
    //            //    mode = 2;
    //            //else
    //            //    mode = 1;
    //            //if (dsResult != null && dsResult.Tables.Count > 0)
    //            //{
    //            //    if (dsResult.Tables[0].Rows.Count > 0)
    //            //    {
    //            //        SuperProgramId = Convert.ToInt64(dsResult.Tables[0].Rows[0]["SuperProgramId"]);
    //            //        ProgramId = Convert.ToInt64(dsResult.Tables[0].Rows[0]["ProgramId"]);
    //            //    }
    //            //    if (dsResult.Tables[1].Rows.Count > 0)
    //            //    {
    //            //        rptPrograms.DataSource = dsResult.Tables[1];
    //            //        rptPrograms.DataBind();
    //            //    }
    //            //    if (dsResult.Tables[2].Rows.Count > 0)
    //            //    {
    //            //        lblTotalProgramSpend.Text = Convert.ToString(dsResult.Tables[2].Rows[0]["TotalProgramSpend"]);
    //            //    }
    //            //    divMessage.InnerHtml = string.Format(Messages.SuccessMessage, mode == 1 ? "Program added successfully!" : "Program updated successfully!");

    //            //    FillGIDDetails(txtGID.Text.Trim(),Convert.ToInt64(ddlProvince.SelectedValue));
    //            //    //Response.Redirect(Page.ResolveUrl(string.Format(AdminUrls.Edit_SuperProgram, SuperProgramId)));
    //            //    //ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "$(function(){ChangeUrl(" + SuperProgramId + ");GetLiquorBoardPeriod(0);Validate_Float_Value();});", true);
    //            //    //RegisterScripts("ChangeUrl(" + SuperProgramId + ");GetLiquorBoardPeriod(0);Validate_Float_Value();");
    //            //}
    //        }
    //    }
    //    else
    //        Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
    //}


    //protected void lnkEditProgram_Click(object sender, EventArgs e)
    //{
    //    LinkButton lnkEditProgram = (LinkButton)sender;
    //    if(lnkEditProgram != null)
    //    {
    //        ProgramId = Convert.ToInt64(lnkEditProgram.CommandArgument);
    //        DataTable dt = ManageProgramBAL.GetProgramDetailsByProgramId(AppStaticData.ConnectionString, ProgramId);
    //        if(dt != null && dt.Rows.Count>0)
    //        {
    //            DataRow dr = dt.Rows[0];
    //            txtProgramName.Text = Convert.ToString(dr["ProgramTypeName"]);
    //            txtComment.Text = Convert.ToString(dr["Comment"]);
    //            ddlProgramType.SelectedValue = Convert.ToString(dr["ProgramTypeId"]);
    //            ddlAboveTheLineOrBelowTheLine.SelectedValue = Convert.ToString(dr["AboveTheLineBelowTheLine"]);
    //            ddlProgramStatus.SelectedValue = Convert.ToString(dr["ProgramStatusId"]);
    //            txtDepthLTOorBAM.Text = Convert.ToString(dr["Depth"]);
    //            txtForecastCaseSalesBase.Text = Convert.ToString(dr["ForecastCaseSalesBase"]);
    //            txtForecastCaseSalesLift.Text = Convert.ToString(dr["ForecastCaseSalesLift"]);
    //            txtForecastTotalCaseSalesPhysCs.Text = Convert.ToString(dr["ForecastTotalCaseSalesPhysCs"]);
    //            txtForecastTotalCaseSales9LCsConverted.Text = Convert.ToString(dr["ForecastTotalCaseSales9LCsConverted"]);
    //            txtVariableCostPerCase.Text = Convert.ToString(dr["VariableCostPerCase"]);
    //            txtUpFrontFeesforLTOorBAM.Text = Convert.ToString(dr["UpforntFees_LTO_BAM"]);
    //            txtPercentRedemptionRateforBAMonly.Text = Convert.ToString(dr["RedemptionBAM"]);
    //            txtQuantityofSpend.Text = Convert.ToString(dr["SpendQuantity"]);
    //            txtSpendperQuantity.Text = Convert.ToString(dr["SpendPerQuantity"]);
    //            txtOtherFixedCostorFee.Text = Convert.ToString(dr["OtherFixedCost"]);
    //            lblTotalProgramSpend.Text = Convert.ToString(dr["TotalProgramSpend"]);

    //            SetProgramStatus(string.Empty, true);
    //        }
    //    }
    //    RegisterScripts("Validate_Float_Value();");
    //}

    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    ProgramId = 0;
    //    txtProgramName.Text = null;
    //    txtComment.Text = null;
    //    ddlProgramType.SelectedValue = null;
    //    ddlAboveTheLineOrBelowTheLine.SelectedValue = null;
    //    ddlProgramStatus.SelectedValue = "3";
    //    txtDepthLTOorBAM.Text = null;
    //    txtForecastCaseSalesBase.Text = null;
    //    txtForecastCaseSalesLift.Text = null;
    //    txtForecastTotalCaseSalesPhysCs.Text = null;
    //    txtForecastTotalCaseSales9LCsConverted.Text = null;
    //    txtVariableCostPerCase.Text = null;
    //    txtUpFrontFeesforLTOorBAM.Text = null;
    //    txtPercentRedemptionRateforBAMonly.Text = null;
    //    txtQuantityofSpend.Text = null;
    //    txtSpendperQuantity.Text = null;
    //    txtOtherFixedCostorFee.Text = null;
    //    lblTotalProgramSpend.Text = "-";
    //    SetProgramStatus("3", false);
    //    RegisterScripts("jqueryDatatable();");
    //}
    private void RegisterScripts(string script)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "$(function(){" + script + "});", true);
    }

    //protected void gvPrograms_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e != null)
    //    {
    //        if (!string.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
    //        {                
    //            switch (e.CommandName)
    //            {
    //                case "Edit":
    //                    {
    //                        ProgramId = Convert.ToInt64(e.CommandArgument);
    //                        EditProgram();
    //                        break;
    //                    }
    //            }
    //        }
    //    }
    //}
    //private void EditProgram()
    //{

    //    if (ProgramId > 0)
    //    {
    //        DataTable dt = ManageProgramBAL.GetProgramDetailsByProgramId(AppStaticData.ConnectionString, ProgramId);
    //        if (dt != null && dt.Rows.Count > 0)
    //        {
    //            DataRow dr = dt.Rows[0];
    //            txtProgramName.Text = Convert.ToString(dr["ProgramTypeName"]);
    //            txtComment.Text = Convert.ToString(dr["Comment"]);
    //            ddlProgramType.SelectedValue = Convert.ToString(dr["ProgramTypeId"]);
    //            ddlAboveTheLineOrBelowTheLine.SelectedValue = Convert.ToString(dr["AboveTheLineBelowTheLine"]);
    //            ddlProgramStatus.SelectedValue = Convert.ToString(dr["ProgramStatusId"]);
    //            txtDepthLTOorBAM.Text = Convert.ToString(dr["Depth"]);
    //            txtForecastCaseSalesBase.Text = Convert.ToString(dr["ForecastCaseSalesBase"]);
    //            txtForecastCaseSalesLift.Text = Convert.ToString(dr["ForecastCaseSalesLift"]);
    //            txtForecastTotalCaseSalesPhysCs.Text = Convert.ToString(dr["ForecastTotalCaseSalesPhysCs"]);
    //            txtForecastTotalCaseSales9LCsConverted.Text = Convert.ToString(dr["ForecastTotalCaseSales9LCsConverted"]);
    //            txtVariableCostPerCase.Text = Convert.ToString(dr["VariableCostPerCase"]);
    //            txtUpFrontFeesforLTOorBAM.Text = Convert.ToString(dr["UpforntFees_LTO_BAM"]);
    //            txtPercentRedemptionRateforBAMonly.Text = Convert.ToString(dr["RedemptionBAM"]);
    //            txtQuantityofSpend.Text = Convert.ToString(dr["SpendQuantity"]);
    //            txtSpendperQuantity.Text = Convert.ToString(dr["SpendPerQuantity"]);
    //            txtOtherFixedCostorFee.Text = Convert.ToString(dr["OtherFixedCost"]);
    //            lblTotalProgramSpend.Text = Convert.ToString(dr["TotalProgramSpend"]);

    //            SetProgramStatus(string.Empty, true);
    //        }
    //    }
    //    RegisterScripts("Validate_Float_Value();");
    //}

}