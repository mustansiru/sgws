using System.Collections.Generic;
using SGWSPromoPlan.DAL.Entities;

namespace SGWSPromoPlan.DAL
{
    public interface IBrandRepository
    {
        List<Brand> GetBrandsSortedByName(string sqlConnectionString);
    }
}