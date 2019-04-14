using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
    public BasePage()
    {
    }
    //public string UserId
    //{
    //    get
    //    {
    //        if (Session["userId"] != null)
    //            return Convert.ToString(Session["userId"]);
    //        else
    //            return null;
    //    }
    //}

    //public long CompanyID
    //{
    //    get
    //    {
    //        if (Session["companyId"] != null)
    //            return Convert.ToInt64(Session["companyId"]);
    //        else
    //            return 0;
    //    }
    //}
    //public string RoleId
    //{
    //    get
    //    {
    //        if (Session["roleId"] != null)
    //            return Convert.ToString(Session["roleId"]);
    //        else
    //            return null;
    //    }
    //}
    //public string EmailId
    //{
    //    get
    //    {
    //        if (Session["emailId"] != null)
    //            return Convert.ToString(Session["emailId"]);
    //        else
    //            return null;
    //    }
    //}
    //public string UserName
    //{
    //    get
    //    {
    //        if (Session["username"] != null)
    //            return Convert.ToString(Session["username"]);
    //        else
    //            return null;
    //    }
    //}

    //public string BusinessLegalName
    //{
    //    get
    //    {
    //        if (Session["businesslegalname"] != null)
    //            return Convert.ToString(Session["businesslegalname"]);
    //        else
    //            return null;
    //    }
    //}
    //public bool IsWarningDisable
    //{
    //    get
    //    {
    //        if (Session["IsWarningDisable"] != null)
    //            return Convert.ToBoolean(Session["IsWarningDisable"]);
    //        else
    //            return false;
    //    }
    //}

    //public DateTime? MinDate
    //{
    //    get
    //    {
    //        if (Session["minDate"] != null)
    //            return Convert.ToDateTime(Session["minDate"]);
    //        else
    //            return null;
    //    }
    //}
    //public DateTime? MaxDate
    //{
    //    get
    //    {
    //        if (Session["maxDate"] != null)
    //            return Convert.ToDateTime(Session["maxDate"]);
    //        else
    //            return null;
    //    }
    //}

    //public bool CheckRole(string roleId)
    //{
    //    if (RoleId.ToLower() == roleId.ToString().ToLower())
    //        return true;
    //    else
    //        return false;
    //}
   
    public void SetBreadCrumb(string link_1_Name, string link_2_Name, string link_1)
    {
        HtmlGenericControl libreadcrumb_1 = (HtmlGenericControl)Page.Master.FindControl("libreadcrumb_1");
        HtmlGenericControl libreadcrumb_2 = (HtmlGenericControl)Page.Master.FindControl("libreadcrumb_2");

        libreadcrumb_1.Visible = true;
        HtmlAnchor abreadcrumb_1 = (HtmlAnchor)Page.Master.FindControl("abreadcrumb_1");
        abreadcrumb_1.InnerHtml = link_1_Name;

        if (!string.IsNullOrEmpty(link_2_Name))
        {
            abreadcrumb_1.HRef = Page.ResolveUrl(link_1);
            libreadcrumb_2.Visible = true;
            HtmlAnchor abreadcrumb_2 = (HtmlAnchor)Page.Master.FindControl("abreadcrumb_2");
            abreadcrumb_2.InnerHtml = link_2_Name;
            abreadcrumb_2.Disabled = true;
        }
        else
        {
            abreadcrumb_1.Disabled = true;
        }
    }

    public void SetBreadCrumb(string link_1_Name, string link_2_Name, string link_3_Name, string link_1, string link_2)
    {
        HtmlGenericControl libreadcrumb_1 = (HtmlGenericControl)Page.Master.FindControl("libreadcrumb_1");
        HtmlGenericControl libreadcrumb_2 = (HtmlGenericControl)Page.Master.FindControl("libreadcrumb_2");
        HtmlGenericControl libreadcrumb_3 = (HtmlGenericControl)Page.Master.FindControl("libreadcrumb_3");

        libreadcrumb_1.Visible = true;
        libreadcrumb_2.Visible = true;

        HtmlAnchor abreadcrumb_1 = (HtmlAnchor)Page.Master.FindControl("abreadcrumb_1");
        abreadcrumb_1.InnerHtml = link_1_Name;
        abreadcrumb_1.HRef = Page.ResolveUrl(link_1);

        HtmlAnchor abreadcrumb_2 = (HtmlAnchor)Page.Master.FindControl("abreadcrumb_2");
        abreadcrumb_2.InnerHtml = link_2_Name;
        abreadcrumb_2.HRef = Page.ResolveUrl(link_2);

        if (!string.IsNullOrEmpty(link_3_Name))
        {
            libreadcrumb_3.Visible = true;
            HtmlAnchor abreadcrumb_3 = (HtmlAnchor)Page.Master.FindControl("abreadcrumb_3");
            abreadcrumb_3.InnerHtml = link_3_Name;
            abreadcrumb_3.Disabled = true;
        }
    }


}