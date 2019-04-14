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
   public class ProvinceRepository : IProvinceRepository
    {
        public List<Province> GetProvince(string sqlConnectionString)
        {
            SQLHelper sqlHelper;
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<Province> _list = new List<Province>();
                _list = DataReaderExtention.DataReaderMapToList<Province>(sqlHelper.ExeReader("Select Id,Province As ProvinceName From dbo.Province With (Nolock)", CommandType.Text, null));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ProvinceRepository=> GetProvince ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

    }
}
