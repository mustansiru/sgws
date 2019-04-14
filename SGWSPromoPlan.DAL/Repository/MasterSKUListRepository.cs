using SGWSPromoPlan.DA;
using SGWSPromoPlan.DAL.SQLOperation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;


namespace SGWSPromoPlan.DAL
{
    public class MasterSKUListRepository : IMasterSKUListRepository
    {
        public List<SQLErrorInfo> InsertMasterSkuListData(string sqlConnectionString, string jsonStr, string FileName, Guid UserName)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@json", SqlDbType = SqlDbType.NVarChar, Value= jsonStr},
                    new SqlParameter() {ParameterName = "@FileName", SqlDbType = SqlDbType.NVarChar, Value= FileName},
                    new SqlParameter() {ParameterName = "@UserName", SqlDbType = SqlDbType.UniqueIdentifier, Value= UserName}

                };

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);

                List<SQLErrorInfo> _list = new List<SQLErrorInfo>();
                _list = DataReaderExtention.DataReaderMapToList <SQLErrorInfo>(sqlHelper.ExeReader(SQLFacade.InsertMasterSkuListData, CommandType.StoredProcedure, sp));
                //return sqlHelper.ExeNonQuery(SQLFacade.InsertMasterSkuListData, CommandType.StoredProcedure, sp);
                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("MasterSKUListRepository ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public List<TMP_ProductInfoNew> GetProductInfoData(string sqlConnectionString)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = null;

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<TMP_ProductInfoNew> _list = new List<TMP_ProductInfoNew>();
                _list = DataReaderExtention.DataReaderMapToList<TMP_ProductInfoNew>(sqlHelper.ExeReader("select * from TMP_ProductInfo With (Nolock)", CommandType.Text, sp));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("MasterSKUListRepository ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public List<TMP_ParseError> GetParseErrorData(string sqlConnectionString)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = null;

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<TMP_ParseError> _list = new List<TMP_ParseError>();
                _list = DataReaderExtention.DataReaderMapToList<TMP_ParseError>(sqlHelper.ExeReader("Select * from Tmp_ParseError With (Nolock)", CommandType.Text, sp));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("MasterSKUListRepository => GetParseErrorData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public DataSet GetBrand_Products_BySupplier(string sqlConnectionString, long SupplierId)
        {
            DataSet ds = new DataSet();
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@SupplierId", SqlDbType = SqlDbType.BigInt, Value= SupplierId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.GetBrand_Products_BySupplier, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                log.WriteLog("GetBrand_Products_BySupplier ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                ds = null;
            }
        }

        public DataTable GetProducts_BySupplier_Brand(string sqlConnectionString, long SupplierId,long BrandId)
        {
            DataTable ds = new DataTable();
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@SupplierId", SqlDbType = SqlDbType.BigInt, Value= SupplierId},
                    new SqlParameter() {ParameterName = "@BrandId", SqlDbType = SqlDbType.BigInt, Value= BrandId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.GetProducts_BySupplier_Brand, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                log.WriteLog("GetProducts_BySupplier_Brand ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                ds = null;
            }
        }

        public DataTable GetProductDetailsByGID(string sqlConnectionString, string GID)
        {
            DataTable dt = new DataTable();
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@GID", SqlDbType = SqlDbType.VarChar, Value= GID}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.GetProductDetailsByGID, dt, CommandType.StoredProcedure, sp);
                return dt;
            }
            catch (Exception ex)
            {
                log.WriteLog("GetProductDetailsByGID ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                dt = null;
            }
        }
    }
}
