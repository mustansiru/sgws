using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;

namespace SGWSPromoPlan.BAL
{
    public class ExpenseDataBAL
    {
        public int InsertExpenseData(string sqlConnectionString, string jsonStr, string FileName, Guid UserName)
        {
            IExpenseDataRepository _IExpenseDataRepository = new ExpenseDataRepository();
            return _IExpenseDataRepository.InsertExpenseData(sqlConnectionString, jsonStr, FileName, UserName);
        }
        public List<Expense> GetExpenseData(string sqlConnectionString, int year, string province, string suppliers, string UserId)
        {
            IExpenseDataRepository _IExpenseDataRepository = new ExpenseDataRepository();
            return _IExpenseDataRepository.GetExpenseData(sqlConnectionString, year, province, suppliers, UserId);
        }

        public DataSet GetImportExpenseDropdown(string sqlConnectionString, string UserId)
        {
            IExpenseDataRepository _IExpenseDataRepository = new ExpenseDataRepository();
            return _IExpenseDataRepository.GetImportExpenseDropdown(sqlConnectionString, UserId);
        }
    }
}
