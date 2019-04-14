using SGWSPromoPlan.DAL.SQLOperation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web.Security;

namespace SGWSPromoPlan.DAL
{
    public class ManageUserRepository : IManageUserRepository
    {
        public List<UserMaster> GetUsers_By_Page(string sqlConnectionString, int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch,
             out Int64 TotalRecordCount, out Int64 TotalSearchRecords)
        {
            List<UserMaster> lstUserMaster = new List<UserMaster>();
            SQLHelper sqlHelper = new SQLHelper(sqlConnectionString);
            UserMaster oUserMaster;
            TotalRecordCount = 0;
            TotalSearchRecords = 0;

            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@iDisplayLength", SqlDbType = SqlDbType.Int, Value= iDisplayLength},
                    new SqlParameter() {ParameterName = "@iDisplayStart", SqlDbType = SqlDbType.Int, Value = iDisplayStart},
                    new SqlParameter() {ParameterName = "@iSortCol_0", SqlDbType = SqlDbType.Int, Value = iSortCol_0},
                    new SqlParameter() {ParameterName = "@sSortDir_0", SqlDbType = SqlDbType.NVarChar, Value = sSortDir_0},
                    new SqlParameter() {ParameterName = "@sSearch", SqlDbType = SqlDbType.NVarChar, Value = sSearch}
                };

            try
            {
                SqlDataReader rdr = sqlHelper.ExeReader(SQLFacade.USP_GetUsers_By_Page, CommandType.StoredProcedure, sp);

                while (rdr.Read())
                {
                    TotalRecordCount = Convert.ToInt64(rdr["TotalRecords"]);
                    TotalSearchRecords = Convert.ToInt64(rdr["TotalSearchRecords"]);
                    oUserMaster = new UserMaster();
                    oUserMaster.FirstName = Convert.ToString(rdr["FirstName"]);
                    oUserMaster.LastName = Convert.ToString(rdr["LastName"]);
                    oUserMaster.Email = Convert.ToString(rdr["Email"]);
                    oUserMaster.Role = Convert.ToString(rdr["RoleName"]);
                    oUserMaster.IsActive = string.Format("<input type=\"checkbox\" " + (Convert.ToBoolean(rdr["IsApproved"]) ? "checked='checked'" : string.Empty)) + ">";
                    oUserMaster.Action = string.Format("<a href=\"{0}\"><i class=\"fa fa-pencil\" ></i></a>&nbsp;|&nbsp;<a id=\"adelete{1}\" href=\"javascript:void(0);\" onclick=\"return Delete('{1}','adelete{1}');\"><i class=\"fa fa-trash-o\" ></i></a>", string.Format("user.aspx?ID={0}", Convert.ToString(rdr["UserID"])), Convert.ToString(rdr["UserID"]));
                    lstUserMaster.Add(oUserMaster);
                }
                rdr = null;
                return lstUserMaster;
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                lstUserMaster = null;
                oUserMaster = null;
                sqlHelper = null;
            }
        }

        public DataTable GetUser(string sqlConnectionString, string UserID)
        {
            List<UserMaster> lstUserMaster = new List<UserMaster>();
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value= UserID}
                };
            DataTable dt = new DataTable();

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.GetUser, dt, CommandType.StoredProcedure, sp);
                return dt;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetUser ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                lstUserMaster = null;
                sp = null;
                dt = null;
            }
        }

        public DataTable GetRoles(string sqlConnectionString, string UserID)
        {
            List<UserMaster> lstUserMaster = new List<UserMaster>();
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value= UserID}
                };
            DataTable dt = new DataTable();

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.USP_GetRoles, dt, CommandType.StoredProcedure, sp);
                return dt;

            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetRoles ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sp = null;
                sqlHelper = null;
                lstUserMaster = null;
                dt = null;
            }
        }

        public DataSet ValidateUser(string sqlConnectionString, string UserName, string Password)
        {
            List<UserMaster> lstUserMaster = new List<UserMaster>();
            SQLHelper sqlHelper;
            DataSet ds = new DataSet();

            List<SqlParameter> sp = new List<SqlParameter>()
                        {
                            new SqlParameter() {ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value= UserName}
                        };

            try
            {
                if (Membership.ValidateUser(UserName, Password))
                {
                    sqlHelper = new SQLHelper(sqlConnectionString);

                    sqlHelper.GetDataSet(SQLFacade.VerifyUserLogin, ds, CommandType.StoredProcedure, sp);
                    return ds;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ValidateUser ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sp = null;
                sqlHelper = null;
                lstUserMaster = null;
                ds = null;
            }
        }

        public int AddEditUser(string sqlConnectionString, string UserID, string FirstName, string LastName, string PhoneNo,
            string RoleID, bool IsActive, int Mode, string LoggedInUserID, string ProvinceId, string SupplierId
            , string BusinessType, string Brand)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value= UserID},
                    new SqlParameter() {ParameterName = "@FirstName", SqlDbType = SqlDbType.NVarChar, Value = FirstName},
                    new SqlParameter() {ParameterName = "@LastName", SqlDbType = SqlDbType.NVarChar, Value = LastName},
                    new SqlParameter() {ParameterName = "@PhoneNo", SqlDbType = SqlDbType.NVarChar, Value = PhoneNo},
                    new SqlParameter() {ParameterName = "@IsActive", SqlDbType = SqlDbType.Bit, Value = IsActive},
                    new SqlParameter() {ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = Mode},
                    new SqlParameter() {ParameterName = "@LoggedInUserID", SqlDbType = SqlDbType.NVarChar, Value = LoggedInUserID},
                    new SqlParameter() {ParameterName = "@RoleID", SqlDbType = SqlDbType.NVarChar, Value = RoleID},
                    new SqlParameter() {ParameterName = "@ProvinceId", SqlDbType = SqlDbType.NVarChar, Value = ProvinceId},
                    new SqlParameter() {ParameterName = "@SupplierId", SqlDbType = SqlDbType.NVarChar, Value = SupplierId },
                    new SqlParameter() {ParameterName = "@BusinessType", SqlDbType = SqlDbType.NVarChar, Value = BusinessType},
                    new SqlParameter() {ParameterName = "@Brand", SqlDbType = SqlDbType.NVarChar, Value = Brand}
                };

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                return sqlHelper.ExeNonQuery(SQLFacade.AddEditUser, CommandType.StoredProcedure, sp);
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("AddEditUser ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return 0;
            }
        }

        public bool CheckEmailIDExistUser(string sqlConnectionString, string EmailID, string UserID)
        {
            string result = null;
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value= UserID},
                    new SqlParameter() {ParameterName = "@EmailID", SqlDbType = SqlDbType.NVarChar, Value = EmailID}
                };

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                result = sqlHelper.ExeScalar(SQLFacade.CheckEmailIDExistUser, CommandType.StoredProcedure, sp);

                if (result != null)
                {
                    return Convert.ToInt32(result) > 0 ? true : false;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("CheckEmailIDExistUser ==> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return true;
            }

        }

        public bool DeleteRecord(string sqlConnectionString, string UserID)
        {
            string result = null;
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@UserId", SqlDbType = SqlDbType.NVarChar, Value= UserID}
                };

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                result = sqlHelper.ExeScalar(SQLFacade.USP_Delete_Record, CommandType.StoredProcedure, sp);

                if (result != null)
                {
                    return Convert.ToInt32(result) > 0 ? true : false;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("DeleteRecord ==> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return true;
            }

        }
    }
}
