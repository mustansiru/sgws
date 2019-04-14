using System.Data;

namespace SGWSPromoPlan.DAL
{
    public interface ICalendarViewRepository
    {
        DataSet GetCalendarView(int brandId, int supplierId);
    }
}