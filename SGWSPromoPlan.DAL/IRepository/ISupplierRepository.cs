using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public interface ISupplierRepository
    {
        List<Supplier> GetSuppliers(string sqlConnectionString);
    }
}
