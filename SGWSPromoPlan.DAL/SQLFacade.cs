namespace SGWSPromoPlan.DAL
{
    public static class SQLFacade
    {
        public static string USP_GetUsers_By_Page = "USP_GetUsers_By_Page";
        public static string GetUser = "USP_GetUser";
        public static string USP_GetRoles = "USP_GetRoles";
        public static string VerifyUserLogin = "VerifyUserLogin";
        public static string AddEditUser = "AddEditUser";
        public static string CheckEmailIDExistUser = "CheckEmailIDExistUser";
        public static string USP_Delete_Record = "USP_Delete_Record";
        public static string InsertMasterSkuListData = "InsertMasterSkuListData";
        public static string USP_Program_AddEdit = "InsertUpdateProgram";
        public static string InsertUpdateSuperProgram = "InsertUpdateSuperProgram";
        public static string USP_Program_GetData = "USP_Program_GetData";
        public static string USP_Program_GetProgramSpendData = "USP_Program_GetProgramSpendData";
        public static string GetProgramDropdowns = "GetProgramDropdowns";
        public static string GetProgramPopupDropdowns = "GetProgramPopupDropdowns";
        public static string GetLiquorBoardPeriod = "GetLiquorBoardPeriod";
        public static string GetStart_EndDate_ByLiquorBoardPeriod = "GetStart_EndDate_ByLiquorBoardPeriod";
        public static string GetProgramDetailsBySuperProgramId = "GetProgramDetailsBySuperProgramId";
        public static string GetProgramDetailsByProgramId = "GetProgramDetailsByProgramId";
        public static string GetGID = "GetGID";
        public static string GetProductDetailsBy_GID_Province = "GetProductDetailsBy_GID_Province";
        public static string GetBAMCostByProvince = "GetBAMCostByProvince";
        public static string USP_Program_GetData_Detail = "USP_Program_GetData_Detail";
        public static string USP_Chart_GetProductCountByCategory = "USP_Chart_GetProductCountByCategory";
        public static string USA_Chart_GetTop10Suppliers = "USA_Chart_GetTop10Suppliers";
        public static string USP_Reports_GetRegionalViewByBrand = "USP_Reports_GetRegionalViewByBrand";
        public static string USP_Reports_GetRegionalViewByBrand_Periods = "USP_Reports_GetRegionalViewByBrand_Periods";
        public static string USP_GetRegionalViewDropdowns = "USP_GetRegionalViewDropdowns";
        
        public static string GetProgramCostFieldsByType = "GetProgramCostFieldsByType";
        public static string CopyProgram = "CopyProgram";
        public static string CopySuperProgram = "CopySuperProgram";
        public static string GetBAMCostAndProductByProgram = "GetBAMCostAndProductByProgram";
        public static string InsertExpenseData = "InsertExpenseData";
        public static string GetSGWSFiscalYear = "GetSGWSFiscalYear";
        public static string USP_GetUsersDropdowns = "USP_GetUsersDropdowns";

        public static string GetBrand_Products_BySupplier = "GetBrand_Products_BySupplier";
        public static string GetProducts_BySupplier_Brand = "GetProducts_BySupplier_Brand";
        public static string GetProductDetailsByGID = "GetProductDetailsByGID";

        public static string GetAllocatedExpenses = "GetAllocatedExpenses";
        public static string AllocateExpense = "AllocateExpense";
        public static string DeAllocateExpense = "DeAllocateExpense";
        public static string GetImportExpenseDropdown = "GetImportExpenseDropdown";
        public static string USP_Reports_RegionalView_UpdateProgramStaus = "USP_Reports_RegionalView_UpdateProgramStaus";
        public static string USP_Program_InsertProgramData = "USP_Program_InsertProgramData";
        public static string DeleteProgram = "DeleteProgram";

        public static string GetCalendarView = "GetCalendarView";

        public static string GetSummaryRollup = "GetSummaryRollup";

        public static string GetCostBreakupByProgramType = "GetCostBreakupByProgramType";
    }
}
