using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Application.SeriNumaralars.Commands;
using EfaturaPortal.Application.Interfaces.SeriNumaralars;
using EfaturaPortal.Application.SeriNumaralars.ViewModels;
using Microsoft.AspNetCore.Authorization;
using EfaturaPortal.Application.Interfaces.FileUploads;

namespace EfaturaPortal.Controllers
{
    
    public class SeriNumaralarController : BaseController
    {

    
 
        public ISeriNumaralarCrud SeriNCommand;
        public IFileUpload fileUpload;
      
        public SeriNumaralarController(ISeriNumaralarCrud _SeriNCommand,IFileUpload _fileUpload)
        {
     
            SeriNCommand = _SeriNCommand;
            fileUpload = _fileUpload;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public async Task<JsonResult> GetAll()
        {
            var result = await SeriNCommand.GetAll(FirmaId);
            return Json(result);
        }

        [HttpGet]
        public async Task<JsonResult> GetById(Guid Id)
        {
            var result = await SeriNCommand.GetById(Id);
            return Json(result);
        }

        #region Update
        [HttpGet]
        public async Task<IActionResult> Update(Guid Id)
        {
            var result = await SeriNCommand.GetById(Id);
            return PartialView("_FormPartial", result);
        }

        [HttpPost]
        public async Task<IActionResult> Update(SeriNumaralarGetAllQueryViewModel model)
        {            
            var result = await SeriNCommand.Update(model);
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
        public async Task<IActionResult> Create(SeriNumaralarGetAllQueryViewModel model)
        {
            model.FirmaId = FirmaId;
            var result = await SeriNCommand.Add(model);
            return Json(result);
        }
        #endregion


        [HttpPost]
        public async Task<IActionResult> UploadXslt(string base64file, string fname)
        {
            var result = await fileUpload.UploadFileXslt(base64file, fname);

            return Json(result);
        }

    }
}
