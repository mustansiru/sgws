using System;

namespace SGWSPromoPlan.DAL
{
    public class USP_Reports_GetRegionalViewByBrand
    {
        public int TotalRecords { get; set; }
        public Nullable<long> SuperProgramId { get; set; }
        public string SuperProgramName { get; set; }
        public string ProvinceCode { get; set; }
        
        public string SGWS_Calendar_Period { get; set; }
        public Nullable<int> SGWS_Calendar_Year { get; set; }
        public string LiquorBoardPeriod { get; set; }
        public Nullable<System.DateTime> StartDate { get; set; }
        public Nullable<System.DateTime> EndDate { get; set; }
        public bool IsSkuBased { get; set; }
        public string GID { get; set; }
        public string AlternateName { get; set; }
        public long ProgramId { get; set; }
        public string ProgramTypeName { get; set; }
        public string ProgramType { get; set; }
        public string AboveTheLineBelowTheLineName { get; set; }
        public string Comment { get; set; }
        public string ProgramStatusCode { get; set; }
        public Nullable<decimal> TotalProgramSpend { get; set; }
        public Nullable<int> ContainerVolume { get; set; }
        public Nullable<int> Containers_Selling_Unit { get; set; }
        public Nullable<int> Selling_Units_Case { get; set; }
        public bool IsAccess { get; set; }
        public string No_Data { get; set; }
        public string Custom_SGWS_Calendar_Period { get; set; }
        public string Custom_SGWS_Period_Or_Liquor_Period { get; set; }
        public Nullable<Decimal> Depth { get; set; }
        public Nullable<Decimal> ForecastCaseSalesBase { get; set; }
        public Nullable<Decimal> ForecastCaseSalesLift { get; set; }
        public Nullable<Decimal> ForecastTotalCaseSalesPhysCs { get; set; }
        public Nullable<decimal> ForecastTotalCaseSales9LCsConverted { get; set; }
        public Nullable<Decimal> VariableCostPerCase { get; set; }
        public Nullable<Decimal> UpforntFees_LTO_BAM { get; set; }
        public Nullable<Decimal> RedemptionBAM { get; set; }
        public Nullable<Decimal> SpendQuantity { get; set; }
        public Nullable<Decimal> SpendPerQuantity { get; set; }
        public Nullable<Decimal> OtherFixedCost { get; set; }
    }
}
