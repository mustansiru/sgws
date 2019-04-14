using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SGWSPromoPlan.DAL;
using SGWSPromoPlan.DAL.Entities;
using SGWSPromoPlan.DAL.Repository;

namespace SGWSPromoPlan.BAL
{
    public static class BrandBAL
    {
        public static List<Brand> GetBrandsSortedByName(string sqlConnectionString)
        {
            IBrandRepository repository = new BrandRepository();
            return repository.GetBrandsSortedByName(sqlConnectionString);
        }
    }
}
