<%@ WebHandler Language="C#" Class="UserMasterHandler" %>

using System;
using System.Web;

public class UserMasterHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        int idisplaylength = int.Parse(context.Request["iDisplayLength"]);
        int idisplaystart = int.Parse(context.Request["iDisplayStart"]);
        int sortcol = int.Parse(context.Request["iSortCol_0"]);
        string sortDir = context.Request["sSortDir_0"];
        string search = context.Request["sSearch"];
        long companyID = Convert.ToInt64(context.Session["companyId"]);
        int IsFemsInspector = 0;
        if (context.Request["IsFemsInspector"] != null)
        {
            IsFemsInspector = Convert.ToInt32(context.Request["IsFemsInspector"]);
        }

        int typeID = (companyID == 0 ? 2 : 1);

        if (IsFemsInspector == 1)
        {
            typeID = 3;
        }


        Int64 TotalRecordCount = 0;
        Int64 TotalDisplayRecordCount = 0;
        System.Collections.Generic.List<SGWSPromoPlan.DAL.UserMaster> lstUserMaster = SGWSPromoPlan.BAL.ManageUserBAL.GetUsers_By_Page(AppStaticData.ConnectionString, idisplaylength, idisplaystart, sortcol, sortDir, search, out TotalRecordCount, out TotalDisplayRecordCount);

        var result = new
        {
            iTotalRecords = TotalRecordCount,
            iTotalDisplayRecords = TotalDisplayRecordCount,
            aaData = lstUserMaster
        };

        System.Web.Script.Serialization.JavaScriptSerializer oJavaScriptSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        context.Response.Write(oJavaScriptSerializer.Serialize(result));
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}