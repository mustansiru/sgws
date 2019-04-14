using SGWSPromoPlan.DAL;
using System.Collections.Generic;

namespace SGWSPromoPlan.BAL
{
    public static class ProvinceBAL
    {
        public static List<Province> GetProvince(string sqlConnectionString)
        {
            IProvinceRepository _IProvinceRepository = new ProvinceRepository();
            return _IProvinceRepository.GetProvince(sqlConnectionString);
        }
    }
}
