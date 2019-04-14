using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SGWSPromoPlan.DA;
using SGWSPromoPlan.DAL.Entities;
using SGWSPromoPlan.DAL.SQLOperation;

namespace SGWSPromoPlan.DAL.Repository
{
    public class BrandRepository : IBrandRepository
    {
        public List<Brand> GetBrandsSortedByName(string sqlConnectionString)
        {
            try
            {
                var sqlHelper = new SQLHelper(sqlConnectionString);
                var list = DataReaderExtention.DataReaderMapToList<Brand>(sqlHelper.ExeReader(
                    "Select Id, BrandName From dbo.Brand With(Nolock) Order By BrandName ASC", CommandType.Text, null));

                return list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("BrandRepository => GetBrands ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }
    }
}
