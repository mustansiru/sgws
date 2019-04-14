using SGWSPromoPlan.DA;
using SGWSPromoPlan.DAL.SQLOperation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SGWSPromoPlan.DAL
{
    public class ExpenseDataRepository:IExpenseDataRepository
    {
        public int InsertExpenseData(string sqlConnectionString, string jsonStr, string FileName, Guid UserName)
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
                //_list = DataReaderExtention.DataReaderMapToList<SQLErrorInfo>(
                //                    sqlHelper.ExeReader(SQLFacade.InsertExpenseData, CommandType.StoredProcedure, sp));
                return sqlHelper.ExeNonQuery(SQLFacade.InsertExpenseData, CommandType.StoredProcedure, sp);
                //return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("InsertExpenseData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return 0;
            }
        }

        public List<Expense> GetExpenseData(string sqlConnectionString,int year, string province, string suppliers,string UserId)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@year", SqlDbType = SqlDbType.Int, Value= year},
                    new SqlParameter() {ParameterName = "@province", SqlDbType = SqlDbType.VarChar, Value= province},
                    new SqlParameter() {ParameterName = "@suppliers", SqlDbType = SqlDbType.VarChar, Value= suppliers},
                    new SqlParameter() {ParameterName = "@UserId", SqlDbType = SqlDbType.VarChar, Value= UserId}
                };

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<Expense> _list = new List<Expense>();
                //_list = DataReaderExtention.DataReaderMapToList<Expense>(sqlHelper.ExeReader("select * from Expense With (Nolock)", CommandType.Text, sp));
                _list = DataReaderExtention.DataReaderMapToList<Expense>(sqlHelper.ExeReader("GetExpenseData", CommandType.StoredProcedure, sp));
                return _list;
            }
            catch (Exception ex)
            {
                log.WriteLog("GetExpenseData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public System.Data.DataSet GetImportExpenseDropdown(string sqlConnectionString,string UserId)
        {
            SQLHelper sqlHelper;

            DataSet ds = new DataSet();
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@UserId", SqlDbType = SqlDbType.VarChar, Value= UserId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.GetImportExpenseDropdown, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetImportExpenseDropdown =>  Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                ds = null;
            }
        }

    }
}
