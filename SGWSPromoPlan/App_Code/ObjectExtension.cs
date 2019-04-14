using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ObjectExtension
/// </summary>
public static class ObjectExtension
{
    public static string CellValueToString(this object val)
    {
        string finalVal = string.Empty;
        try
        {
            finalVal = Convert.ToString(val);
        }
        catch
        {
            //ignore value
        }
        return finalVal;
    }
    public static int CellValueToInt(this object val)
    {
        int finalVal = 0;
        try
        {
            finalVal = Convert.ToInt32(val.ToString().Replace("%",""));
        }
        catch
        {
            //ignore value
        }
        return finalVal;
    }
    public static decimal CellValueToDecimal(this object val)
    {
        decimal finalVal = 0;
        try
        {
            finalVal = Convert.ToDecimal(val.ToString().Replace("%", "").Replace("\"","").Replace("gr","").Replace("grams","").Replace("lbs",""));
        }
        catch
        {
            //ignore value
        }
        return finalVal;
    }

    public static string ParseCellValueToString(this object val)
    {
        
        try
        {
            return Convert.ToString(val);
        }
        catch
        {
            return string.Empty;
        }
        
    }
}