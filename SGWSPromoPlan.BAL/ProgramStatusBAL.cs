using SGWSPromoPlan.DAL;
using System.Collections.Generic;

namespace SGWSPromoPlan.BAL
{
    public static class ProgramStatusBAL
    {
        public static List<ProgramStatus> GetProgramStatus(string sqlConnectionString)
        {
            IProgramStatusRepository _IProgramStatusRepository = new ProgramStatusRepository();
            return _IProgramStatusRepository.GetProgramStatus(sqlConnectionString);
        }
    }
}
