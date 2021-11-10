using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Application.Auths.ViewModels;
using EfaturaPortal.Application.Interfaces.Auth;

namespace EfaturaPortal.Controllers
{

    [AllowAnonymous]
    [Route("Auth")]
    public class AuthController : Controller
    {

        private readonly SignInManager<AppUser> _signInManager;
        private readonly UserManager<AppUser> _userManager;
        private IAuthCrud authCrud;

        public AuthController(SignInManager<AppUser> signInManager, UserManager<AppUser> userManager, IAuthCrud _authCrud)
        {
            _signInManager = signInManager;
            _userManager = userManager;
            authCrud = _authCrud;
        }

        [Route("Login")]
        public IActionResult Index()
        {
            return View();
        }


        [HttpPost("Login")]
        public async Task<IActionResult> Login(AuthViewModel model)
        {
            var result = await authCrud.Login(model);

            return Json(result);
        }

        [Route("Register")]
        public IActionResult Register()
        {
            return View("Register");
        }

        [HttpPost("Register")]
        public async Task<IActionResult> Register(AuthRegisterViewModel model)
        {
            var result = await authCrud.Register(model);

            return Json(result);

        }

        [Route("Logout")]
        public async Task<IActionResult> Logout()
        {
            await _signInManager.SignOutAsync();
            return View("index");
        }
    }
}
