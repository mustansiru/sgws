using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _404 : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            aHome.HRef = Page.ResolveUrl("~/login.aspx");
            aHome.InnerHtml = "Login";
        }
    }
}