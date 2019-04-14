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

public partial class bulkupload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            long CompanyID = 10;
            DateTime startDate = DateTime.ParseExact("2018-10-1", "yyyy-M-d", CultureInfo.InvariantCulture);
            DateTime endDate = DateTime.ParseExact("2018-10-31", "yyyy-M-d", CultureInfo.InvariantCulture);
            //BulkUploadFacilities(CompanyID, startDate, endDate);

            //BulkUploadSamplePoints(CompanyID);
            //Bulk_Insert_GasAnalysisData(CompanyID);
        }
    }

    private void BulkUploadFacilities(long CompanyID, DateTime startDate, DateTime endDate)
    {
        try
        {
            if (endDate.Date > startDate.Date)
            {
                string filepath = Directory.GetFiles(@"C:\Users\Rohit Z\Downloads", "Cona_Wells_AddedbyBot_ClairifiTemplate_Sept11(1).xlsx").Single();
                string sqlquery = "Select * From [FACILITIES$] where [CostCentre]<>NULL AND [CostCentre]<>''";
                DataSet ds = new DataSet();
                string constring = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filepath + ";Extended Properties=\"Excel 12.0;HDR=YES;\"";
                OleDbConnection con = new OleDbConnection(constring + "");
                OleDbDataAdapter da = new OleDbDataAdapter(sqlquery, con);
                da.Fill(ds);
                DataTable dtFacilityBulkImport = ds.Tables[0];

                while (endDate > startDate)
                {
                    using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Con"].ToString()))
                    {
                        conn.Open();
                        SqlCommand sqlComm = new SqlCommand("Bulk_Insert_Facilities", conn);
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
                        SqlParameter sqlParamdtFacilityBulkImport = new SqlParameter("@dtFacilityBulkImport", SqlDbType.Structured);
                        sqlParamdtFacilityBulkImport.Value = dtFacilityBulkImport;
                        sqlComm.Parameters.Add(sqlParamdtFacilityBulkImport);

                        sqlComm.ExecuteNonQuery();
                    }
                    startDate = startDate.AddMonths(1);
                }
            }
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
        }
    }

    private void BulkUploadSamplePoints(long CompanyID)
    {
        try
        {
            string filepath = Directory.GetFiles(@"C:\Client Projects\imports\imports\RegTech(Company)", "Import_SamplePoints.xlsx").Single();
            string sqlquery = "Select * From [SamplePoints$] where [SamplePointCode]<>NULL AND [CostCentre]<>NULL";
            DataSet ds = new DataSet();
            string constring = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filepath + ";Extended Properties=\"Excel 12.0;HDR=YES;\"";
            OleDbConnection con = new OleDbConnection(constring + "");
            OleDbDataAdapter da = new OleDbDataAdapter(sqlquery, con);
            da.Fill(ds);
            DataTable dtSamplePointsBulkImport = ds.Tables[0];

            using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Con"].ToString()))
            {
                conn.Open();
                SqlCommand sqlComm = new SqlCommand("Bulk_Insert_SamplePoints", conn);
                sqlComm.CommandType = CommandType.StoredProcedure;

                sqlComm.CommandTimeout = 0;

                SqlParameter sqlParamCompanyID = new SqlParameter("@CompanyID", SqlDbType.BigInt);
                sqlParamCompanyID.Value = CompanyID;
                sqlComm.Parameters.Add(sqlParamCompanyID);
                SqlParameter sqlParamdtSamplePointsBulkImport = new SqlParameter("@dtSamplePointBulkImport", SqlDbType.Structured);
                sqlParamdtSamplePointsBulkImport.Value = dtSamplePointsBulkImport;
                sqlComm.Parameters.Add(sqlParamdtSamplePointsBulkImport);

                sqlComm.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
        }
    }

    private void Bulk_Insert_GasAnalysisData(long CompanyID)
    {
        try
        {
            string filepath = Directory.GetFiles(@"C:\Client Projects\imports\imports\RegTech(Company)", "Import_GasAnalysisdata.xlsx").Single();
            string sqlquery = "Select * From [GasAnalysisData$] where [SamplePointCode]<>NULL";
            DataSet ds = new DataSet();
            string constring = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filepath + ";Extended Properties=\"Excel 12.0;HDR=YES;\"";
            OleDbConnection con = new OleDbConnection(constring + "");
            OleDbDataAdapter da = new OleDbDataAdapter(sqlquery, con);
            da.Fill(ds);
            DataTable dtGasAnalysisDataBulkImport = ds.Tables[0];

            using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Con"].ToString()))
            {
                conn.Open();
                SqlCommand sqlComm = new SqlCommand("Bulk_Insert_GasAnalysisData", conn);
                sqlComm.CommandType = CommandType.StoredProcedure;

                sqlComm.CommandTimeout = 0;

                SqlParameter sqlParamCompanyID = new SqlParameter("@CompanyID", SqlDbType.BigInt);
                sqlParamCompanyID.Value = CompanyID;
                sqlComm.Parameters.Add(sqlParamCompanyID);
                SqlParameter sqlParamdtGasAnalysisDataBulkImport = new SqlParameter("@dtGasAnalysisDataBulkImport", SqlDbType.Structured);
                sqlParamdtGasAnalysisDataBulkImport.Value = dtGasAnalysisDataBulkImport;
                sqlComm.Parameters.Add(sqlParamdtGasAnalysisDataBulkImport);

                sqlComm.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            SGWSPromoPlan.DAL.log.WriteLog("Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
        }
    }    
}