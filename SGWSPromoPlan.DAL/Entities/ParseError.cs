using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public class TMP_ParseError
    {
        public long Id { get; set; }
        public long RecordId { get; set; }
        public string ColumnName { get; set; }
        public string ColumnValue { get; set; }
        public string ErrroMsg { get; set; }
        public string GID { get; set; }
    }
}
