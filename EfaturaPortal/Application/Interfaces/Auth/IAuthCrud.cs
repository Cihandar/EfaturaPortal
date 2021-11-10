using EfaturaPortal.Application.Auths.ViewModels;
using EfaturaPortal.Extentions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.Auth
{
    public interface IAuthCrud
    {
        Task<ResultJson> Login(AuthViewModel model);
        Task<ResultJson> Register(AuthRegisterViewModel model);

    }
}
