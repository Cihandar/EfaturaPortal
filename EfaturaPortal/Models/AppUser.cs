using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    public class AppUser : IdentityUser
    {
        public string Avatar { get; set; }
        public byte status { get; set; }
        public Guid FirmaId { get; set; }

    }
}
