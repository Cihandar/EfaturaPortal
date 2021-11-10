using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.Firmalars.ViewModels;
namespace EfaturaPortal.Application.Auths.ViewModels
{
    public class AuthRegisterViewModel
    {
        public FirmalarGetAllQueryViewModel Firma { get; set; }
        public string Email { get; set; }
        public bool HizmetSozlesmesi { get; set; }
        public bool IletiGonderimi { get; set; }
        public bool Kvkk { get; set; }

    }
}
