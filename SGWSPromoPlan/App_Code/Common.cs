using System;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Globalization;
using Newtonsoft.Json;

/// <summary>
/// Summary description for Common
/// </summary>
public class Common
{
    public Common()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    //public static double SupplyPressureConversionFactor = 6.89476;

    //public static string DefaultReport = "Default";
    //public static string UploadPaths_CompanyMainPhoto = "~/uploads/equipment/";
    //public static string UploadPaths_CompanyThumbPhoto = "~/uploads/equipment/thumb/";
    //public static int ElectricityConsumptionTemplateId = 27;
    //public const int FugitiveEmissionId = 4;

    //public static string CustomEPITable_CH4 = "ch4";
    //public static string CustomEPITable_CO2 = "co2";
    //public static string CustomEPITable_CO2e = "co2e";
    //public static string CustomEPITable_N2O = "n2o";
    //public static string CustomEPITable_NOx = "nox";
    //public static string CustomEPITable_SO2 = "so2";
    //public static string CustomEPITable_VOC = "voc";


    //public static int GasDriven_Pneumatic_Controller = 9;
    //public static int Internal_Combustion_Engine = 1;
    //public static int Internal_Combustion_Engine_Diesel = 2;
    //public static int Scrubber = 65;
    //public static int Flare_Knockout_Drum = 66;
    //public static int Meter_Measured = 35;
    //public static int General_Fuel_Combustion = 54;
    //public static int General_Vent = 53;
    //public static int Mobile_Drilling_Completion = 58;
    //public static int Mobile_Workover_Equipment = 68;
    //public static int Mobile_Completion_Equipment = 67;
    //public static int Produced_Condensate_Tank = 15;
    //public static int AcidGasRemovalUnit = 20;
    //public static int Produced_Oil_Tank = 22;
    //public static int Produced_Water_Tank = 23;
    //public static int Produced_Emulsion_Tank = 36;
    //public static int Surface_Casing_Vent_Flow = 48;
    //public static int GasDriven_Pneumatic_Pump = 10;
    //public static int Flare_Sweet = 11;
    //public static int Flare_Acid = 56;
    //public static int Well_Test_Flare = 57;
    //public static int Incinerator = 30;
    //public static int Flare_Pilot = 64;
    //public static int Separator = 44;
    //public static int Header = 32;
    //public static int Wellhead = 50;
    //public static int Pipeline = 13;
    //public static int Company_Vehicle = 25;
    //public static int Onshore_Oil_Production = 59;
    //public static int Onshore_Gas_Production = 61;
    //public static int TankCarLoadingCondensate = 62;
    //public static int TankCarLoadingFracOil = 63;
    //public static int ElectricityConsumption = 27;
    //public static int CatalyticHeater_Natgas = 7;
    //public static int CatalyticHeater_Propane = 8;
    //public static int Pressure_Relief_Valve = 17;
    //public static int Dehydrators = 12;
    //public static int Compressor_Centrifugal = 14;
    //public static int Compressor_Reciprocating = 42;
    //public static int Compressor_Screw = 43;
    //public static int GeneratorNatGas = 31;

    //public static int BoilerNaturalGas = 21;
    //public static int FWKONaturalGas = 6;
    //public static int GeneratorDiesel = 60;
    //public static int GlycolReboilerNaturalGas = 5;
    //public static int HeaterNaturalGas = 4;
    //public static int PumpjackEngineNaturalGas = 3;
    //public static int PumpjackEnginePropane = 16;
    //public static int SteamGeneratorNaturalGas = 45;
    //public static int SCVF = 48;
    //public static int SweetGasFlare = 11;
    //public static int TreaterNaturalGas = 49;


    //public static string AllowedFuelTypes = "1,2";

    //public static int BleedRateReference_PrasinoGroup = 1;
    //public static int BleedRateReference_ClientSpecific = 4;


    //#region Event Template IDs"

    //public static int COMPRESSOR_BLOWDOWN = 70;
    //public static int NON_ROUTINE_RELEASE = 18;
    //public static int PIPE_BLOWDOWN_NPS = 71;
    //public static int PIPE_BLOWDOWN_SPEC = 72;
    //public static int PRESSURE_RELIEF_VALVES_RELEASE = 69;
    //public static int VESSEL_BLOWDOWN = 74;
    //public static int WELL_BLOWDOWN = 73;
    //public static int COMPRESSOR_START = 75;
    //public static int PACKAGE_BLOWDOWN = 76;

    //#endregion Event Template IDs"

    public enum ProgramType
    {
        RetailCorporatePrograms = 1,
        RetailSAQDepot = 2,
        RetailLTO = 4,
        RetailBonusAirMiles = 5,

    }
    public enum ProgramSKU_BrandBased
    {
        SKUSpecific = 1,
        BrandFamily = 2
    }

    public enum ProgramStatus
    {
        APPROVED_CLOSED = 1,
        APPROVED_OPEN = 2,
        PLANNED = 3,
        SUBMITTED = 4,
        REJECTED_BOARD = 5,
        REJECTED_STRATEGY = 6
    }
    //public enum TemplateType
    //{
    //    Compressor = 1,
    //    PressureReliefValue = 2,
    //    VesselBlowdown = 3,
    //    WellHead = 4,
    //}

    //public enum ReportingCategory
    //{
    //    FugitiveEmissionsEstimate = 13,
    //    ProductionVenting = 12
    //}
    //public enum CalculationMethodology
    //{
    //    API = 1,
    //    CAPP_WCI = 2
    //}
    //public enum PneumaticEquipmentType
    //{
    //    Emergency_Response_Device = 1,
    //    Flow_Rate_Controller = 2,
    //    Liquid_Level_Controller = 3,
    //    Positioner = 4,
    //    Temperature_Controller = 5,
    //    Transducer = 6,
    //    Pressure_Controller = 7,
    //    Actuator = 8
    //}

    //public enum FFV
    //{
    //    Fuel = 1, Flare = 2, Vent = 3
    //}
    //public enum YesNo
    //{
    //    Yes = 1, No = 2
    //}
    //public enum FuelTypeID
    //{
    //    NaturalGasMarketable = 1,
    //    NaturalGasNonMarketable = 2,
    //    Gasoline = 3,
    //    Diesel = 4,
    //    Propane = 5
    //}

    //public enum DestinationID
    //{
    //    Flare = 1,
    //    Incinerator = 2,
    //    Vent = 3,
    //    Recycle_Recompression = 4,
    //}

    //public enum ReportingCategoryID
    //{
    //    FuelCombusted = 1,
    //    FuelVented = 2,
    //    Flare = 3,
    //    FugitiveEmissionsSurvey = 5,
    //    CompressorVenting = 6,
    //    DehydratorVenting = 7,
    //    IndirectEmissions = 8,
    //    MakeUpGas = 9,
    //    MobileCombustion = 10,
    //    NonReportable = 11,
    //    ProductionVenting = 12,
    //    EstimatedFugitiveEmission = 13,
    //    NonRoutineVenting = 14,
    //    Diesel = 15,
    //    Propane = 16,
    //    Gasoline = 17,
    //    FugitiveEmissionsScreening = 18,
    //}

    //public enum FlashingLossVentEstimationMethodologyID
    //{
    //    VasquezBeggsEquation = 1,
    //    GISFactor = 2
    //}

    //public enum DehydratorVentingEstimationMethodologyID
    //{
    //    CAPP = 1,
    //    GriGlyCalc = 2
    //}

    public static string SetCurrentUrl()
    {
        string[] urlparams = HttpContext.Current.Request.Url.AbsoluteUri.Split('&');
        string returnUrl = string.Empty;
        for (int paramIndex = 0; paramIndex < urlparams.Count(); paramIndex++)
        {
            if (!urlparams[paramIndex].Contains("returnurl"))
            {
                if (string.IsNullOrEmpty(returnUrl))
                {
                    returnUrl += urlparams[paramIndex];
                }
                else
                {
                    returnUrl += "&" + urlparams[paramIndex];
                }
            }
        }
        return returnUrl;
    }

    public static void GetCookie_StartDate_and_EndDate(out DateTime startDate, out DateTime endDate)
    {
        startDate = DateTime.Now;
        endDate = DateTime.Now;
        HttpCookie aCookie = HttpContext.Current.Request.Cookies["selectedmonths"];
        string[] lang;
        if (aCookie != null)
        {
            lang = HttpContext.Current.Server.UrlDecode(aCookie.Value).Split('|');
            if (lang.Count() == 2)
            {
                startDate = DateTime.Parse(new string(lang[0].Take(24).ToArray()));
                endDate = DateTime.Parse(new string(lang[1].Take(24).ToArray()));
            }
        }
        else
        {
            DateTime now = DateTime.Now;
            startDate = new DateTime(now.Year, now.Month, 1);
            endDate = startDate.AddMonths(1).AddDays(-1);
        }
    }

    public static string[] ChartColors = new string[] {
      "#9CB071", "#FDD017", "#3090C7", "#566D7E",
    "#728FCE","#4E9258","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",
    "#FDD017","#4C4646", "#98AFC7", "#566D7E", "#3090C7",
    "#728FCE","#4E9258", "#9CB071","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",
    "#FDD017","#4C4646", "#98AFC7", "#566D7E", "#3090C7",
    "#728FCE","#4E9258", "#9CB071","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",
    "#FDD017","#4C4646", "#98AFC7", "#566D7E", "#3090C7",
    "#728FCE","#4E9258", "#9CB071","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",
    "#FDD017","#4C4646", "#98AFC7", "#566D7E", "#3090C7",
    "#728FCE","#4E9258", "#9CB071","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",
    "#FDD017","#4C4646", "#98AFC7", "#566D7E", "#3090C7",
    "#728FCE","#4E9258", "#9CB071","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",
    "#FDD017","#4C4646", "#98AFC7", "#566D7E", "#3090C7",
    "#728FCE","#4E9258", "#9CB071","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",
    "#FDD017","#4C4646", "#98AFC7", "#566D7E", "#3090C7",
    "#728FCE","#4E9258", "#9CB071","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",
    "#FDD017","#4C4646", "#98AFC7", "#566D7E", "#3090C7",
    "#728FCE","#4E9258", "#9CB071","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",
    "#FDD017","#4C4646", "#98AFC7", "#566D7E", "#3090C7",
    "#728FCE","#4E9258", "#9CB071","#EDDA74","#FAEBD7",
    "#FFCBA4","#954535","#8D38C9","#A74AC7","#342D7E",
    "#2B60DE","#966F33","#810541","#C25A7C","#FBBBB9",
    "#EDC9AF","#FF7F50","#F2D7D5","#A2D9CE","#D7BDE2",
    "#7F8C8D","#EB984E","#2980B9","#F7DC6F","#CA6F1E",
    "#839192","#85929E","#D5D8DC","#D4E6F1","#EC7063",
    "#F9E79F","#FCF3CF","#FAD7A0","#F5CBA7","#FAE5D3",
    "#82E0AA","#D4E6F1","#F5EEF8","#73C6B6","#52BE80",
    "#B2BABB","#FBEEE6","#F4D03F","#B7950B","#7B7D7D",};


    public static string DataTableToJSONWithJavaScriptSerializer(DataTable table)
    {
        return JsonConvert.SerializeObject(table, Formatting.Indented);
    }

    public static string FormatNumberValue(decimal number)
    {
        return number.ToString("N", new CultureInfo("en-US"));
    }

    public static string FormatNumberValue(decimal number, int precision)
    {
        return Convert.ToString(Math.Round(number, precision));
    }

    public static string FormatCurrency(decimal number, int precision)
    {
        return Math.Round(number, precision).ToString("N", new CultureInfo("en-US"));
    }

    public static string FormatNumberValue(float number)
    {
        return number.ToString("N", new CultureInfo("en-US"));
    }

    public static string FormatNumberValue(Double number)
    {
        return number.ToString("N", new CultureInfo("en-US"));
    }

    public static string Regain_Special_Chars(string data)
    {
        return data.Replace("%23", "#");
    }
}

public static class Messages
{
    public static string ErrorMessage = "<div class=\"alert alert-danger\">{0}</div>";
    public static string SuccessMessage = "<div class=\"alert alert-success\">{0}</div>";
}

public static class AdminUrls
{
    public static string Home = "~/dashboard.aspx";
    public static string Login = "~/login.aspx";
    public static string Logout = "~/logout.aspx";

    public static string Manage_Program = "~/ManageProgram.aspx";
    public static string Program_List = "~/program-list.aspx";
    public static string Update_Program = "~/UpdateProgram.aspx";
    public static string Program_Planning = "~/ProgramPlanning.aspx";
    public static string Set_Program_Threshold = "~/SetProgramThreshold.aspx";
    public static string Program = "~/program.aspx";
    public static string Edit_SuperProgram = "~/program.aspx?spid={0}";
    public static string ImportExpenseData = "~/ExpenseData.aspx";


    public static string Allocate_Expenses = "~/AllocateExpenses.aspx";
    public static string Allocate_Expenses1 = "~/AllocateExpenses1.aspx";
    public static string Deallocate_Expenses = "~/DeallocateExpenses.aspx";

    public static string Calendar_View = "~/CalendarView.aspx";
    public static string Regional_View = "~/RegionalView2.aspx";
    public static string Actual_Spend = "~/ActualSpend.aspx";

    public static string Master_SKU_List = "~/MasterSKUList.aspx";
    public static string Import_Vol_Data = "~/VolumeData.aspx";
    public static string Import_Expense_Data = "~/ExpenseData.aspx";
    public static string Import_Program_Data = "~/ImportProgram.aspx";
    public static string Import_FiscalYear_Data = "~/FiscalYearData.aspx";
    public static string Manage_User = "~/manage-user.aspx";
    public static string Manage_Roles = "~/ManageRoles.aspx";



    public static string Add_User = "~/user.aspx";
    public static string Edit_User = "~/user.aspx?id={0}";

    public static string Manage_User_RecordAdded_OR_Edited = "~/manage-user.aspx?mode={0}&success={1}";

    public static string Profile = "~/profile.aspx";
    public static string ChangePassword = "~/change-password.aspx";
    public static string ForgotPassword = "~/forgot-password.aspx";

    public static string Dashboard = "~/dashboard.aspx";
}

public static class PageTitles
{
    public static string Home = "Dashboard";
    public static string Login = "Login";
    public static string Logout = "Logout";
    public static string ManageSKUs = "Manage SKUs";
    public static string ChangePassword = "Change Password";
    public static string ForgotPassword = "Forgot Password";

    public static string ManageUsers = "Manage Users";
    public static string AddUser = "Add User";
    public static string EditUser = "Edit User";


    public static string ShowNotifications = "Notifications";

    public static string CalendarView = "Calendar View";
}

public static class AdminPageTitles
{
    public static string MasterSKUList = "Master SKU List";
    public static string Dashboard = "Dashboard";

    public static string ManageProgram = "Manage Program";
    public static string ProgramList = "Program List";
    public static string AddProgram = "Add Program";
    public static string UpdateProgram = "Update Program";
    public static string ProgramPlanning = "Program Planning";
    public static string RegionalView = "Regional View By Brand";
    public static string ImportExpenseData = "Import Expense Data";
    public static string ImportProgramData = "Import Program Data";
    public static string AllocateExpenses = "Allocate Expenses";


    public static string Home = "Home";
    public static string Login = "Login";
    public static string Logout = "Logout";

    public static string ManageUsers = "Manage User";
    public static string AddUser = "Add User";
    public static string EditUser = "Edit User";

    public static string EditProfile = "Edit Profile";
    public static string ChangePassword = "Change Password";
    public static string ForgotPassword = "Forgot Password";

    public static string VolumeData = "Volume Data";

}

public static class EncryptDecrypt
{
    const string passphrase = "J_n3G#$@126aWk&";

    public static string encrypt(string message)
    {
        byte[] results;
        UTF8Encoding utf8 = new UTF8Encoding();
        //to create the object for UTF8Encoding  class
        //TO create the object for MD5CryptoServiceProvider 
        MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
        byte[] deskey = md5.ComputeHash(utf8.GetBytes(passphrase));
        //to convert to binary passkey
        //TO create the object for  TripleDESCryptoServiceProvider 
        TripleDESCryptoServiceProvider desalg = new TripleDESCryptoServiceProvider();
        desalg.Key = deskey;//to  pass encode key
        desalg.Mode = CipherMode.ECB;
        desalg.Padding = PaddingMode.PKCS7;
        byte[] encrypt_data = utf8.GetBytes(message);
        //to convert the string to utf encoding binary 

        try
        {
            //To transform the utf binary code to md5 encrypt    
            ICryptoTransform encryptor = desalg.CreateEncryptor();
            results = encryptor.TransformFinalBlock(encrypt_data, 0, encrypt_data.Length);
        }
        finally
        {
            //to clear the allocated memory
            desalg.Clear();
            md5.Clear();
        }
        //to convert to 64 bit string from converted md5 algorithm binary code
        return Convert.ToBase64String(results);
    }

    public static string decrypt(string message)
    {
        byte[] results;
        UTF8Encoding utf8 = new UTF8Encoding();
        MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
        byte[] deskey = md5.ComputeHash(utf8.GetBytes(passphrase));
        TripleDESCryptoServiceProvider desalg = new TripleDESCryptoServiceProvider();
        desalg.Key = deskey;
        desalg.Mode = CipherMode.ECB;
        desalg.Padding = PaddingMode.PKCS7;
        byte[] decrypt_data = Convert.FromBase64String(message);
        try
        {
            //To transform the utf binary code to md5 decrypt
            ICryptoTransform decryptor = desalg.CreateDecryptor();
            results = decryptor.TransformFinalBlock(decrypt_data, 0, decrypt_data.Length);
        }
        finally
        {
            desalg.Clear();
            md5.Clear();

        }
        //TO convert decrypted binery code to string
        return utf8.GetString(results);
    }

}

public static class Paths
{
    public static string ForgotPassword_EmailTemplatePath = "~/emailtemplates/forgotpassword.html";
    public static string WebsiteTrial_EmailTemplatePath = "~/emailtemplates/websitetrial.html";
    public static string WebsiteTrial_Admin_EmailTemplatePath = "~/emailtemplates/websitetrial_Admin.html";
}

public static class Send_Email
{
    public static bool SendEmail(string strToEmail, string strSubject, string strBody, bool ishtml, string filename = null)
    {
        string LoginEmailID = ConfigurationManager.AppSettings["LoginEmailID"].ToString();
        string pwd = ConfigurationManager.AppSettings["pwd"].ToString();
        string Host = ConfigurationManager.AppSettings["Host"].ToString();
        int Port = Convert.ToInt32(ConfigurationManager.AppSettings["Port"].ToString());
        try
        {
            MailMessage msg = new MailMessage(new MailAddress(LoginEmailID, "Clairifi.com")
                , new MailAddress(strToEmail));

            msg.Subject = strSubject;
            msg.Body = strBody;
            msg.IsBodyHtml = true;

            if (filename != null)
            {
                msg.Attachments.Add(new Attachment(filename));
            }

            var smtp = new SmtpClient
            {
                Host = Host,
                Port = Port,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(LoginEmailID, pwd)
            };
            smtp.Send(msg);

            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }
}

//public static class ExportData
//{
//    public static byte[] ExportToCSVFileOpenXML(DataTable dt)
//    {
//        DataSet ds = new DataSet();
//        DataTable dtCopy = new DataTable();
//        dtCopy = dt.Copy();
//        ds.Tables.Add(dtCopy);
//        try
//        {
//            byte[] returnBytes = null;
//            MemoryStream mem = new MemoryStream();
//            var workbook = SpreadsheetDocument.Create(mem, DocumentFormat.OpenXml.SpreadsheetDocumentType.Workbook);
//            {
//                var workbookPart = workbook.AddWorkbookPart();
//                workbook.WorkbookPart.Workbook = new DocumentFormat.OpenXml.Spreadsheet.Workbook();
//                workbook.WorkbookPart.Workbook.Sheets = new DocumentFormat.OpenXml.Spreadsheet.Sheets();
//                foreach (System.Data.DataTable table in ds.Tables)
//                {
//                    var sheetPart = workbook.WorkbookPart.AddNewPart<WorksheetPart>();
//                    var sheetData = new DocumentFormat.OpenXml.Spreadsheet.SheetData();
//                    sheetPart.Worksheet = new DocumentFormat.OpenXml.Spreadsheet.Worksheet(sheetData);

//                    DocumentFormat.OpenXml.Spreadsheet.Sheets sheets = workbook.WorkbookPart.Workbook.GetFirstChild<DocumentFormat.OpenXml.Spreadsheet.Sheets>();
//                    string relationshipId = workbook.WorkbookPart.GetIdOfPart(sheetPart);

//                    uint sheetId = 1;
//                    if (sheets.Elements<DocumentFormat.OpenXml.Spreadsheet.Sheet>().Count() > 0)
//                    {
//                        sheetId =
//                            sheets.Elements<DocumentFormat.OpenXml.Spreadsheet.Sheet>().Select(s => s.SheetId.Value).Max() + 1;
//                    }

//                    DocumentFormat.OpenXml.Spreadsheet.Sheet sheet = new DocumentFormat.OpenXml.Spreadsheet.Sheet() { Id = relationshipId, SheetId = sheetId, Name = table.TableName };
//                    sheets.Append(sheet);

//                    DocumentFormat.OpenXml.Spreadsheet.Row headerRow = new DocumentFormat.OpenXml.Spreadsheet.Row();

//                    List<String> columns = new List<string>();
//                    foreach (System.Data.DataColumn column in table.Columns)
//                    {
//                        columns.Add(column.ColumnName);

//                        DocumentFormat.OpenXml.Spreadsheet.Cell cell = new DocumentFormat.OpenXml.Spreadsheet.Cell();
//                        cell.DataType = DocumentFormat.OpenXml.Spreadsheet.CellValues.String;
//                        cell.CellValue = new DocumentFormat.OpenXml.Spreadsheet.CellValue(column.ColumnName);
//                        headerRow.AppendChild(cell);
//                    }


//                    sheetData.AppendChild(headerRow);

//                    foreach (System.Data.DataRow dsrow in table.Rows)
//                    {
//                        DocumentFormat.OpenXml.Spreadsheet.Row newRow = new DocumentFormat.OpenXml.Spreadsheet.Row();
//                        foreach (String col in columns)
//                        {
//                            DocumentFormat.OpenXml.Spreadsheet.Cell cell = new DocumentFormat.OpenXml.Spreadsheet.Cell();
//                            cell.DataType = DocumentFormat.OpenXml.Spreadsheet.CellValues.String;
//                            cell.CellValue = new DocumentFormat.OpenXml.Spreadsheet.CellValue(dsrow[col].ToString());
//                            newRow.AppendChild(cell);
//                        }

//                        sheetData.AppendChild(newRow);
//                    }

//                }
//            }
//            workbook.WorkbookPart.Workbook.Save();
//            workbook.Close();

//            returnBytes = mem.ToArray();

//            return returnBytes;
//        }
//        catch (Exception)
//        {

//            throw;
//        }
//    }
//}

public static class ImageResize
{
    /// <summary>
    /// Resizes and rotates an image, keeping the original aspect ratio. Does not dispose the original
    /// Image instance.
    /// </summary>
    /// <param name="image">Image instance</param>
    /// <param name="width">desired width</param>
    /// <param name="height">desired height</param>
    /// <param name="rotateFlipType">desired RotateFlipType</param>
    /// <returns>new resized/rotated Image instance</returns>
    public static Image Resize(Image image, int width, int height, RotateFlipType rotateFlipType)
    {
        // clone the Image instance, since we don't want to resize the original Image instance
        var rotatedImage = image.Clone() as Image;
        rotatedImage.RotateFlip(rotateFlipType);
        var newSize = CalculateResizedDimensions(rotatedImage, width, height);

        var resizedImage = new Bitmap(newSize.Width, newSize.Height, PixelFormat.Format32bppArgb);
        resizedImage.SetResolution(72, 72);

        using (var graphics = Graphics.FromImage(resizedImage))
        {
            // set parameters to create a high-quality thumbnail
            graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphics.SmoothingMode = SmoothingMode.AntiAlias;
            graphics.CompositingQuality = CompositingQuality.HighQuality;
            graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;

            // use an image attribute in order to remove the black/gray border around image after resize
            // (most obvious on white images), see this post for more information:

            using (var attribute = new ImageAttributes())
            {
                attribute.SetWrapMode(WrapMode.TileFlipXY);

                // draws the resized image to the bitmap
                graphics.DrawImage(rotatedImage, new Rectangle(new Point(0, 0), newSize), 0, 0, rotatedImage.Width, rotatedImage.Height, GraphicsUnit.Pixel, attribute);
            }
        }

        return resizedImage;
    }

    /// <summary>
    /// Calculates resized dimensions for an image, preserving the aspect ratio.
    /// </summary>
    /// <param name="image">Image instance</param> 
    /// <param name="desiredWidth">desired width</param>
    /// <param name="desiredHeight">desired height</param>
    /// <returns>Size instance with the resized dimensions</returns>
    private static Size CalculateResizedDimensions(Image image, int desiredWidth, int desiredHeight)
    {
        var widthScale = (double)desiredWidth / image.Width;
        var heightScale = (double)desiredHeight / image.Height;

        // scale to whichever ratio is smaller, this works for both scaling up and scaling down
        var scale = widthScale < heightScale ? widthScale : heightScale;

        return new Size
        {
            Width = (int)(scale * image.Width),
            Height = (int)(scale * image.Height)
        };
    }
}

public static class RoleIDs
{
    //public static string SiteAdmin = "5510C477-6BD4-46EA-90DF-40F5891A50DB";
    //public static string ClientAdmin = "2CB60942-FE25-415A-9092-1F571174A1FC";
    //public static string ClientUserLevel1 = "5D5B06A5-92D5-44D7-ABCA-4DEC0489A41E";
    //public static string FemsInspector = "29F8A046-9850-4912-AB7B-5318FAF49E5C";
    //public static string ClientUserLevel2 = "19BDBC42-32C0-4904-AD89-9260D38D411F";
    //public static string ClientUserLevel4 = "3D701C98-332D-42F9-B499-489359AD69F8";

    public static string Admin = "Admin";
    public static string SuperUser = "SuperUser";
    public static string BTLUser = "BTLUser";
    public static string ATLUser = "ATLUser";
    public static string NationalUser = "NationalUser";

}

public static class SetDates
{
    public static void SetMonthDropdown(ref System.Web.UI.WebControls.DropDownList ddlMonth)
    {
        DateTime StartDate = new DateTime(2016, 6, 1).Date;
        int Month = DateTime.Now.Month;
        int Year = DateTime.Now.Year;

        DateTime EndDate = new DateTime(Year, Month, DateTime.Now.Day).Date;
        DateTime tempStartDate = StartDate;

        int monthscount = GetMonthsBetween(StartDate, EndDate);

        tempStartDate = StartDate;

        ddlMonth.Items.Clear();
        ddlMonth.Items.Add(new System.Web.UI.WebControls.ListItem("--Select Month--", "0"));

        for (int j = 0; j <= monthscount; j++)
        {
            var first = new DateTime(tempStartDate.Year, tempStartDate.Month, 1);
            var last = new DateTime(tempStartDate.Year, tempStartDate.Month, DateTime.DaysInMonth(tempStartDate.Year, tempStartDate.Month));
            ddlMonth.Items.Add(new System.Web.UI.WebControls.ListItem(string.Format("{0:MMM yyyy}", tempStartDate), string.Format("{0:MM/dd/yyyy}", first) + "|" + string.Format("{0:MM/dd/yyyy}", last)));
            tempStartDate = tempStartDate.AddMonths(1);
        }
    }

    public static void SetQuarterDropdown(DateTime? MinDate, DateTime? MaxDate, ref System.Web.UI.WebControls.DropDownList ddlQuarter)
    {

        DateTime StartDate = new DateTime(DateTime.Now.Year, 1, 1).Date;
        int Month = DateTime.Now.Month;
        int Year = DateTime.Now.Year;

        DateTime EndDate = new DateTime(Year, Month, DateTime.Now.Day).Date;
        DateTime tempStartDate = StartDate;

        int monthscount = GetMonthsBetween(StartDate, EndDate);

        tempStartDate = StartDate;

        ddlQuarter.Items.Clear();
        ddlQuarter.Items.Add(new System.Web.UI.WebControls.ListItem("--Select Quarter--", "0"));

        for (int j = 0; j < monthscount; j++)
        {
            string quartername = "";
            int quarterNumber = (int)Math.Ceiling(tempStartDate.Month / 3.0M);
            DateTime firstDayOfQuarter = new DateTime(tempStartDate.Year, (quarterNumber - 1) * 3 + 1, 1);
            DateTime lastDayOfQuarter = firstDayOfQuarter.AddMonths(3).AddDays(-1);

            if (quarterNumber == 1)
            {
                quartername = "Quarter 1 in " + tempStartDate.Year.ToString();
            }
            else if (quarterNumber == 2)
            {
                quartername = "Quarter 2 in " + tempStartDate.Year.ToString();
            }
            else if (quarterNumber == 3)
            {
                quartername = "Quarter 3 in " + tempStartDate.Year.ToString();
            }
            else if (quarterNumber == 4)
            {
                quartername = "Quarter 4 in " + tempStartDate.Year.ToString();
            }

            var first = new DateTime(tempStartDate.Year, tempStartDate.Month, 1);
            var last = new DateTime(tempStartDate.Year, tempStartDate.Month, DateTime.DaysInMonth(tempStartDate.Year, tempStartDate.Month));

            if (ddlQuarter.Items.FindByText(quartername) == null)
            {
                ddlQuarter.Items.Add(new System.Web.UI.WebControls.ListItem(quartername, string.Format("{0:MM/dd/yyyy}", firstDayOfQuarter) + "|" + string.Format("{0:MM/dd/yyyy}", lastDayOfQuarter)));
            }

            //ddlQuarter.Items.Add(new System.Web.UI.WebControls.ListItem(quartername, string.Format("{0:dd/MM/yyyy}", firstDayOfQuarter) + "|" + string.Format("{0:dd/MM/yyyy}", lastDayOfQuarter)));
            tempStartDate = tempStartDate.AddMonths(1);
        }
    }

    public static void SetYearDropdown(ref System.Web.UI.WebControls.DropDownList ddlYear)
    {
        DateTime StartDate = new DateTime(2016, 1, 1).Date;
        int Month = DateTime.Now.Month;
        int Year = DateTime.Now.Year;

        DateTime EndDate = new DateTime(Year, Month, DateTime.Now.Day).Date;
        DateTime tempStartDate = StartDate;

        int monthscount = GetDifferenceInYears(StartDate);

        tempStartDate = StartDate;

        ddlYear.Items.Clear();
        ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem("--Select Year--", "0"));

        for (int j = 0; j <= monthscount; j++)
        {
            var first = new DateTime(tempStartDate.Year, tempStartDate.Month, 1);
            var last = new DateTime(tempStartDate.Year, 12, DateTime.DaysInMonth(tempStartDate.Year, tempStartDate.Month));
            ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem(string.Format("{0: yyyy}", tempStartDate), string.Format("{0:MM/dd/yyyy}", first) + "|" + string.Format("{0:MM/dd/yyyy}", last)));
            tempStartDate = tempStartDate.AddMonths(12);
        }
    }

    private static int GetMonthsBetween(DateTime from, DateTime to)
    {
        if (from > to) return GetMonthsBetween(to, from);

        var monthDiff = Math.Abs((to.Year * 12 + (to.Month - 1)) - (from.Year * 12 + (from.Month - 1)));

        if (from.AddMonths(monthDiff) > to || to.Day < from.Day)
        {
            return monthDiff - 1;
        }
        else
        {
            return monthDiff;
        }
    }

    private static int GetDifferenceInYears(DateTime startDate)
    {
        int finalResult = 0;

        const int DaysInYear = 365;

        DateTime endDate = DateTime.Now;

        TimeSpan timeSpan = endDate - startDate;

        if (timeSpan.TotalDays > 365)
        {
            finalResult = (int)Math.Round((timeSpan.TotalDays / DaysInYear), MidpointRounding.ToEven);
        }

        return finalResult;
    }

}