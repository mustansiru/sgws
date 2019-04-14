using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public class SGWS_Program
    {
        public long Id { get; set; }
        public string ProgramName { get; set; }
        public string Comment { get; set; }
        public Nullable<long> SuperProgramId { get; set; }
        public Nullable<int> AboveTheLineBelowTheLine { get; set; }
        public Nullable<int> ProgramStatusId { get; set; }
        public Nullable<long> ProgramTypeId { get; set; }

        public string AboveTheLineBelowTheLineName { get; set; }
        public string ProgramStatusCode { get; set; }
        public string ProgramType { get; set; }
    }

    public partial class USP_Program_GetData
    {
        //public long ProgramId { get; set; }
        //public string ProgramTypeName { get; set; }
        public int TotalRecords { get; set; }
        public string SuperProgramName { get; set; }
        public string ProvinceCode { get; set; }
        public string Period { get; set; }
        //public string ProgramStatusCode { get; set; }
        public string GID { get; set; }
        public string AlternateName { get; set; }
        //public string AboveTheLineBelowTheLineName { get; set; }
        //public string ProgramType { get; set; }
        //public string Comment { get; set; }
        public Nullable<System.DateTime> StartDate { get; set; }
        public Nullable<System.DateTime> EndDate { get; set; }
        public Nullable<bool> IsSkuBased { get; set; }

        public string SGWS_Calendar_Period { get; set; }
        public Nullable<int> SGWS_Calendar_Year { get; set; }
        public string LiquorBoardPeriod { get; set; }
        public Nullable<long> SuperProgramId { get; set; }
        public bool IsAccess { get; set; }
        //public Nullable<int> Program_ATL_BTL_Id { get; set; }
        //public Nullable<long> ProgramStatusId { get; set; }
    }

    public class USP_Program_GetData_Detail
    {
        public long ProgramId { get; set; }
        public string ProgramTypeName { get; set; }
        public string ProgramStatusCode { get; set; }
        public string ProgramType { get; set; }
        public string AboveTheLineBelowTheLineName { get; set; }
        public string Comment { get; set; }
        public bool IsAccess { get; set; }
        //public Nullable<int> ATL_BTL_Id { get; set; }
        //public Nullable<int> ProgramStatusId { get; set; }
    }
}
