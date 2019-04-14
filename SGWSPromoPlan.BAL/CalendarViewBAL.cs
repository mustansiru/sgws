using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SGWSPromoPlan.DAL;
using SGWSPromoPlan.DAL.Repository;

namespace SGWSPromoPlan.BAL
{
    public static class CalendarViewBAL
    {
        public static DataTable GetCalendarView(string sqlConnectionString, int brandId, int supplierId)
        {
            ICalendarViewRepository repository = new CalendarViewRepository(sqlConnectionString);
            return repository.GetCalendarView(brandId, supplierId).Tables[0];
        }
    }
}
