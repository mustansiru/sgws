using SGWSPromoPlan.DAL;
using System.Collections.Generic;

namespace SGWSPromoPlan.BAL
{
    public static class SupplierBAL
    {
        public static List<Supplier> GetSuppliers(string sqlConnectionString)
        {
            ISupplierRepository _ISupplierRepository = new SupplierRepository();
            return _ISupplierRepository.GetSuppliers(sqlConnectionString);
        }
    }
}
