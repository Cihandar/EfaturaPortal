using EfaturaPortal.Application.Auths.ViewModels;
using EfaturaPortal.Application.Interfaces.Auth;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.Interfaces.Firmalar;
using EfaturaPortal.Application.Interfaces.Email;

namespace EfaturaPortal.Application.Auths.Command
{
    public class AuthCrud : IAuthCrud
    {
        public EfaturaPortalContext context;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly UserManager<AppUser> _userManager;
        private IFirmalarCrud _firma;
        private ISendEmail _email;

        public AuthCrud(EfaturaPortalContext _context, SignInManager<AppUser> signInManager, UserManager<AppUser> userManager,IFirmalarCrud firma,ISendEmail email)
        {
            context = _context;
            _signInManager = signInManager;
            _userManager = userManager;
            _firma = firma;
            _email = email;
        }


        public async Task<ResultJson> Login(AuthViewModel model)
        {

            var user = _userManager.Users.Where(x => x.UserName == model.Email).FirstOrDefault();

            if(user==null)
            {
                return new ResultJson { Success = false, Message = "Kullanıcı Adı veya Şifre Yanlış." };
            }

            var result = await _signInManager.PasswordSignInAsync(user, model.Sifre, model.BeniHatirla, false);
            if(result.Succeeded)
            {
                return new ResultJson { Success = true, Message = "Giriş Başarılı" };
            }else
            {
                return new ResultJson { Success = false, Message = "Kullanıcı Adı veya Şifre Yanlış." };
            }
        }

        public async Task<ResultJson> Register(AuthRegisterViewModel model)
        {

            var usercheck = _userManager.Users.Where(x => x.Email == model.Email).FirstOrDefault();

            if (usercheck != null) return new ResultJson { Success = false, Message = "Girmiş olduğunuz mail adresi sistemde kayıtlıdır. Şifremi unuttum diyerek işleminize devam edebilirsiniz." };


            var resultfirma = await _firma.Add(model.Firma);

            if(resultfirma.Success)
            {
                var user = new AppUser
                {
                    Email = model.Email,
                    UserName = model.Email,
                    PhoneNumber = model.Firma.Telefon,
                    FirmaId = resultfirma.Id
                };

                var sifre =  new Random().Next(100000, 999999);

                var resultuser = await _userManager.CreateAsync(user, sifre.ToString());

                if(resultuser.Succeeded)
                {
                    var resultemail = _email.Send(model.Email, "Alze E Portal Giriş Bilgileri", "", model.Email, sifre.ToString(), "IlkKayit");

                    return new ResultJson { Success = true, Message = "Kaydınız yapıldı.Email adresinize gelen şifre ile giriş yapabilirsiniz" };
                }

            }else
            {
                return new ResultJson { Success = false, Message = "Firma Kaydı Yapılamadı" };
            }

            return null;
        }
    }
}
