using System;

namespace SGWSPromoPlan.DAL
{
    public class USP_Program_GetProgramSpendData
    {
        public int TotalRecords { get; set; }
        public Nullable<long> SuperProgramId { get; set; }
        public string SuperProgramName { get; set; }
        public string ProvinceCode { get; set; }
        public string Period { get; set; }
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
    }
}
