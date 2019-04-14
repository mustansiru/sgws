using Newtonsoft.Json;
using SGWSPromoPlan.BAL;
using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Web.Hosting;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;

public partial class ImportProgram : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (SessionFacade.LoggedInUser != null)
            {
                Page.Title = AdminPageTitles.ImportProgramData;

                if (SessionFacade.LoggedInUser.Role == RoleIDs.Admin)
                {
                    HtmlGenericControl h2PageTitle = (HtmlGenericControl)Page.Master.FindControl("h2PageTitle");
                    h2PageTitle.InnerText = AdminPageTitles.ImportProgramData;

                    HtmlGenericControl liImportExpenseData = (HtmlGenericControl)Page.Master.FindControl("liImportExpenseData");
                    liImportExpenseData.Attributes.Add("class", "active");

                    HtmlGenericControl spanImportExpenseData = (HtmlGenericControl)Page.Master.FindControl("spanImportExpenseData");
                    spanImportExpenseData.Attributes.Add("class", "caret-right-active fa fa-caret-right");

                    SetBreadCrumb(AdminPageTitles.ImportProgramData, null, null);
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

    [System.Web.Services.WebMethod]
    [ScriptMethod(UseHttpGet = false)]
    public static string GetFileData(string fileName)
    {
        try
        {
            var jsonString = ExcelHelper.ImportProgramData(HostingEnvironment.MapPath("~/UploadedFiles/") + fileName);


            List<SQLErrorInfo> _errorList = ManageProgramBAL.InsertProgramData(AppStaticData.ConnectionString, jsonString,
                                                                            fileName, SessionFacade.LoggedInUser.UserId);
            if (!_errorList[0].ErrorMessage.Equals("success"))
            {
                SGWSPromoPlan.DAL.log.WriteLog("MasterSKUList => InsertMasterSkuListData ===> Message: " + _errorList[0].ErrorMessage);
                return string.Empty;
            }
            return jsonString;
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("ImportProgram.cs => GetFileData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
            return string.Empty;
        }
    }
}