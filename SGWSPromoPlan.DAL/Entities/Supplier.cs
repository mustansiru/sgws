using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public class Supplier
    {
        public long Id { get; set; }
        public string SupplierName { get; set; }
    }

    public class SupplierBrand
    {
        public long Id { get; set; }
        public string BrandName { get; set; }
        public long SupplierId { get; set; }
    }
}
