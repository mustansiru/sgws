
using System;
using System.Collections.Generic;
using System.Data;

namespace SGWSPromoPlan.DAL
{
    public interface IMasterSKUListRepository
    {
        List<SQLErrorInfo> InsertMasterSkuListData(string sqlConnectionString, string jsonStr, string FileName, Guid UserName);
        List<TMP_ProductInfoNew> GetProductInfoData(string sqlConnectionString);
        List<TMP_ParseError> GetParseErrorData(string sqlConnectionString);

        DataSet GetBrand_Products_BySupplier(string sqlConnectionString, long SupplierId);
        DataTable GetProducts_BySupplier_Brand(string sqlConnectionString, long SupplierId, long BrandId);
        DataTable GetProductDetailsByGID(string sqlConnectionString, string GID);
    }
}
