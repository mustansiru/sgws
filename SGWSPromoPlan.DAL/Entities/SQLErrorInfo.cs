using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
   public class SQLErrorInfo
    {
        public string ErrorMessage { get; set; }
        public int ErrorSeverity { get; set; }
        public int ErrorState { get; set; }
    }
}
