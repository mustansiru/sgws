using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bulkupload_equipment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            long CompanyID = 10;
            DateTime startDate = DateTime.ParseExact("2018-12-1", "yyyy-M-d", CultureInfo.InvariantCulture);
            DateTime endDate = DateTime.ParseExact("2018-12-31", "yyyy-M-d", CultureInfo.InvariantCulture);
            BulkUploadEquipment(CompanyID, startDate, endDate);
        }
    }

    private void BulkUploadEquipment(long CompanyID, DateTime startDate, DateTime endDate)
    {
        int i = 0;
        try
        {
            if (endDate.Date > startDate.Date)
            {
                string filepath = Directory.GetFiles(@"E:\Vipul Sir\upload_excel", "Uploadsheet.xlsx").Single();
                string sqlquery = "Select * From [Equipment$] where [EquipmentCategoryID]<>NULL AND [EquipmentCategoryID]<>''";
                DataSet ds = new DataSet();
                string constring = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filepath + ";Extended Properties=\"Excel 12.0;HDR=YES;\"";
                OleDbConnection con = new OleDbConnection(constring + "");
                OleDbDataAdapter da = new OleDbDataAdapter(sqlquery, con);
                da.Fill(ds);
                DataTable dtBulkImport = ds.Tables[0];

                while (endDate > startDate)
                {
                    using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Con"].ToString()))
                    {
                        conn.Open();
                        SqlCommand sqlComm = new SqlCommand("InsertCompanyEquipment_BulkInsertOperation", conn);
                        sqlComm.CommandType = CommandType.StoredProcedure;

                        sqlComm.CommandTimeout = 0;

                        SqlParameter sqlParamCompanyID = new SqlParameter("@CompanyID", SqlDbType.BigInt);
                        sqlParamCompanyID.Value = CompanyID;
                        sqlComm.Parameters.Add(sqlParamCompanyID);
                        SqlParameter sqlParamstartDate = new SqlParameter("@StartDate", SqlDbType.Date);
                        sqlParamstartDate.Value = startDate;
                        sqlComm.Parameters.Add(sqlParamstartDate);
                        SqlParameter sqlParamendDate = new SqlParameter("@EndDate", SqlDbType.Date);
                        sqlParamendDate.Value = startDate.AddMonths(1).AddDays(-1);
                        sqlComm.Parameters.Add(sqlParamendDate);
                        SqlParameter sqlParamdtBulkImport = new SqlParameter("@dtCE", SqlDbType.Structured);
                        sqlParamdtBulkImport.Value = dtBulkImport;
                        sqlComm.Parameters.Add(sqlParamdtBulkImport);

                        i = sqlComm.ExecuteNonQuery();
                    }
                    startDate = startDate.AddMonths(1);
                }
            }
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
        }

        Response.Write(i);
    }


}