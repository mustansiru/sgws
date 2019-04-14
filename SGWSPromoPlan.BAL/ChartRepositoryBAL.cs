using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.BAL
{
    public static class ChartRepositoryBAL
    {
        public static List<Chart_GetProductCountByCategory> GetProgramDetail(string sqlConnectionString)
        {
            IChartRepository _IChartRepository = new ChartRepository();
            return _IChartRepository.GetProductCountByCategory(sqlConnectionString);
        }

        public static List<Chart_GetTop10Suppliers> GetTop10Suppliers(string sqlConnectionString)
        {
            IChartRepository _IChartRepository = new ChartRepository();
            return _IChartRepository.GetTop10Suppliers(sqlConnectionString);
        }
    }
}
