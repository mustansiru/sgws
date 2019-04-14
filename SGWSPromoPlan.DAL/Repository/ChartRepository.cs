using SGWSPromoPlan.DA;
using SGWSPromoPlan.DAL.SQLOperation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SGWSPromoPlan.DAL
{
    public class ChartRepository : IChartRepository
    {
        public List<Chart_GetProductCountByCategory> GetProductCountByCategory(string sqlConnectionString)
        {
            List<Chart_GetProductCountByCategory> list = new List<Chart_GetProductCountByCategory>();
            SQLHelper sqlHelper = new SQLHelper(sqlConnectionString);
           
            List<SqlParameter> sp=null;

            try
            {
                list = DataReaderExtention.DataReaderMapToList<Chart_GetProductCountByCategory>(sqlHelper.ExeReader(SQLFacade.USP_Chart_GetProductCountByCategory, CommandType.StoredProcedure, sp)); ;
                return list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ChartRepository => GetProductCountByCategory => Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                throw;
            }
            finally
            {
                list = null;
                sqlHelper = null;
            }
        }

        public List<Chart_GetTop10Suppliers> GetTop10Suppliers(string sqlConnectionString)
        {
            List<Chart_GetTop10Suppliers> list = new List<Chart_GetTop10Suppliers>();
            SQLHelper sqlHelper = new SQLHelper(sqlConnectionString);

            List<SqlParameter> sp = null;

            try
            {
                list = DataReaderExtention.DataReaderMapToList<Chart_GetTop10Suppliers>(sqlHelper.ExeReader(SQLFacade.USA_Chart_GetTop10Suppliers, CommandType.StoredProcedure, sp)); ;
                return list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ChartRepository => GetTop10Suppliers => Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                throw;
            }
            finally
            {
                list = null;
                sqlHelper = null;
            }
        }
    }
}
