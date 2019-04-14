using SGWSPromoPlan.DA;
using SGWSPromoPlan.DAL.SQLOperation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SGWSPromoPlan.DAL.Entities;

namespace SGWSPromoPlan.DAL
{
    public class ManageProgramRepository : IManageProgramRepository
    {
        public DataSet AddEdit(string sqlConnectionString, long ProgramId, long SuperProgramId, long ProgramCostId,
            long ProgramTypeId, string ProgramTypeName, string Comment, int ProgramStatusId, int ATL_BTL, decimal Depth,
            decimal ForecastCaseSalesBase, decimal ForecastCaseSalesLift, decimal ForecastTotalCaseSalesPhysCs,
            decimal ForecastTotalCaseSales9LCsConverted, decimal VariableCostPerCase, decimal UpforntFees_LTO_BAM,
            decimal RedemptionBAM, decimal SpendQuantity, decimal SpendPerQuantity, decimal OtherFixedCost, decimal TotalProgramSpend)
        {
            SQLHelper sqlHelper;
            DataSet ds = new DataSet();
            #region Parameters
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value= ProgramId},
                    new SqlParameter() {ParameterName = "@SuperProgramId", SqlDbType = SqlDbType.BigInt, Value = SuperProgramId},
                    new SqlParameter() {ParameterName = "@ProgramCostId", SqlDbType = SqlDbType.BigInt, Value = ProgramCostId},
                    new SqlParameter() {ParameterName = "@ProgramTypeId", SqlDbType = SqlDbType.BigInt, Value = ProgramTypeId},
                    new SqlParameter() {ParameterName = "@ProgramTypeName", SqlDbType = SqlDbType.VarChar, Value = ProgramTypeName},
                    new SqlParameter() {ParameterName = "@Comment", SqlDbType = SqlDbType.VarChar, Value = Comment},
                    new SqlParameter() {ParameterName = "@ProgramStatusId", SqlDbType = SqlDbType.Int, Value = ProgramStatusId},
                    new SqlParameter() {ParameterName = "@ATL_BTL", SqlDbType = SqlDbType.Int, Value = ATL_BTL},
                    new SqlParameter() {ParameterName = "@Depth", SqlDbType = SqlDbType.Decimal, Value = Depth},
                    new SqlParameter() {ParameterName = "@ForecastCaseSalesBase", SqlDbType = SqlDbType.Decimal, Value = ForecastCaseSalesBase},
                    new SqlParameter() {ParameterName = "@ForecastCaseSalesLift", SqlDbType = SqlDbType.Decimal, Value = ForecastCaseSalesLift},
                    new SqlParameter() {ParameterName = "@ForecastTotalCaseSalesPhysCs", SqlDbType = SqlDbType.Decimal, Value = ForecastTotalCaseSalesPhysCs},
                    new SqlParameter() {ParameterName = "@ForecastTotalCaseSales9LCsConverted", SqlDbType = SqlDbType.Decimal, Value = ForecastTotalCaseSales9LCsConverted},
                    new SqlParameter() {ParameterName = "@VariableCostPerCase", SqlDbType = SqlDbType.Decimal, Value = VariableCostPerCase},
                    new SqlParameter() {ParameterName = "@UpforntFees_LTO_BAM", SqlDbType = SqlDbType.Decimal, Value = UpforntFees_LTO_BAM},
                    new SqlParameter() {ParameterName = "@RedemptionBAM", SqlDbType = SqlDbType.Decimal, Value = RedemptionBAM},
                    new SqlParameter() {ParameterName = "@SpendQuantity", SqlDbType = SqlDbType.Decimal, Value = SpendQuantity},
                    new SqlParameter() {ParameterName = "@SpendPerQuantity", SqlDbType = SqlDbType.Decimal, Value = SpendPerQuantity},
                    new SqlParameter() {ParameterName = "@OtherFixedCost", SqlDbType = SqlDbType.Decimal, Value = OtherFixedCost},
                    new SqlParameter() {ParameterName = "@TotalProgramSpend", SqlDbType = SqlDbType.Decimal, Value = TotalProgramSpend}
                };
            #endregion
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.USP_Program_AddEdit, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgram AddEdit ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public DataSet AddEditSuperProgram(string sqlConnectionString, long SuperProgramId, long ProvinceId,
         int BusinessTypeId, string SuperProgramName, int SGWSFiscalYear, string SGWSFiscalPeriod, DateTime StartDate, DateTime EndDate,
         long FiscalYearByLiquorBoardId, string GID, bool IsSkuBased, bool IsBrandBased, bool isOverrideDate)
        {
            SQLHelper sqlHelper;
            DataSet ds = new DataSet();
            #region Parameters
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@SuperProgramId", SqlDbType = SqlDbType.BigInt, Value = SuperProgramId},
                    new SqlParameter() {ParameterName = "@ProvinceId", SqlDbType = SqlDbType.BigInt, Value = ProvinceId},
                    new SqlParameter() {ParameterName = "@BusinessTypeId", SqlDbType = SqlDbType.Int, Value = BusinessTypeId},
                    new SqlParameter() {ParameterName = "@SuperProgramName", SqlDbType = SqlDbType.VarChar, Value = SuperProgramName},
                    new SqlParameter() {ParameterName = "@SGWSFiscalYear", SqlDbType = SqlDbType.BigInt, Value = SGWSFiscalYear},
                    new SqlParameter() {ParameterName = "@SGWSFiscalPeriod", SqlDbType = SqlDbType.VarChar, Value = SGWSFiscalPeriod},
                    new SqlParameter() {ParameterName = "@StartDate", SqlDbType = SqlDbType.DateTime, Value = StartDate},
                    new SqlParameter() {ParameterName = "@EndDate", SqlDbType = SqlDbType.DateTime, Value = EndDate},
                    new SqlParameter() {ParameterName = "@FiscalYearByLiquorBoardId", SqlDbType = SqlDbType.BigInt, Value = FiscalYearByLiquorBoardId},
                    new SqlParameter() {ParameterName = "@GID", SqlDbType = SqlDbType.VarChar, Value = GID},
                    new SqlParameter() {ParameterName = "@IsSkuBased", SqlDbType = SqlDbType.Bit, Value = IsSkuBased},
                    new SqlParameter() {ParameterName = "@IsBrandBased", SqlDbType = SqlDbType.Bit, Value = IsBrandBased},
                     new SqlParameter() {ParameterName = "@IsOverrideDate", SqlDbType = SqlDbType.Bit, Value = isOverrideDate}
                };
            #endregion
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.InsertUpdateSuperProgram, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgram AddEditSuperProgram ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }


        public List<USP_Program_GetData> GetData(string sqlConnectionString, int iDisplayLength, int iDisplayStart
                                        , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUserId)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@iDisplayLength", SqlDbType = SqlDbType.Int, Value= iDisplayLength},
                    new SqlParameter() {ParameterName = "@iDisplayStart", SqlDbType = SqlDbType.Int, Value= iDisplayStart},
                    new SqlParameter() {ParameterName = "@iSortCol_0", SqlDbType = SqlDbType.Int, Value= iSortCol_0},
                    new SqlParameter() {ParameterName = "@sSortDir_0", SqlDbType = SqlDbType.NVarChar, Value= sSortDir_0},
                    new SqlParameter() {ParameterName = "@sSearch", SqlDbType = SqlDbType.NVarChar, Value= sSearch},
                    new SqlParameter() {ParameterName = "@LoggedInUser", SqlDbType = SqlDbType.UniqueIdentifier, Value= loggedInUserId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<USP_Program_GetData> _list = new List<USP_Program_GetData>();
                _list = DataReaderExtention.DataReaderMapToList<USP_Program_GetData>(sqlHelper.ExeReader(SQLFacade.USP_Program_GetData, CommandType.StoredProcedure, sp));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgramRepository=> GetData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public List<USP_Program_GetProgramSpendData> GetProgramSpendData(string sqlConnectionString, int iDisplayLength, int iDisplayStart
                                        , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUser)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@iDisplayLength", SqlDbType = SqlDbType.Int, Value= iDisplayLength},
                    new SqlParameter() {ParameterName = "@iDisplayStart", SqlDbType = SqlDbType.Int, Value= iDisplayStart},
                    new SqlParameter() {ParameterName = "@iSortCol_0", SqlDbType = SqlDbType.Int, Value= iSortCol_0},
                    new SqlParameter() {ParameterName = "@sSortDir_0", SqlDbType = SqlDbType.NVarChar, Value= sSortDir_0},
                    new SqlParameter() {ParameterName = "@sSearch", SqlDbType = SqlDbType.NVarChar, Value= sSearch},
                    new SqlParameter() {ParameterName = "@LoggedInUser", SqlDbType = SqlDbType.UniqueIdentifier, Value= loggedInUser}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<USP_Program_GetProgramSpendData> _list = new List<USP_Program_GetProgramSpendData>();
                _list = DataReaderExtention.DataReaderMapToList<USP_Program_GetProgramSpendData>(sqlHelper.ExeReader(SQLFacade.USP_Program_GetProgramSpendData, CommandType.StoredProcedure, sp));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgramRepository=> GetProgramSpendData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public List<USP_Program_GetData_Detail> GetProgramDetail(string sqlConnectionString, long SuperProgramId, Guid loggedInUser)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@SuperProgramId", SqlDbType = SqlDbType.BigInt, Value= SuperProgramId},
                    new SqlParameter() {ParameterName = "@LoggedInUserId", SqlDbType = SqlDbType.UniqueIdentifier, Value= loggedInUser}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<USP_Program_GetData_Detail> _list = new List<USP_Program_GetData_Detail>();
                _list = DataReaderExtention.DataReaderMapToList<USP_Program_GetData_Detail>(sqlHelper.ExeReader(SQLFacade.USP_Program_GetData_Detail, CommandType.StoredProcedure, sp));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgramRepository=> GetProgramDetail ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }
        public DataSet GetProgramDropdowns(string sqlConnectionString)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>();
            DataSet ds = new DataSet();

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.GetProgramDropdowns, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetProgramDropdowns ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                ds = null;
            }
        }

        public DataSet GetProgramPopupDropdowns(string sqlConnectionString)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>();
            DataSet ds = new DataSet();

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.GetProgramPopupDropdowns, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetProgramPopupDropdowns ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                ds = null;
            }
        }

        public DataTable GetLiquorBoardPeriod(string sqlConnectionString, int sgwsYear, string sgwsPeriod, long ProvinceId)
        {
            SQLHelper sqlHelper;
            DataTable dt = new DataTable();

            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@year", SqlDbType = SqlDbType.Int, Value= sgwsYear},
                    new SqlParameter() {ParameterName = "@period", SqlDbType = SqlDbType.VarChar, Value= sgwsPeriod},
                    new SqlParameter() {ParameterName = "@ProvinceId", SqlDbType = SqlDbType.BigInt, Value = ProvinceId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.GetLiquorBoardPeriod, dt, CommandType.StoredProcedure, sp);
                return dt;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetLiquorBoardPeriod ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                dt = null;
            }
        }

        public DataTable GetStart_EndDate_ByLiquorBoardPeriod(string sqlConnectionString, long Id, string Period)
        {
            SQLHelper sqlHelper;
            DataTable dt = new DataTable();

            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@Id", SqlDbType = SqlDbType.BigInt, Value= Id},
                    new SqlParameter() {ParameterName = "@Period", SqlDbType = SqlDbType.VarChar, Value = Period}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.GetStart_EndDate_ByLiquorBoardPeriod, dt, CommandType.StoredProcedure, sp);
                return dt;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetStart_EndDate_ByLiquorBoardPeriod ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                dt = null;
            }
        }
        public DataTable GetGID(string sqlConnectionString, long Brand, string SGID, string SupplierCode, long ProvinceId, string ProductName)
        {
            SQLHelper sqlHelper;
            DataTable dt = new DataTable();

            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@SupplierCode", SqlDbType = SqlDbType.VarChar, Value = SupplierCode},
                    new SqlParameter() {ParameterName = "@Brand", SqlDbType = SqlDbType.BigInt, Value= Brand},
                    new SqlParameter() {ParameterName = "@SGID", SqlDbType = SqlDbType.VarChar, Value= SGID},
                    new SqlParameter() {ParameterName = "@ProductName", SqlDbType = SqlDbType.VarChar, Value = ProductName},
                    new SqlParameter() {ParameterName = "@ProvinceId", SqlDbType = SqlDbType.BigInt, Value= ProvinceId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.GetGID, dt, CommandType.StoredProcedure, sp);
                return dt;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetGID ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                dt = null;
            }
        }

        public DataSet GetProgramDetailsBySuperProgramId(string sqlConnectionString, long SuperProgramId)
        {
            SQLHelper sqlHelper;
            DataSet ds = new DataSet();

            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@SuperProgramId", SqlDbType = SqlDbType.BigInt, Value = SuperProgramId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.GetProgramDetailsBySuperProgramId, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetProgramDetailsBySuperProgramId ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                ds = null;
            }
        }

        public DataSet GetProgramDetailsByProgramId(string sqlConnectionString, long ProgramId)
        {
            SQLHelper sqlHelper;
            DataSet ds = new DataSet();

            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value = ProgramId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.GetProgramDetailsByProgramId, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetProgramDetailsByProgramId ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                ds = null;
            }
        }

        public DataTable GetProductDetailsBy_GID_Province(string sqlConnectionString, string GID, long ProvinceId)
        {
            SQLHelper sqlHelper;
            DataTable dt = new DataTable();

            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@GID", SqlDbType = SqlDbType.VarChar, Value= GID},
                    new SqlParameter() {ParameterName = "@ProvinceId", SqlDbType = SqlDbType.BigInt, Value= ProvinceId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.GetProductDetailsBy_GID_Province, dt, CommandType.StoredProcedure, sp);
                return dt;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetProductDetailsBy_GID_Province ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                dt = null;
            }
        }
        public decimal GetBAMCostByProvince(string sqlConnectionString, long ProvinceId)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ProvinceId", SqlDbType = SqlDbType.BigInt, Value= ProvinceId}
                };
            try
            {
                string result = null;
                sqlHelper = new SQLHelper(sqlConnectionString);
                result = sqlHelper.ExeScalar(SQLFacade.GetBAMCostByProvince, CommandType.StoredProcedure, sp);
                if (result != null)
                    return Convert.ToDecimal(result);
                else
                    return 0;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetBAMCostByProvince ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return 0;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
            }
        }
        public DataSet GetBAMCostAndProductByProgram(string sqlConnectionString, long ProgramId)
        {
            DataSet ds = new DataSet();
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value= ProgramId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.GetBAMCostAndProductByProgram, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetBAMCostAndProductByProgram ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                ds = null;
            }
        }

        public List<USP_Reports_GetRegionalViewByBrand> GetRegionalViewByBrandData(string sqlConnectionString, int iDisplayLength, int iDisplayStart
                                        , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUser)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@iDisplayLength", SqlDbType = SqlDbType.Int, Value= iDisplayLength},
                    new SqlParameter() {ParameterName = "@iDisplayStart", SqlDbType = SqlDbType.Int, Value= iDisplayStart},
                    new SqlParameter() {ParameterName = "@iSortCol_0", SqlDbType = SqlDbType.Int, Value= iSortCol_0},
                    new SqlParameter() {ParameterName = "@sSortDir_0", SqlDbType = SqlDbType.NVarChar, Value= sSortDir_0},
                    new SqlParameter() {ParameterName = "@sSearch", SqlDbType = SqlDbType.NVarChar, Value= sSearch},
                    new SqlParameter() {ParameterName = "@LoggedInUser", SqlDbType = SqlDbType.UniqueIdentifier, Value= loggedInUser}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<USP_Reports_GetRegionalViewByBrand> _list = new List<USP_Reports_GetRegionalViewByBrand>();
                _list = DataReaderExtention.DataReaderMapToList<USP_Reports_GetRegionalViewByBrand>(sqlHelper.ExeReader(SQLFacade.USP_Reports_GetRegionalViewByBrand, CommandType.StoredProcedure, sp));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgramRepository=> GetRegionalViewByBrandData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public List<USP_Reports_GetRegionalViewByBrand_Periods> GetRegionalViewByBrandData_Periods(string sqlConnectionString, int iDisplayLength, int iDisplayStart
            , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUser)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
            {
                new SqlParameter() {ParameterName = "@iDisplayLength", SqlDbType = SqlDbType.Int, Value= iDisplayLength},
                new SqlParameter() {ParameterName = "@iDisplayStart", SqlDbType = SqlDbType.Int, Value= iDisplayStart},
                new SqlParameter() {ParameterName = "@iSortCol_0", SqlDbType = SqlDbType.Int, Value= iSortCol_0},
                new SqlParameter() {ParameterName = "@sSortDir_0", SqlDbType = SqlDbType.NVarChar, Value= sSortDir_0},
                new SqlParameter() {ParameterName = "@sSearch", SqlDbType = SqlDbType.NVarChar, Value= sSearch},
                new SqlParameter() {ParameterName = "@LoggedInUser", SqlDbType = SqlDbType.UniqueIdentifier, Value= loggedInUser}
            };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<USP_Reports_GetRegionalViewByBrand_Periods> _list = new List<USP_Reports_GetRegionalViewByBrand_Periods>();
                _list = DataReaderExtention.DataReaderMapToList<USP_Reports_GetRegionalViewByBrand_Periods>(sqlHelper.ExeReader(SQLFacade.USP_Reports_GetRegionalViewByBrand_Periods, CommandType.StoredProcedure, sp));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgramRepository=> GetRegionalViewByBrandData ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public DataSet GetRegionalViewDropdowns(string sqlConnectionString)
        {
            SQLHelper sqlHelper;

            DataSet ds = new DataSet();

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.USP_GetRegionalViewDropdowns, ds, CommandType.StoredProcedure, null);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgramRepository => GetRegionalViewDropdowns ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                ds = null;
            }
        }

        public DataTable GetProgramCostFieldsByType(string sqlConnectionString, long ProgramTypeId)
        {
            SQLHelper sqlHelper;
            DataTable dt = new DataTable();

            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ProgramTypeId", SqlDbType = SqlDbType.VarChar, Value= ProgramTypeId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.GetProgramCostFieldsByType, dt, CommandType.StoredProcedure, sp);
                return dt;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetProgramCostFieldsByType ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                dt = null;
            }
        }


        public DataTable CopyProgram(string sqlConnectionString, long ProgramId)
        {
            SQLHelper sqlHelper;
            DataTable dt = new DataTable();
            #region Parameters
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value= ProgramId}
                };
            #endregion
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.CopyProgram, dt, CommandType.StoredProcedure, sp);
                return dt;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("CopyProgram ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public DataSet CopySuperProgram(string sqlConnectionString, long SuperProgramId)
        {
            SQLHelper sqlHelper;
            DataSet ds = new DataSet();
            #region Parameters
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@SuperProgramId", SqlDbType = SqlDbType.BigInt, Value= SuperProgramId}
                };
            #endregion
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.CopySuperProgram, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("CopySuperProgram ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public DataTable GetSGWSFiscalYear(string sqlConnectionString)
        {
            SQLHelper sqlHelper;
            DataTable dt = new DataTable();
            //List<SqlParameter> sp = new List<SqlParameter>();
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataTable(SQLFacade.GetSGWSFiscalYear, dt, CommandType.StoredProcedure, null);
                return dt;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("GetSGWSFiscalYear ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                dt = null;
            }
        }

        public DataSet GetAllocatedExpenses(string sqlConnectionString, long ProgramId)
        {
            DataSet ds = new DataSet();
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value= ProgramId}
                };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.GetAllocatedExpenses, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                log.WriteLog("GetAllocatedExpenses ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                sp = null;
                ds = null;
            }
        }

        public DataSet AllocateExpenses(string sqlConnectionString, long ExpenseId, long ProgramId)
        {
            SQLHelper sqlHelper;
            DataSet ds = new DataSet();

            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ExpenseId", SqlDbType = SqlDbType.BigInt, Value= ExpenseId},
                    new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value = ProgramId}
                };

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.AllocateExpense, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                log.WriteLog("AllocateExpense ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                ds = null;
            }
        }

        public DataSet DeAllocateExpense(string sqlConnectionString, long ExpenseId, long ProgramId)
        {
            DataSet ds = new DataSet();
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ExpenseId", SqlDbType = SqlDbType.BigInt, Value= ExpenseId},
                    new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value = ProgramId}
                };

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.DeAllocateExpense,ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                log.WriteLog("DeAllocateExpense ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                ds = null;
            }
        }

        public DataSet GetUsersDropdowns(string sqlConnectionString)
        {
            SQLHelper sqlHelper;

            DataSet ds = new DataSet();

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.USP_GetUsersDropdowns, ds, CommandType.StoredProcedure, null);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgramRepository => GetUsersDropdowns ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
            finally
            {
                sqlHelper = null;
                ds = null;
            }
        }


        public int UpdateProgramStatus(string sqlConnectionString, long ProgramId, int PrgoramStatusId)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value= ProgramId},
                    new SqlParameter() {ParameterName = "@ProgramStatusId", SqlDbType = SqlDbType.Int, Value = PrgoramStatusId}
                };

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                return sqlHelper.ExeNonQuery(SQLFacade.USP_Reports_RegionalView_UpdateProgramStaus, CommandType.StoredProcedure, sp);
            }
            catch (Exception ex)
            {
                log.WriteLog("UpdateProgramStatus ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return 0;
            }

        }

        public List<SQLErrorInfo> InsertProgramData(string sqlConnectionString, string jsonStr, string FileName, Guid UserId)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@json", SqlDbType = SqlDbType.NVarChar, Value= jsonStr},
                    new SqlParameter() {ParameterName = "@FileName", SqlDbType = SqlDbType.NVarChar, Value= FileName},
                    new SqlParameter() {ParameterName = "@UserId", SqlDbType = SqlDbType.UniqueIdentifier, Value= UserId}

                };

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);

                List<SQLErrorInfo> _list = new List<SQLErrorInfo>();
                _list = DataReaderExtention.DataReaderMapToList<SQLErrorInfo>(sqlHelper.ExeReader(SQLFacade.USP_Program_InsertProgramData, CommandType.StoredProcedure, sp));
                //return sqlHelper.ExeNonQuery(SQLFacade.InsertMasterSkuListData, CommandType.StoredProcedure, sp);
                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgramRepository => InsertProgramData ==> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public List<GetSummaryRollup> GetSummaryRollup(string sqlConnectionString, int iDisplayLength, int iDisplayStart
            , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUserId)
        {
            SQLHelper sqlHelper;
            List<SqlParameter> sp = new List<SqlParameter>()
            {
                new SqlParameter() {ParameterName = "@iDisplayLength", SqlDbType = SqlDbType.Int, Value= iDisplayLength},
                new SqlParameter() {ParameterName = "@iDisplayStart", SqlDbType = SqlDbType.Int, Value= iDisplayStart},
                new SqlParameter() {ParameterName = "@iSortCol_0", SqlDbType = SqlDbType.Int, Value= iSortCol_0},
                new SqlParameter() {ParameterName = "@sSortDir_0", SqlDbType = SqlDbType.NVarChar, Value= sSortDir_0},
                new SqlParameter() {ParameterName = "@sSearch", SqlDbType = SqlDbType.NVarChar, Value= sSearch},
                new SqlParameter() {ParameterName = "@LoggedInUser", SqlDbType = SqlDbType.UniqueIdentifier, Value= loggedInUserId}
            };
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<GetSummaryRollup> _list = new List<GetSummaryRollup>();
                _list = DataReaderExtention.DataReaderMapToList<GetSummaryRollup>(sqlHelper.ExeReader(SQLFacade.GetSummaryRollup, CommandType.StoredProcedure, sp));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgramRepository=> GetSummaryRollup ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }


        public DataSet DeleteProgram(string sqlConnectionString, long ProgramId)
        {
            SQLHelper sqlHelper;
            DataSet ds = new DataSet();
            #region Parameters
            List<SqlParameter> sp = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value= ProgramId},
                };
            #endregion
            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.DeleteProgram, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ManageProgram DeleteProgram ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }

        public DataSet GetCostBreakupByProgramType(string sqlConnectionString, string ProgramId)
        {
            SQLHelper sqlHelper;
            DataSet ds = new DataSet();
            #region Parameters
            List<SqlParameter> sp = new List<SqlParameter>()
            {
                new SqlParameter() {ParameterName = "@ProgramId", SqlDbType = SqlDbType.BigInt, Value= ProgramId},
            };
            #endregion

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                sqlHelper.GetDataSet(SQLFacade.GetCostBreakupByProgramType, ds, CommandType.StoredProcedure, sp);
                return ds;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("RegionalViewByBrand ==> GetCostBreakupByProgramType ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }
    }
}
