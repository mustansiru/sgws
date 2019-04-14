
using System;

namespace SGWSPromoPlan.DAL
{
    public class UserMaster
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Role { get; set; }
        public string IsActive { get; set; }
        public string Action { get; set; }
        public Guid UserId { get; set; }
        public Guid RoleId { get; set; }
    }
}
