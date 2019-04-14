using SGWSPromoPlan.DA;
using SGWSPromoPlan.DAL.SQLOperation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL
{
    public class ProgramStatusRepository: IProgramStatusRepository
    {
        public List<ProgramStatus> GetProgramStatus(string sqlConnectionString)
        {
            SQLHelper sqlHelper;

            try
            {
                sqlHelper = new SQLHelper(sqlConnectionString);
                List<ProgramStatus> _list = new List<ProgramStatus>();
                _list = DataReaderExtention.DataReaderMapToList<ProgramStatus>(sqlHelper.ExeReader("Select Id,Code From dbo.ProgramStatus With(Nolock)", CommandType.Text, null));

                return _list;
            }
            catch (Exception ex)
            {
                SGWSPromoPlan.DAL.log.WriteLog("ProgramStatusRepository => GetProgramStatus ===> Message: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return null;
            }
        }
    }
}
