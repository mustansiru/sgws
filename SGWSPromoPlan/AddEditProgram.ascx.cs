using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Linq;

public partial class AddEditProgram : System.Web.UI.UserControl
{
    public string PopupOpener
    {
        get
        {
            if (ViewState["PopupOpener"] != null)
                return Convert.ToString(ViewState["PopupOpener"]);
            else
                return string.Empty;
        }
        set { ViewState["PopupOpener"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        BindDropdown();
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

            var provinces = !string.IsNullOrWhiteSpace(SessionFacade.LoggedInUser_Province) ? SessionFacade.LoggedInUser_Province.Split(',') : new string[] { };
            DataRow dr = (from row in ds.Tables[3].AsEnumerable()
                          where row.Field<string>("Period") == "SEP-OCT"
                          select row).FirstOrDefault();

            if (!provinces.Contains("5") && !provinces.Contains("6"))//5=ONTARIO,6=QUEBEC 
                ds.Tables[3].Rows.Remove(dr);

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

            ddlPopUpProgramStatus.DataTextField = "Code";
            ddlPopUpProgramStatus.DataValueField = "Id";
            ddlPopUpProgramStatus.DataSource = ds.Tables[7];
            ddlPopUpProgramStatus.DataBind();
            ddlPopUpProgramStatus.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlBrand.DataTextField = "BrandName";
            ddlBrand.DataValueField = "Id";
            ddlBrand.DataSource = ds.Tables[8];
            ddlBrand.DataBind();
            ddlBrand.Items.Insert(0, new ListItem("--Select--", "0"));

            //ddlSGID.DataTextField = "GID";
            //ddlSGID.DataValueField = "GID";
            //ddlSGID.DataSource = ds.Tables[9];
            //ddlSGID.DataBind();
            //ddlSGID.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlSupplierName.DataTextField = "SupplierName";
            ddlSupplierName.DataValueField = "Id";
            ddlSupplierName.DataSource = ds.Tables[10];
            ddlSupplierName.DataBind();
            ddlSupplierName.Items.Insert(0, new ListItem("--Select--", "0"));

            //ddlProductName.DataTextField = "ProductName";
            //ddlProductName.DataValueField = "GID";
            //ddlProductName.DataSource = ds.Tables[11];
            //ddlProductName.DataBind();
            if (ds.Tables[11] != null && ds.Tables[11].Rows.Count > 0)
                ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "FillPopupDropdowns(" + Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[11]) + ")", true);
        }
    }
}