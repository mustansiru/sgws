using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public static class log
    {
        public static void WriteLog(string message)
        {
            string path = System.Web.HttpContext.Current.Server.MapPath("~/log/log.txt");

            // This text is added only once to the file. 
            if (!File.Exists(path))
            {
                // Create a file to write to. 
                string createText = Environment.NewLine + message + Environment.NewLine + "Date : " + DateTime.Now;
                File.WriteAllText(path, createText);
            }

            // This text is always added, making the file longer over time 
            // if it is not deleted. 
            string appendText = Environment.NewLine + message + Environment.NewLine + "Date : " + DateTime.Now;
            File.AppendAllText(path, appendText);
        }
    }
}
