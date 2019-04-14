namespace SGWSPromoPlan.DAL
{
    public class Chart_GetProductCountByCategory
    {
        public string Category { get; set; }
        public int Total { get; set; }
    }

    public class Chart_GetTop10Suppliers
    {
        public string SupplierName { get; set; }
        public int Total { get; set; }
    }
}
