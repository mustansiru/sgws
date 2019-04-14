using System.Collections.Generic;
using System.Data;
using System;
using SGWSPromoPlan.DAL.Entities;

namespace SGWSPromoPlan.DAL
{
    public interface IManageProgramRepository
    {
        DataSet AddEdit(string sqlConnectionString, long ProgramId, long SuperProgramId, long ProgramCostId,
            long ProgramTypeId, string ProgramTypeName, string Comment, int ProgramStatusId, int ATL_BTL, decimal Depth,
         decimal ForecastCaseSalesBase, decimal ForecastCaseSalesLift, decimal ForecastTotalCaseSalesPhysCs,
        decimal ForecastTotalCaseSales9LCsConverted, decimal VariableCostPerCase, decimal UpforntFees_LTO_BAM,
        decimal RedemptionBAM, decimal SpendQuantity, decimal SpendPerQuantity, decimal OtherFixedCost,decimal TotalProgramSpend);

        DataSet AddEditSuperProgram(string sqlConnectionString, long SuperProgramId, long ProvinceId,
        int BusinessTypeId, string SuperProgramName, int SGWSFiscalYear, string SGWSFiscalPeriod, DateTime StartDate, DateTime EndDate,
        long FiscalYearByLiquorBoardId, string GID, bool IsSkuBased, bool IsBrandBased,bool isOverrideDate);

        List<USP_Program_GetData> GetData(string sqlConnectionString, int iDisplayLength, int iDisplayStart
                                        , int iSortCol_0, string sSortDir_0, string sSearch,Guid loggedInUserId);

        List<USP_Program_GetProgramSpendData> GetProgramSpendData(string sqlConnectionString, int iDisplayLength, int iDisplayStart
                                        , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUser);

        List<USP_Program_GetData_Detail> GetProgramDetail(string sqlConnectionString, long SuperProgramId, Guid loggedInUser);

        DataTable GetLiquorBoardPeriod(string sqlConnectionString, int sgwsYear, string sgwsPeriod, long ProvinceId);

        DataSet GetProgramDropdowns(string sqlConnectionString);

        DataSet GetProgramPopupDropdowns(string sqlConnectionString);

        DataTable GetStart_EndDate_ByLiquorBoardPeriod(string sqlConnectionString, long Id, string Period);

        DataSet GetProgramDetailsBySuperProgramId(string sqlConnectionString, long SuperProgramId);
        DataTable GetGID(string sqlConnectionString, long Brand, string SGID, string SupplierCode,long ProvinceId,string ProductName);
        DataSet GetProgramDetailsByProgramId(string sqlConnectionString, long ProgramId);

        DataTable GetProductDetailsBy_GID_Province(string sqlConnectionString, string GID, long ProvinceId);
        decimal GetBAMCostByProvince(string sqlConnectionString, long ProvinceId);

        List<USP_Reports_GetRegionalViewByBrand> GetRegionalViewByBrandData(string sqlConnectionString, int iDisplayLength, int iDisplayStart
                                        , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUser);

        List<USP_Reports_GetRegionalViewByBrand_Periods> GetRegionalViewByBrandData_Periods(string sqlConnectionString, int iDisplayLength, int iDisplayStart
            , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUser);

        DataSet GetRegionalViewDropdowns(string sqlConnectionString);

        DataTable GetProgramCostFieldsByType(string sqlConnectionString, long ProgramTypeId);

        DataTable CopyProgram(string sqlConnectionString, long ProgramId);

        DataSet CopySuperProgram(string sqlConnectionString, long SuperProgramId);

        DataSet GetBAMCostAndProductByProgram(string sqlConnectionString, long ProgramId);

        DataTable GetSGWSFiscalYear(string sqlConnectionString);

        DataSet GetAllocatedExpenses(string sqlConnectionString, long ProgramId);

        DataSet AllocateExpenses(string sqlConnectionString, long ExpenseId, long ProgramId);

        DataSet DeAllocateExpense(string sqlConnectionString, long ExpenseId, long ProgramId);
        
        DataSet GetUsersDropdowns(string sqlConnectionString);
        int UpdateProgramStatus(string sqlConnectionString, long ProgramId, int PrgoramStatusId);

        List<SQLErrorInfo> InsertProgramData(string sqlConnectionString, string jsonStr, string FileName, Guid UserId);
        List<GetSummaryRollup> GetSummaryRollup(string sqlConnectionString, int iDisplayLength, int iDisplayStart
            , int iSortCol_0, string sSortDir_0, string sSearch, Guid loggedInUserId);

        DataSet DeleteProgram(string sqlConnectionString, long ProgramId);

        DataSet GetCostBreakupByProgramType(string sqlConnectionString, string ProgramId);
    }
}
