using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using SGWSPromoPlan.BAL;
using System.Globalization;

/// <summary>
/// Summary description for SGWS
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class SGWS : System.Web.Services.WebService
{

    public SGWS()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetLiquorBoardPeriod(int sgwsYear, string sgwsPeriod, long ProvinceId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataTable dt = ManageProgramBAL.GetLiquorBoardPeriod(AppStaticData.ConnectionString, sgwsYear, sgwsPeriod, ProvinceId);

        string josnString = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
        
        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(josnString);
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetStart_EndDate_ByLiquorBoardPeriod(long Id, string Period)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataTable dt = ManageProgramBAL.GetStart_EndDate_ByLiquorBoardPeriod(AppStaticData.ConnectionString, Id, Period);

        string josnString = Newtonsoft.Json.JsonConvert.SerializeObject(dt);

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(josnString);
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetGID(long Brand, string SGID, string SupplierCode, long ProvinceId,string ProductName)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataTable dt = ManageProgramBAL.GetGID(AppStaticData.ConnectionString, Brand, SGID, SupplierCode, ProvinceId,ProductName);

        string josnString = Newtonsoft.Json.JsonConvert.SerializeObject(dt);

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(josnString);
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetBAMCostByProvince(long ProvinceId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        decimal cost = ManageProgramBAL.GetBAMCostByProvince(AppStaticData.ConnectionString,  ProvinceId);

        string josnString = Newtonsoft.Json.JsonConvert.SerializeObject(cost);

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(josnString);
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetBAMCostAndProductByProgram(long ProgramId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataSet ds = ManageProgramBAL.GetBAMCostAndProductByProgram(AppStaticData.ConnectionString, ProgramId);
        ; string resultBAMcost = "[]",resultProductInfo="[]";
        if (ds != null && ds.Tables.Count > 0)
        {
            if(ds.Tables[0] != null)
                resultBAMcost = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
            if (ds.Tables[1] != null)
                resultProductInfo = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);
        }
        //string josnString = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
        var result = new
        {
            BAMcost = resultBAMcost,
            ProductInfo= resultProductInfo
        };
        string josnString = Newtonsoft.Json.JsonConvert.SerializeObject(result);

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(josnString);
        Context.Response.Flush();
        Context.Response.End();
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void AddEditProgram(long ProgramId, long SuperProgramId, long ProgramCostId,
            long ProgramTypeId, string ProgramTypeName, string Comment, int ProgramStatusId, int ATL_BTL, decimal Depth,
            decimal ForecastCaseSalesBase, decimal ForecastCaseSalesLift, decimal ForecastTotalCaseSalesPhysCs,
            decimal ForecastTotalCaseSales9LCsConverted, decimal VariableCostPerCase, decimal UpforntFees_LTO_BAM,
            decimal RedemptionBAM, decimal SpendQuantity, decimal SpendPerQuantity, decimal OtherFixedCost,decimal TotalProgramSpend)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataSet ds = ManageProgramBAL.AddEdit(AppStaticData.ConnectionString, ProgramId, SuperProgramId, ProgramCostId, 
              ProgramTypeId,HttpUtility.UrlDecode(ProgramTypeName), HttpUtility.UrlDecode(Comment), ProgramStatusId, ATL_BTL, Depth, ForecastCaseSalesBase,
              ForecastCaseSalesLift, ForecastTotalCaseSalesPhysCs, ForecastTotalCaseSales9LCsConverted, VariableCostPerCase
            , UpforntFees_LTO_BAM, RedemptionBAM, SpendQuantity, SpendPerQuantity, OtherFixedCost, TotalProgramSpend);

        string resultPrograms = "[]";
        if (ds != null && ds.Tables.Count > 0)
        {
            resultPrograms = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        }
        //string josnString = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
        var result = new
        {
            Programs = resultPrograms
        };
        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void AddEditSuperProgram(long SuperProgramId, long ProvinceId,
         int BusinessTypeId, string SuperProgramName, int SGWSFiscalYear, string SGWSFiscalPeriod, DateTime StartDate, DateTime EndDate,
         long FiscalYearByLiquorBoardId, string GID, bool IsSkuBased, bool IsBrandBased,bool IsOverrideDate)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataSet ds = ManageProgramBAL.AddEditSuperProgram(AppStaticData.ConnectionString, SuperProgramId, ProvinceId, BusinessTypeId,
              HttpUtility.UrlDecode(SuperProgramName), SGWSFiscalYear, SGWSFiscalPeriod, StartDate, EndDate, FiscalYearByLiquorBoardId, GID,IsSkuBased, 
              IsBrandBased, IsOverrideDate);

        string josnString = Newtonsoft.Json.JsonConvert.SerializeObject(ds);

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(josnString);
        Context.Response.Flush();
        Context.Response.End();
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void AddEditSuperProgramAndProgram(long ProvinceId,int BusinessTypeId, string SuperProgramName, int SGWSFiscalYear, 
        string SGWSFiscalPeriod, string StartDate, string EndDate,long FiscalYearByLiquorBoardId, string GID, bool IsSkuBased, 
        bool IsBrandBased,long ProgramTypeId, string ProgramTypeName, string Comment, int ProgramStatusId, int ATL_BTL, decimal Depth,
        decimal ForecastCaseSalesBase, decimal ForecastCaseSalesLift, decimal ForecastTotalCaseSalesPhysCs,
        decimal ForecastTotalCaseSales9LCsConverted, decimal VariableCostPerCase, decimal UpforntFees_LTO_BAM, decimal RedemptionBAM,
        decimal SpendQuantity, decimal SpendPerQuantity, decimal OtherFixedCost,decimal TotalProgramSpend,bool IsOverrideDate)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        DateTime _StartDate = DateTime.ParseExact(StartDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
        DateTime _EndDate = DateTime.ParseExact(EndDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);

        DataSet dsSuperProgram = ManageProgramBAL.AddEditSuperProgram(AppStaticData.ConnectionString, 0, ProvinceId, BusinessTypeId,
        HttpUtility.UrlDecode(SuperProgramName), SGWSFiscalYear, SGWSFiscalPeriod, _StartDate, _EndDate, FiscalYearByLiquorBoardId, GID, IsSkuBased, IsBrandBased, IsOverrideDate);

        DataSet ds = new DataSet();
        string jsonString = string.Empty;
        string resultSuperProgram = "[]";
        string resultPrograms = "[]";

        if (dsSuperProgram != null && dsSuperProgram.Tables.Count>0 && dsSuperProgram.Tables[0].Rows.Count>0)
        {
            long superProgramId = Convert.ToInt64(dsSuperProgram.Tables[0].Rows[0]["SuperProgramId"]);

            resultSuperProgram = Common.DataTableToJSONWithJavaScriptSerializer(dsSuperProgram.Tables[0]);

            ds = ManageProgramBAL.AddEdit(AppStaticData.ConnectionString, 0, superProgramId, 0,
             ProgramTypeId, HttpUtility.UrlDecode(ProgramTypeName), HttpUtility.UrlDecode(Comment), ProgramStatusId, ATL_BTL, Depth, ForecastCaseSalesBase,
             ForecastCaseSalesLift, ForecastTotalCaseSalesPhysCs, ForecastTotalCaseSales9LCsConverted, VariableCostPerCase
           , UpforntFees_LTO_BAM, RedemptionBAM, SpendQuantity, SpendPerQuantity, OtherFixedCost, TotalProgramSpend);

            if(ds != null && ds.Tables.Count>0)
            {
                resultPrograms = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
            }

        }
        var result = new
        {
            SuperProgramId = resultSuperProgram,
            Programs = resultPrograms
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetProgramDetailsByProgramId(long ProgramId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataSet ds = ManageProgramBAL.GetProgramDetailsByProgramId(AppStaticData.ConnectionString, ProgramId);
        
        string resultPrograms = "[]", resultProgramsList = "[]";
        if (ds != null && ds.Tables.Count >0)
        {
            resultPrograms = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
            resultProgramsList = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);            
        }
        var result = new
        {
            ProgramDetails = resultPrograms,
            ProgramList=resultProgramsList
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetProgramCostFieldsByType(long ProgramTypeId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataTable dtProgram = ManageProgramBAL.GetProgramCostFieldsByType(AppStaticData.ConnectionString, ProgramTypeId);

        string resultProgramTypeCost = "[]";

        if (dtProgram != null && dtProgram.Rows.Count > 0)
        {
            resultProgramTypeCost = Common.DataTableToJSONWithJavaScriptSerializer(dtProgram);
        }
        var result = new
        {
            ProgramTypeCost = resultProgramTypeCost
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void CopyProgram(long ProgramId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataTable dtProgram = ManageProgramBAL.CopyProgram(AppStaticData.ConnectionString, ProgramId);

        string resultPrograms = "[]";

        if (dtProgram != null && dtProgram.Rows.Count > 0)
        {
            resultPrograms = Common.DataTableToJSONWithJavaScriptSerializer(dtProgram);
        }
        var result = new
        {
            ProgramDetails = resultPrograms
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void CopySuperProgram(long SuperProgramId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataSet ds= ManageProgramBAL.CopySuperProgram(AppStaticData.ConnectionString, SuperProgramId);

        string resultSuperPrograms = "[]", resultProgramsList = "[]";

        if (ds != null && ds.Tables.Count > 0)
        {
            resultSuperPrograms = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
            resultProgramsList = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);
        }
        var result = new
        {
            SuperProgram = resultSuperPrograms,
            ProgramsList= resultProgramsList
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetAllExpenses(long ProgramId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataSet ds = ManageProgramBAL.GetAllocatedExpenses(AppStaticData.ConnectionString, ProgramId);
        string resultProgramDetails = "[]", resultAllocateExpenses = "[]", resultNotAllocateExpenses = "[]", 
               resultTotalAllocateExpenses = "[]", resultTotalNotAllocateExpenses = "[]";
        if (ds != null && ds.Tables.Count > 0)
        {
            if (ds.Tables[0] != null)
                resultProgramDetails = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
            if (ds.Tables[1] != null)
                resultAllocateExpenses = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);
            if (ds.Tables[2] != null)
                resultNotAllocateExpenses = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[2]);
            if (ds.Tables[3] != null)
                resultTotalAllocateExpenses = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[3]);
            if (ds.Tables[4] != null)
                resultTotalNotAllocateExpenses = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[4]);
        }
        var result = new
        {
            ProgramDetails = resultProgramDetails,
            AllocateExpenses = resultAllocateExpenses,
            NotAllocateExpenses = resultNotAllocateExpenses,
            AllocatedTotalAmount = resultTotalAllocateExpenses,
            NotAllocatedTotalAmount = resultTotalNotAllocateExpenses
        };
        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void AllocateExpenses(long ExpenseId, long ProgramId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        string resultTotalAllocateExpenses = "[]", resultTotalNotAllocateExpenses = "[]";
        DataSet ds = ManageProgramBAL.AllocateExpense(AppStaticData.ConnectionString, ExpenseId,ProgramId);
        if (ds != null && ds.Tables.Count > 0)
        {
            if (ds.Tables[0] != null)
                resultTotalAllocateExpenses = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
            if (ds.Tables[1] != null)
                resultTotalNotAllocateExpenses = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);
        }
        var result = new
        {
            AllocatedTotalAmount = resultTotalAllocateExpenses,
            NotAllocatedTotalAmount = resultTotalNotAllocateExpenses
        };
        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void DeAllocateExpense(long ExpenseId, long ProgramId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        
        DataSet ds = ManageProgramBAL.DeAllocateExpense(AppStaticData.ConnectionString, ExpenseId, ProgramId);
        string resultTotalAllocateExpenses = "[]", resultTotalNotAllocateExpenses = "[]";
        if (ds != null && ds.Tables.Count > 0)
        {
            if (ds.Tables[0] != null)
                resultTotalAllocateExpenses = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
            if (ds.Tables[1] != null)
                resultTotalNotAllocateExpenses = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);
        }
        var result = new
        {
            AllocatedTotalAmount = resultTotalAllocateExpenses,
            NotAllocatedTotalAmount = resultTotalNotAllocateExpenses
        };
        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetBrand_Products_BySupplier(long SupplierId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataSet ds = MasterSKUListBAL.GetBrand_Products_BySupplier(AppStaticData.ConnectionString, SupplierId);

        string resultPrograms = "[]", resultBrands = "[]";

        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            if(ds.Tables[0] != null)
                resultBrands = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
            if(ds.Tables[1] != null)
                resultPrograms = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);
        }
        var result = new
        {
            Brands= resultBrands,
            Programs = resultPrograms
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetProducts_BySupplier_Brand(long SupplierId,long BrandId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataTable dt = MasterSKUListBAL.GetProducts_BySupplier_Brand(AppStaticData.ConnectionString, SupplierId, BrandId);

        string resultPrograms = "[]";

        if (dt != null  && dt.Rows.Count > 0)
        {
            resultPrograms = Common.DataTableToJSONWithJavaScriptSerializer(dt);
        }
        var result = new
        {
            Programs = resultPrograms
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetProductDetailsByGID(string GID)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataTable dt = MasterSKUListBAL.GetProductDetailsByGID(AppStaticData.ConnectionString, GID);

        string resultProductDetails = "[]";

        if (dt != null && dt.Rows.Count > 0)
        {
            resultProductDetails = Common.DataTableToJSONWithJavaScriptSerializer(dt);
        }
        var result = new
        {
            ProductDetails = resultProductDetails
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void GetProgramDetailsBySuperProgramId(long SuperProgramId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataSet ds = ManageProgramBAL.GetProgramDetailsBySuperProgramId(AppStaticData.ConnectionString, SuperProgramId);

        string resultSuperProgram = "[]", resultProgramsList = "[]";
            //, BusinessType = "[]", Province = "[]", SGWSFiscalYear = "[]", SGWSFiscalPeriod = "[]",
            //   ProgramSKU_BrandBased = "[]", Brands = "[]", Suppliers = "[]", Products = "[]";

        if (ds != null && ds.Tables.Count>0)
        {
            if(ds.Tables[0] != null)
                resultSuperProgram = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
            if (ds.Tables[1] != null)
                resultProgramsList = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);
            //if (ds.Tables[1] != null)
            //    BusinessType = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[1]);
            //if (ds.Tables[2] != null)
            //    Province = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[2]);
            //if (ds.Tables[3] != null)
            //    SGWSFiscalYear = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[3]);
            //if (ds.Tables[4] != null)
            //    SGWSFiscalPeriod = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[4]);
            //if (ds.Tables[5] != null)
            //    ProgramSKU_BrandBased = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[5]);
            //if (ds.Tables[6] != null)
            //    Brands = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[6]);
            //if (ds.Tables[7] != null)
            //    Suppliers = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[7]);
            //if (ds.Tables[8] != null)
            //    Products = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[8]);
        }
        var result = new
        {
            ProgramDetails = resultSuperProgram,
            ProgramsList = resultProgramsList
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void DeleteProgram(long ProgramId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        DataSet ds = ManageProgramBAL.DeleteProgram(AppStaticData.ConnectionString, ProgramId);

        string  resultProgramsList = "[]";
        if (ds != null && ds.Tables.Count > 0)
        {
            if (ds.Tables[0] != null)
                resultProgramsList = Common.DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        }
        var result = new
        {
            ProgramList = resultProgramsList
        };

        Context.Response.Clear();
        Context.Response.ContentType = "application/json";
        Context.Response.Write(serializer.Serialize(result));
        Context.Response.Flush();
        Context.Response.End();
    }


}
