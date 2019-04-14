namespace SGWSPromoPlan.DAL
{
    public partial class TMP_ProgramImport
    {
        public long Id { get; set; }
        public string ProvinceCode { get; set; }
        public string SGWS_Calendar_Year { get; set; }
        public string SGWS_Calendar_Period { get; set; }
        public string Liquor_Board_Period { get; set; }
        public string Start_Date { get; set; }
        public string End_Date { get; set; }
        public string GID { get; set; }
        public string Is_SKU_Brand { get; set; }
        public string CSPC { get; set; }
        public string ProgramType { get; set; }
        public string Comments { get; set; }
        public string ATL_BTL { get; set; }
        public string Program_Status { get; set; }
        public string Depth { get; set; }
        public string ForecastCaseSalesBase { get; set; }
        public string ForecastCaseSalesLift { get; set; }
        public string ForecastTotalCaseSalesPhysCs { get; set; }
        public string ForecastTotalCaseSales9LCsConverted { get; set; }
        public string VariableCostPerCase { get; set; }
        public string UpforntFees_LTO_BAM { get; set; }
        public string RedemptionBAM { get; set; }
        public string SpendQuantity { get; set; }
        public string SpendPerQuantity { get; set; }
        public string OtherFixedCost { get; set; }
        public string TotalProgramSpend { get; set; }
        public string Actual_Spend { get; set; }
        public string Actual_Volume { get; set; }
        public string UniqueID { get; set; }
    }

}
