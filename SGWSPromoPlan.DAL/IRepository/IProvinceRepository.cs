using System.Collections.Generic;

namespace SGWSPromoPlan.DAL
{
    public interface IProvinceRepository
    {
        List<Province> GetProvince(string sqlConnectionString);
    }
}
