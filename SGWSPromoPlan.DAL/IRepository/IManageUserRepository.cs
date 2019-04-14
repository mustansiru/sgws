using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public interface IManageUserRepository
    {
        List<UserMaster> GetUsers_By_Page(string sqlConnectionString,int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch,
           out Int64 TotalRecordCount, out Int64 TotalSearchRecords);

        DataTable GetUser(string sqlConnectionString, string UserID);

        DataTable GetRoles(string sqlConnectionString, string UserID);

        DataSet ValidateUser(string sqlConnectionString, string UserName, string Password);

        int AddEditUser(string sqlConnectionString, string UserID, string FirstName, string LastName, string PhoneNo
            , string RoleID, bool IsActive, int Mode, string LoggedInUserID, string ProvinceId, string SupplierId
            , string BusinessType, string Brand);

        bool CheckEmailIDExistUser(string sqlConnectionString, string EmailID, string UserID);

        bool DeleteRecord(string sqlConnectionString, string UserID);
    }
}
