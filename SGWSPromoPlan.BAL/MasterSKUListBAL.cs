using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.BAL
{
    public static class MasterSKUListBAL
    {
        public static List<SQLErrorInfo> InsertMasterSkuListData(string sqlConnectionString, string jsonStr, string FileName, Guid UserName)
        {
            IMasterSKUListRepository _IMasterSKUListRepository = new MasterSKUListRepository();
            return _IMasterSKUListRepository.InsertMasterSkuListData(sqlConnectionString, jsonStr, FileName, UserName);
        }
        public static List<TMP_ProductInfoNew> GetProductInfoData(string sqlConnectionString)
        {
            IMasterSKUListRepository _IMasterSKUListRepository = new MasterSKUListRepository();
            return _IMasterSKUListRepository.GetProductInfoData(sqlConnectionString);
        }
        public static List<TMP_ParseError> GetParseErrorData(string sqlConnectionString)
        {
            IMasterSKUListRepository _IMasterSKUListRepository = new MasterSKUListRepository();
            return _IMasterSKUListRepository.GetParseErrorData(sqlConnectionString);
        }
        public static System.Data.DataSet GetBrand_Products_BySupplier(string sqlConnectionString, long SupplierId)
        {
            IMasterSKUListRepository _IMasterSKUListRepository = new MasterSKUListRepository();
            return _IMasterSKUListRepository.GetBrand_Products_BySupplier(sqlConnectionString, SupplierId);
        }

        public static System.Data.DataTable GetProducts_BySupplier_Brand(string sqlConnectionString, long SupplierId, long BrandId)
        {
            IMasterSKUListRepository _IMasterSKUListRepository = new MasterSKUListRepository();
            return _IMasterSKUListRepository.GetProducts_BySupplier_Brand(sqlConnectionString, SupplierId, BrandId);
        }
        public static System.Data.DataTable GetProductDetailsByGID(string sqlConnectionString, string GID)
        {
            IMasterSKUListRepository _IMasterSKUListRepository = new MasterSKUListRepository();
            return _IMasterSKUListRepository.GetProductDetailsByGID(sqlConnectionString, GID);
        }
    }
}
