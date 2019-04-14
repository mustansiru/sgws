using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public class Expense
    {
        public long Id { get; set; }
        public long Record { get; set; }
        public string Date { get; set; }
        public long BrandId { get; set; }
        public string SupplierId { get; set; }
        public long ProgramTypeId { get; set; }
        public decimal Amount_Net { get; set; }
        public decimal Tax { get; set; }
        public decimal Total { get; set; }
        public string Month { get; set; }
        public long ProvinceId { get; set; }
        public string Vendor { get; set; }
        public string InvoiceNo { get; set; }
        public string InvoiceDescription { get; set; }
        public string RemyClassification { get; set; }
        public string Patron_GL_Account { get; set; }
        public string Grant_Applicable { get; set; }
        public string Supplier_Coding { get; set; }
        public string Bill_Back { get; set; }
        public string IsA_P { get; set; }
        public string IsStructure { get; set; }
        public string Employee { get; set; }
        public string ProgramType { get; set; }
        public string Province { get; set; }

        public string BrandName { get; set; }
        public string SupplierName { get; set; }
        public string SupplierVendorName { get; set; }
        //public string ExpenseType { get; set; }
        
    }
}
