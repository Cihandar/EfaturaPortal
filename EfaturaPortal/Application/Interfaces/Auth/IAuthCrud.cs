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
        Task<List<AuthGetAllViewModel>> GetAll(Guid FirmaId);
        Task<AuthGetAllViewModel> GetById(string Id);
        Task<AuthChangePasswordViewModel> GetUpdatePasswordUserInfo(string Id);
        Task<ResultJson> UpdatePassword(AuthChangePasswordViewModel model);
        Task<ResultJson> Update(AuthGetAllViewModel model);
        Task<ResultJson> Add(AuthGetAllViewModel model, Guid FirmaId);
        Task<ResultJson> ResetPassword(AuthViewModel model);

    }
}
