using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using SGWSPromoPlan.DAL.Entities;

namespace SGWSPromoPlan.BAL
{
    public static class ManageProgramBAL
    {
        private static IManageProgramRepository _repository;

        public static IManageProgramRepository Repository => _repository ?? (_repository = new ManageProgramRepository());

        public static System.Data.DataSet AddEdit(string sqlConnectionString, long ProgramId, long SuperProgramId, long ProgramCostId,
             long ProgramTypeId, string ProgramTypeName, string Comment, int ProgramStatusId, int ATL_BTL, decimal Depth,
          decimal ForecastCaseSalesBase, decimal ForecastCaseSalesLift, decimal ForecastTotalCaseSalesPhysCs,
         decimal ForecastTotalCaseSales9LCsConverted, decimal VariableCostPerCase, decimal UpforntFees_LTO_BAM,
         decimal RedemptionBAM, decimal SpendQuantity, decimal SpendPerQuantity, decimal OtherFixedCost, decimal TotalProgramSpend)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.AddEdit(sqlConnectionString, ProgramId, SuperProgramId, ProgramCostId,
                ProgramTypeId, ProgramTypeName, Comment, ProgramStatusId, ATL_BTL, Depth, ForecastCaseSalesBase,
              ForecastCaseSalesLift, ForecastTotalCaseSalesPhysCs, ForecastTotalCaseSales9LCsConverted, VariableCostPerCase
            , UpforntFees_LTO_BAM, RedemptionBAM, SpendQuantity, SpendPerQuantity, OtherFixedCost, TotalProgramSpend);
        }

        public static System.Data.DataSet AddEditSuperProgram(string sqlConnectionString, long SuperProgramId, long ProvinceId,
         int BusinessTypeId, string SuperProgramName, int SGWSFiscalYear, string SGWSFiscalPeriod, DateTime StartDate, DateTime EndDate,
         long FiscalYearByLiquorBoardId, string GID, bool IsSkuBased, bool IsBrandBased,bool isOverrideDate)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.AddEditSuperProgram(sqlConnectionString, SuperProgramId, ProvinceId,
                          BusinessTypeId, SuperProgramName, SGWSFiscalYear, SGWSFiscalPeriod, StartDate, EndDate,
                          FiscalYearByLiquorBoardId, GID, IsSkuBased, IsBrandBased, isOverrideDate);
        }

        public static List<USP_Program_GetData> GetData(string sqlConnectionString, int iDisplayLength, int iDisplayStart
                                        , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUserId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetData(sqlConnectionString, iDisplayLength, iDisplayStart, iSortCol_0
                , sSortDir_0, sSearch, loggedInUserId);
        }

        public static List<USP_Program_GetProgramSpendData> GetProgramSpendData(string sqlConnectionString, int iDisplayLength, int iDisplayStart
                                       , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUser)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetProgramSpendData(sqlConnectionString, iDisplayLength, iDisplayStart, iSortCol_0, sSortDir_0, sSearch, loggedInUser);
        }

        public static List<USP_Program_GetData_Detail> GetProgramDetail(string sqlConnectionString, long SuperProgramId, Guid loggedInUser)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetProgramDetail(sqlConnectionString, SuperProgramId, loggedInUser);
        }
        public static System.Data.DataSet GetProgramDropdowns(string sqlConnectionString)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetProgramDropdowns(sqlConnectionString);
        }

        public static System.Data.DataSet GetProgramPopupDropdowns(string sqlConnectionString)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetProgramPopupDropdowns(sqlConnectionString);
        }
        public static DataTable GetLiquorBoardPeriod(string sqlConnectionString, int sgwsYear, string sgwsPeriod, long ProvinceId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetLiquorBoardPeriod(sqlConnectionString, sgwsYear, sgwsPeriod, ProvinceId);
        }

        public static DataTable GetStart_EndDate_ByLiquorBoardPeriod(string sqlConnectionString, long Id, string Period)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetStart_EndDate_ByLiquorBoardPeriod(sqlConnectionString, Id, Period);
        }

        public static System.Data.DataSet GetProgramDetailsBySuperProgramId(string sqlConnectionString, long SuperProgramId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetProgramDetailsBySuperProgramId(sqlConnectionString, SuperProgramId);
        }
        public static DataSet GetProgramDetailsByProgramId(string sqlConnectionString, long ProgramId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetProgramDetailsByProgramId(sqlConnectionString, ProgramId);
        }
        public static DataTable GetGID(string sqlConnectionString, long Brand, string SGID, string SupplierCode, long ProvinceId, string ProductName)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetGID(sqlConnectionString, Brand, SGID, SupplierCode, ProvinceId, ProductName);
        }

        public static DataTable GetProductDetailsBy_GID_Province(string sqlConnectionString, string GID, long ProvinceId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetProductDetailsBy_GID_Province(sqlConnectionString, GID, ProvinceId);
        }

        public static decimal GetBAMCostByProvince(string sqlConnectionString, long ProvinceId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetBAMCostByProvince(sqlConnectionString, ProvinceId);
        }

        public static List<USP_Reports_GetRegionalViewByBrand> GetRegionalViewByBrandData(string sqlConnectionString, int iDisplayLength, int iDisplayStart
                                       , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUser)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetRegionalViewByBrandData(sqlConnectionString, iDisplayLength, iDisplayStart, iSortCol_0, sSortDir_0, sSearch, loggedInUser);
        }

        public static List<USP_Reports_GetRegionalViewByBrand_Periods> GetRegionalViewByBrandData_Periods(
            string sqlConnectionString, int iDisplayLength, int iDisplayStart
            , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUser)
        {
            return Repository.GetRegionalViewByBrandData_Periods(sqlConnectionString, iDisplayLength,
                iDisplayStart, iSortCol_0, sSortDir_0, sSearch, loggedInUser);
        }

        public static System.Data.DataSet GetRegionalViewDropdowns(string sqlConnectionString)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetRegionalViewDropdowns(sqlConnectionString);
        }

        public static DataTable GetProgramCostFieldsByType(string sqlConnectionString, long ProgramTypeId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetProgramCostFieldsByType(sqlConnectionString, ProgramTypeId);
        }

        public static DataTable CopyProgram(string sqlConnectionString, long ProgramId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.CopyProgram(sqlConnectionString, ProgramId);
        }

        public static DataSet CopySuperProgram(string sqlConnectionString, long SuperProgramId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.CopySuperProgram(sqlConnectionString, SuperProgramId);
        }

        public static System.Data.DataSet GetBAMCostAndProductByProgram(string sqlConnectionString, long ProgramId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetBAMCostAndProductByProgram(sqlConnectionString, ProgramId);
        }

        public static DataTable GetSGWSFiscalYear(string sqlConnectionString)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetSGWSFiscalYear(sqlConnectionString);
        }

        public static System.Data.DataSet GetAllocatedExpenses(string sqlConnectionString, long ProgramId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetAllocatedExpenses(sqlConnectionString, ProgramId);
        }

        public static DataSet AllocateExpense(string sqlConnectionString, long ExpenseId, long ProgramId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.AllocateExpenses(sqlConnectionString, ExpenseId, ProgramId);
        }

        public static DataSet DeAllocateExpense(string sqlConnectionString, long ExpenseId, long ProgramId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.DeAllocateExpense(sqlConnectionString, ExpenseId, ProgramId);
        }
        
        public static System.Data.DataSet GetUsersDropdowns(string sqlConnectionString)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.GetUsersDropdowns(sqlConnectionString);
        }

        public static int UpdateProgramStatus(string sqlConnectionString, long ProgramId, int PrgoramStatusId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.UpdateProgramStatus(sqlConnectionString, ProgramId, PrgoramStatusId);
        }

        public static List<SQLErrorInfo> InsertProgramData(string sqlConnectionString, string jsonStr, string FileName, Guid UserId)
        {
            IManageProgramRepository _IManageProgramRepository = new ManageProgramRepository();
            return _IManageProgramRepository.InsertProgramData(sqlConnectionString, jsonStr, FileName, UserId);
        }

        public static List<GetSummaryRollup> GetSummaryRollup(string sqlConnectionString, int iDisplayLength, int iDisplayStart
            , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUserId)
        {
            return Repository.GetSummaryRollup(sqlConnectionString, iDisplayLength,
                iDisplayStart, iSortCol_0, sSortDir_0, sSearch, loggedInUserId);
        }

        public static DataSet DeleteProgram(string sqlConnectionString, long ProgramId)
        {
            return Repository.DeleteProgram(sqlConnectionString, ProgramId);
        }

        public static DataSet GetCostBreakupByProgramType(string sqlConnectionString, string ProgramId)
        {
            return Repository.GetCostBreakupByProgramType(sqlConnectionString, ProgramId);
        }
    }
}
