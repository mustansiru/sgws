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
    public class SupplierRepository : ISupplierRepository
    {
        public List<Supplier> GetSuppliers(string sqlConnectionString)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = null;

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<Supplier> _list = new List<Supplier>();
                _list = DataReaderExtention.DataReaderMapToList<Supplier>(sqlHelper.ExeReader("Select Id,SupplierName From dbo.Supplier With(Nolock) Where Active = 1", CommandType.Text, sp));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("SupplierRepository=> GetSuppliers ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }
    }
}
