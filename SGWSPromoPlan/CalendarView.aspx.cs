using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using SGWSPromoPlan.DAL.Entities;

public partial class CalendarView : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                Page.Title = PageTitles.CalendarView;
                HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                h2PageTitle.InnerText = PageTitles.CalendarView;
                HtmlGenericControl liManageProgram = (HtmlGenericControl)Page.Master.FindControl("liCalendarView");
                liManageProgram.Attributes.Add("class", "active");
                HtmlGenericControl spanManageProgram = (HtmlGenericControl)Page.Master.FindControl("spanCalendarView");
                spanManageProgram.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                SetBreadCrumb(PageTitles.CalendarView, null, null);

                List<Supplier> suppliers = SupplierBAL.GetSuppliers(AppStaticData.ConnectionString).OrderBy(x => x.SupplierName).ToList();
                suppliers.Insert(0, new Supplier
                {
                    Id = -1,
                    SupplierName = "-- CHOOSE A SUPPLIER --"
                });
                ddlSuppliers.DataTextField = "SupplierName";
                ddlSuppliers.DataValueField = "Id";
                ddlSuppliers.DataSource = suppliers;
                ddlSuppliers.DataBind();

                List<Brand> brands = BrandBAL.GetBrandsSortedByName(AppStaticData.ConnectionString);
                brands.Insert(0, new Brand
                {
                    Id = -1,
                    BrandName = "-- CHOOSE A BRAND --"
                });
                ddlBrands.DataTextField = "BrandName";
                ddlBrands.DataValueField = "Id";
                ddlBrands.DataSource = brands;
                ddlBrands.DataBind();
            }
            else
            {
                Response.Redirect(Page.ResolveUrl(AdminUrls.Login));
            }
        }
    }

    protected void btnPopulate_Click(object sender, EventArgs e)
    {
        var brandId = Convert.ToInt32(ddlBrands.SelectedValue);
        var supplierId = Convert.ToInt32(ddlSuppliers.SelectedValue);

        if (brandId != -1 && supplierId != -1)
        {
            errMessage.Text = "Select only one from the two choices and retry.";
            errMessage.Visible = true;

            gvData.DataSource = null;
            gvData.DataBind();
        }
        else
        {
            errMessage.Text = string.Empty;
            errMessage.Visible = false;

            BindData(brandId, supplierId);
        }
    }

    protected void BindData(int brandId, int supplierId)
    {
        DataTable dt = CalendarViewBAL.GetCalendarView(AppStaticData.ConnectionString, brandId, supplierId);
        ViewState["gvData_DT"] = dt;
        ViewState["gvData_SortDirection"] = "ASC";
        ViewState["gvData_SortExpression"] = "BrandName";
        gvData.DataSource = dt;
        gvData.DataBind();
    }

    protected void gvData_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataTable dt = (DataTable)ViewState["gvData_DT"];
        if (dt.Rows.Count > 0)
        {
            if (Convert.ToString(ViewState["gvData_SortDirection"]) == "Asc")
            {
                dt.DefaultView.Sort = e.SortExpression + " Desc";
                ViewState["gvData_SortDirection"] = "Desc";
            }
            else
            {
                dt.DefaultView.Sort = e.SortExpression + " Asc";
                ViewState["gvData_SortDirection"] = "Asc";
            }

            ViewState["gvData_SortExpression"] = e.SortExpression;
            gvData.DataSource = dt;
            gvData.DataBind();
        }
    }

    protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            string sortBy = ViewState["gvData_SortExpression"].ToString();
            string sortDir = ViewState["gvData_SortDirection"].ToString();

            string sortArrow = sortDir.ToUpper() == "ASC" ? "&#9650;" : "&#9660;";

            foreach (System.Web.UI.WebControls.TableCell currCell in e.Row.Cells)
            {
                if (currCell.HasControls())
                {
                    var sortLink = ((LinkButton)currCell.Controls[0]);
                    if (sortLink.CommandArgument == sortBy)
                    {
                        sortLink.Text = sortLink.Text + " " + sortArrow;
                    }
                }
            }
        }
    }

    protected void gvData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvData.PageIndex = e.NewPageIndex;
        BindData(Convert.ToInt32(ddlBrands.SelectedValue), Convert.ToInt32(ddlSuppliers.SelectedValue));
    }
}