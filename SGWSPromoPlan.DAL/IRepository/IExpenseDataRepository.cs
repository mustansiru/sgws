using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public interface IExpenseDataRepository
    {
        int InsertExpenseData(string sqlConnectionString, string jsonStr, string FileName, Guid UserName);
        List<Expense> GetExpenseData(string sqlConnectionString, int year, string province, string suppliers, string UserId);

        System.Data.DataSet GetImportExpenseDropdown(string sqlConnectionString, string UserId);
    }
}
