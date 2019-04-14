using System.Collections.Generic;

namespace SGWSPromoPlan.DAL
{
    public interface IChartRepository
    {
        List<Chart_GetProductCountByCategory> GetProductCountByCategory(string sqlConnectionString);
        List<Chart_GetTop10Suppliers> GetTop10Suppliers(string sqlConnectionString);
    }
}
