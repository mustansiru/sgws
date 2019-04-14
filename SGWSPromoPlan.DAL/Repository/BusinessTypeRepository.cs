using SGWSPromoPlan.DA;
using SGWSPromoPlan.DAL.SQLOperation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public class BusinessTypeRepository : IBusinessTypeRepository
    {
        public List<BusinessType> GetBusinessType(string sqlConnectionString)
        {
            SQLHelper sqlHelper;

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<BusinessType> _list = new List<BusinessType>();
                _list = DataReaderExtention.DataReaderMapToList<BusinessType>(sqlHelper.ExeReader("Select Id,BusinessType As BusinessTypeName From dbo.BusinessType With(Nolock)", CommandType.Text, null));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("BusinessTypeRepository=> GetBusinessType ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }
    }
}
