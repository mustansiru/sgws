using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SGWSPromoPlan.DAL.SQLOperation;

namespace SGWSPromoPlan.DAL.Repository
{
    public class CalendarViewRepository: ICalendarViewRepository
    {
        private readonly string _sqlConnStr;

        public CalendarViewRepository(string connectionString)
        {
            _sqlConnStr = connectionString;
        }
        public DataSet GetCalendarView(int brandId, int supplierId)
        {
            var sqlHelper = new SQLHelper(_sqlConnStr);
            var ds = new DataSet();
            var spParams = new List<SqlParameter>();
            spParams.Add(new SqlParameter
            {
                ParameterName = "@pBrandId",
                SqlDbType = SqlDbType.BigInt,
                Value = brandId
            });
            spParams.Add(new SqlParameter
            {
                ParameterName = "@pSupplierId",
                SqlDbType = SqlDbType.BigInt,
                Value = supplierId
            });
            sqlHelper.GetDataSet(SQLFacade.GetCalendarView, ds, CommandType.StoredProcedure, spParams);

            // Build calendar data table
            return ds;
        }
    }
}
