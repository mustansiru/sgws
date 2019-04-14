using System.Collections.Generic;

namespace SGWSPromoPlan.DAL
{
    public interface IBusinessTypeRepository
    {
        List<BusinessType> GetBusinessType(string sqlConnectionString);
    }
}
