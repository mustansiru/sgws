using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL.Entities
{
    public class USP_Reports_GetRegionalViewByBrand_Periods
    {
        public int TotalRecords { get; set; }
        public string SGWS_Calendar_Period { get; set; }
        public string LiquorBoardPeriod { get; set; }
        public Nullable<decimal> TotalProgramSpend { get; set; }
        public string ProgramStatusCode { get; set; }
        public bool IsAccess { get; set; }
        public string No_Data { get; set; }
        public string Custom_SGWS_Calendar_Period { get; set; }
        public string Custom_SGWS_Period_Or_Liquor_Period { get; set; }
    }
}
