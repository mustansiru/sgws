using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.BAL
{
    public static class ManageUserBAL
    {
        public static List<UserMaster> GetUsers_By_Page(string sqlConnectionString, int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch,
         out Int64 TotalRecordCount, out Int64 TotalSearchRecords)
        {
            IManageUserRepository manageUsers = new ManageUserRepository();
            return manageUsers.GetUsers_By_Page(sqlConnectionString, iDisplayLength, iDisplayStart, iSortCol_0, sSortDir_0, sSearch, out TotalRecordCount, out TotalSearchRecords);
        }

        public static DataTable GetUser(string sqlConnectionString, string UserID)
        {
            IManageUserRepository manageUsers = new ManageUserRepository();
            return manageUsers.GetUser(sqlConnectionString, UserID);
        }

        public static DataTable GetRoles(string sqlConnectionString, string UserID)
        {
            IManageUserRepository manageUsers = new ManageUserRepository();
            return manageUsers.GetRoles(sqlConnectionString, UserID);
        }

        public static DataSet ValidateUser(string sqlConnectionString, string UserName, string Password)
        {
            IManageUserRepository manageUsers = new ManageUserRepository();
            return manageUsers.ValidateUser(sqlConnectionString, UserName, Password);
        }

        public static int AddEditUser(string sqlConnectionString, string UserID, string FirstName, string LastName, string PhoneNo,
            string RoleID, bool IsActive, int Mode, string LoggedInUserID, string ProvinceId, string SupplierId
            , string BusinessType, string Brand)
        {
            IManageUserRepository manageUsers = new ManageUserRepository();
            return manageUsers.AddEditUser(sqlConnectionString, UserID, FirstName, LastName, PhoneNo, RoleID
                , IsActive, Mode, LoggedInUserID,ProvinceId, SupplierId, BusinessType,Brand);
        }

        public static bool CheckEmailIDExistUser(string sqlConnectionString, string EmailID, string UserID)
        {
            IManageUserRepository manageUsers = new ManageUserRepository();
            return manageUsers.CheckEmailIDExistUser(sqlConnectionString, EmailID, UserID);
        }

        public static bool DeleteRecord(string sqlConnectionString, string UserID)
        {
            IManageUserRepository manageUsers = new ManageUserRepository();
            return manageUsers.DeleteRecord(sqlConnectionString, UserID);
        }

    }
}
