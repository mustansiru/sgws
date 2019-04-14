using SGWSPromoPlan.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for SessionFacade
/// </summary>
public static class SessionFacade
{
    private const string objUserID = "LoggedInUser";
    private const string RegionalViewDetailsData = "RegionalViewDetailsData";
    private const string RegionalProgramStatusList = "RegionalProgramStatusList";
    private const string RegionalSupplierBrandList = "RegionalSupplierBrandList";
    private const string RegionalViewFiltersList = "RegionalViewFiltersList";
    private const string SearchFilterEntity = "SearchFilter";

    public static UserMaster LoggedInUser
    {
        get
        {
            if (HttpContext.Current.Session[objUserID] == null)
                return null;
            else
                return (UserMaster)HttpContext.Current.Session[objUserID];
        }
        set { HttpContext.Current.Session[objUserID] = value; }
    }

    public static string LoggedInUser_Province
    {
        get
        {
            if (HttpContext.Current.Session["LoggedInUser_Province"] != null)
                return Convert.ToString(HttpContext.Current.Session["LoggedInUser_Province"]);
            else
                return null;
        }
        set { HttpContext.Current.Session["LoggedInUser_Province"] = value; }
    }

    public static List<USP_Reports_GetRegionalViewByBrand> RegionalViewDetailsDataList
    {
        get
        {
            if (HttpContext.Current.Session[RegionalViewDetailsData] == null)
                return null;
            else
                return (List<USP_Reports_GetRegionalViewByBrand>)HttpContext.Current.Session[RegionalViewDetailsData];
        }
        set { HttpContext.Current.Session[RegionalViewDetailsData] = value; }
    }

    public static List<ProgramStatus> RegionalProgramStatusData
    {
        get
        {
            if (HttpContext.Current.Session[RegionalProgramStatusList] == null)
                return null;
            else
                return (List<ProgramStatus>)HttpContext.Current.Session[RegionalProgramStatusList];
        }
        set { HttpContext.Current.Session[RegionalProgramStatusList] = value; }
    }

    public static List<SupplierBrand> RegionalSupplierBrandData
    {
        get
        {
            if (HttpContext.Current.Session[RegionalSupplierBrandList] == null)
                return null;
            else
                return (List<SupplierBrand>)HttpContext.Current.Session[RegionalSupplierBrandList];
        }
        set { HttpContext.Current.Session[RegionalSupplierBrandList] = value; }
    }

    public static RegionalViewFilterSelection RegionalViewFilters
    {
        get
        {
            if (HttpContext.Current.Session[RegionalViewFiltersList] == null)
                return null;
            else
                return (RegionalViewFilterSelection)HttpContext.Current.Session[RegionalViewFiltersList];
        }
        set { HttpContext.Current.Session[RegionalViewFiltersList] = value; }
    }

    public static SearchFilter Criteria
    {
        get
        {
            return HttpContext.Current.Session[SearchFilterEntity] == null
                ? null
                : (SearchFilter) HttpContext.Current.Session[SearchFilterEntity];
        }
        set { HttpContext.Current.Session[SearchFilterEntity] = value; }
    }

    public class SearchFilter
    {
        public int PageSize { get; set; }
        public string SearchString { get; set; }
        public int Order { get; set; }
        public string OrderDirection { get; set; }
        public int StartRecord { get; set; }
    }

    public class RegionalViewFilterSelection
    {
        public string SGWS_Period { get; set; }
        public string SGWS_Period_DDL { get; set; }
        public string Liquor_Board_Period { get; set; }
        public string Province { get; set; }
        public string Category { get; set; }
        public string Supplier { get; set; }
        public string Brand { get; set; }
        public string Supplier_Period { get; set; }
    }
}