using System.Collections.Generic;

namespace SGWSPromoPlan.DAL
{
    public interface IProgramStatusRepository
    {
        List<ProgramStatus> GetProgramStatus(string sqlConnectionString);
    }
}
