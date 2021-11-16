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
using AutoMapper;

namespace EfaturaPortal.Application.Auths.Command
{
    public class AuthCrud : IAuthCrud
    {
        public EfaturaPortalContext context;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly UserManager<AppUser> _userManager;
        private IFirmalarCrud _firma;
        private ISendEmail _email;
        private IMapper _mapper;

        public AuthCrud(EfaturaPortalContext _context, SignInManager<AppUser> signInManager, UserManager<AppUser> userManager, IFirmalarCrud firma, ISendEmail email, IMapper mapper)
        {
            context = _context;
            _signInManager = signInManager;
            _userManager = userManager;
            _firma = firma;
            _email = email;
            _mapper = mapper;
        }


        public async Task<ResultJson> Login(AuthViewModel model)
        {

            var user = _userManager.Users.Where(x => x.UserName == model.Email).FirstOrDefault();

            if (user == null)
            {
                return new ResultJson { Success = false, Message = "Kullanıcı Adı veya Şifre Yanlış." };
            }

            var result = await _signInManager.PasswordSignInAsync(user, model.Sifre, model.BeniHatirla, false);
            if (result.Succeeded)
            {
                return new ResultJson { Success = true, Message = "Giriş Başarılı" };
            }
            else
            {
                return new ResultJson { Success = false, Message = "Kullanıcı Adı veya Şifre Yanlış." };
            }
        }

        public async Task<ResultJson> Register(AuthRegisterViewModel model)
        {

            var usercheck = await IsEmailRegistered(model.Email);

            if (usercheck) return new ResultJson { Success = false, Message = "Girmiş olduğunuz mail adresi sistemde kayıtlıdır. Şifremi unuttum diyerek işleminize devam edebilirsiniz." };


            var resultfirma = await _firma.Add(model.Firma);

            if (resultfirma.Success)
            {
                var user = new AppUser
                {
                    Email = model.Email,
                    UserName = model.Email,
                    PhoneNumber = model.Firma.Telefon,
                    FirmaId = resultfirma.Data.Id
                };

                var sifre = await CreateNewPassword();

                var resultuser = await _userManager.CreateAsync(user, sifre.ToString());

                if (resultuser.Succeeded)
                {
                    var resultemail = _email.Send(model.Email, "Alze E Portal Giriş Bilgileri", "", model.Email, sifre.ToString(), "IlkKayit");

                    return new ResultJson { Success = true, Message = "Kaydınız yapıldı.Email adresinize gelen şifre ile giriş yapabilirsiniz" };
                }

            }
            else
            {
                return new ResultJson { Success = false, Message = "Firma Kaydı Yapılamadı" };
            }

            return null;
        }



        public async Task<List<AuthGetAllViewModel>> GetAll(Guid FirmaId)
        {
            var data = _userManager.Users.Where(x => x.FirmaId == FirmaId).ToList();

            var result = _mapper.Map<List<AuthGetAllViewModel>>(data);

            return result;
        }

        public async Task<AuthGetAllViewModel> GetById(string Id)
        {
            var data = _userManager.Users.Where(x => x.Id == Id).FirstOrDefault();

            var result = _mapper.Map<AuthGetAllViewModel>(data);

            return result;
        }

        public async Task<ResultJson> Update(AuthGetAllViewModel model)
        {
            var data = _userManager.Users.Where(x => x.Id == model.Id.ToString()).FirstOrDefault();


            data.AdSoyad = model.AdSoyad;
            data.PhoneNumber = model.PhoneNumber;
            var result = await _userManager.UpdateAsync(data);

            if (result.Succeeded)
            {
                return new ResultJson { Success = true, Message = "İşlem Başarılı." };
            }
            else
            {
                return new ResultJson { Success = false, Message = "İşlem yapılırken hata oluştu !!!" };
            }



        }


        public async Task<AuthChangePasswordViewModel> GetUpdatePasswordUserInfo(string Id)
        {
            var data = _userManager.Users.Where(x => x.Id == Id).FirstOrDefault();

            var Info = new AuthChangePasswordViewModel
            {
                Email = data.Email,
                Id = data.Id
            };

            return Info;
        }

        public async Task<ResultJson> UpdatePassword(AuthChangePasswordViewModel model)
        {
            var data = _userManager.Users.Where(x => x.Id == model.Id).FirstOrDefault();
            var result = await _userManager.ChangePasswordAsync(data, model.EskiSifre, model.Sifre);

            if (result.Succeeded)
            {
                return new ResultJson { Success = true, Message = "Şifreniz Değiştirildi." };
            }
            else
            {
                return new ResultJson { Success = false, Message = "Eski Şifreniz Hatalı. Şifreniz Değiştirelemedi." };
            }

        }

        public async Task<ResultJson> Add(AuthGetAllViewModel model, Guid FirmaId)
        {
            var usercheck = await IsEmailRegistered(model.Email);
            if (usercheck) return new ResultJson { Success = false, Message = "Girmiş olduğunuz Email adresi sistemimizde kayıtlıdır." };


            var user = new AppUser
            {
                Email = model.Email,
                UserName = model.Email,
                PhoneNumber = model.PhoneNumber,
                FirmaId = FirmaId
            };


            var sifre = await CreateNewPassword();

            var resultuser = await _userManager.CreateAsync(user, sifre.ToString());

            if (resultuser.Succeeded)
            {
                var resultemail = _email.Send(model.Email, "Alze E Portal Giriş Bilgileri", "", model.Email, sifre.ToString(), "IlkKayit");

                return new ResultJson { Success = true, Message = "Kayıt yapıldı.Email adresine giden şifre ile giriş yapabilirsiniz." };
            }
            else return new ResultJson { Success = false, Message = "İşlem sırasında Hata oluştu." };





        }



        public async Task<bool> IsEmailRegistered(string email)
        {
            var usercheck = _userManager.Users.Where(x => x.Email == email).FirstOrDefault();

            if (usercheck != null) return true; else return false;

        }


        public async Task<ResultJson> ResetPassword(AuthViewModel model)
        {
            try
            {

            var user = _userManager.Users.Where(x => x.Email == model.Email).FirstOrDefault();

            if (user != null)
            {
                var resetToken = await _userManager.GeneratePasswordResetTokenAsync(user);
                var sifre = await CreateNewPassword();

                var resultResetPassword = await _userManager.ResetPasswordAsync(user, resetToken, sifre);

                if (resultResetPassword.Succeeded)
                {
                    var resultemail = _email.Send(model.Email, "Alze E Portal Giriş Bilgileri", "", model.Email, sifre.ToString(), "IlkKayit");
                    if (resultemail)
                    {
                        new ResultJson { Success = true, Message = "Yeni şifreniz Email adresinize gönderildi." };

                    }
                    else new ResultJson { Success = false, Message = "Mail gönderirken bir sorun oluştu. Lütfen daha sonra tekrar deneyiniz." };

                }

            }
            else return new ResultJson { Success = false, Message = "Girmiş olduğunuz Email adresi sistemimizde kayıtlı değil." };


            return new ResultJson { Success = false, Message = "Sistemde bir sorun oluştu. Lütfen daha sonra tekrar deneyiniz." };

            }
            catch (Exception ex)
            {

                return new ResultJson { Success = false, Message = "Hata:" + ex.Message };
            }
        }


        public async Task<string> CreateNewPassword()
        {
            var result = new Random().Next(100000, 999999);
            return result.ToString();
        }





    }
}
