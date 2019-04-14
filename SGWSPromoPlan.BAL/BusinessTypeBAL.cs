using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.BAL
{
    public static class BusinessTypeBAL
    {
        public static List<BusinessType> GetBusinessType(string sqlConnectionString)
        {
            IBusinessTypeRepository _IBusinessTypeRepository = new BusinessTypeRepository();
            return _IBusinessTypeRepository.GetBusinessType(sqlConnectionString);
        }

    }
}
