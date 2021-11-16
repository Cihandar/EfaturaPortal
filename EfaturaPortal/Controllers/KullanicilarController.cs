using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Application.Interfaces.Auth;
using EfaturaPortal.Application.Auths.ViewModels;
using Microsoft.AspNetCore.Authorization;
using EfaturaPortal.Application.Interfaces.FileUploads;

namespace EfaturaPortal.Controllers
{

    public class KullanicilarController : BaseController
    {



        public IAuthCrud authCommand;
        public IFileUpload fileUpload;

        public KullanicilarController(IAuthCrud _authCommand, IFileUpload _fileUpload)
        {

            authCommand = _authCommand;
            fileUpload = _fileUpload;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public async Task<JsonResult> GetAll()
        {
            var result = await authCommand.GetAll(FirmaId);
            return Json(result);
        }

        [HttpGet]
        public async Task<JsonResult> GetById(string Id)
        {
            var result = await authCommand.GetById(Id);
            return Json(result);
        }


        #region Update
        [HttpGet]
        public async Task<IActionResult> UpdatePassword(string Id)
        {
            var result = await authCommand.GetUpdatePasswordUserInfo(Id);
            return PartialView("_FormPartialChangePassword", result);
        }

        [HttpPost]
        public async Task<IActionResult> UpdatePassword(AuthChangePasswordViewModel model)
        {
            var result = await authCommand.UpdatePassword(model);
            return Json(result);
        }

        [HttpGet]
        public async Task<IActionResult> Update(string Id)
        {
            var result = await authCommand.GetById(Id);
            return PartialView("_FormPartial", result);
        }

        [HttpPost]
        public async Task<IActionResult> Update(AuthGetAllViewModel model)
        {
            var result = await authCommand.Update(model);
            return Json(result);

        }
        #endregion

        #region Create
        [HttpGet]
        public async Task<IActionResult> Create()
        {
            return PartialView("_FormPartial", null);
        }

        [HttpPost]
        public async Task<IActionResult> Create(AuthGetAllViewModel model)
        {  
            var result = await authCommand.Add(model,FirmaId);
            return Json(result);
        }
        #endregion



    }
}
