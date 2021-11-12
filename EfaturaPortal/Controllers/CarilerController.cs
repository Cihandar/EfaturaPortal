using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Application.Carilers.Commands;
using EfaturaPortal.Application.Interfaces.Cariler;
using EfaturaPortal.Application.Carilers.ViewModels;
using Microsoft.AspNetCore.Authorization;

namespace EfaturaPortal.Controllers
{
    
    public class CarilerController : BaseController
    {

    
 
        public ICarilerCrud CariCommand;
      
        public CarilerController(ICarilerCrud _CariCommand)
        {
     
            CariCommand = _CariCommand;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public async Task<JsonResult> GetAll()
        {
            var result = await CariCommand.GetAll(FirmaId);
            return Json(result);
        }

        [HttpGet]
        public async Task<JsonResult> GetById(Guid Id)
        {
            var result = await CariCommand.GetById(Id);
            return Json(result);
        }

        #region Update
        [HttpGet]
        public async Task<IActionResult> Update(Guid Id)
        {
            var result = await CariCommand.GetById(Id);
            return PartialView("_FormPartial", result);
        }

        [HttpPost]
        public async Task<IActionResult> Update(CarilerGetAllQueryViewModel model)
        {
            
            var result = await CariCommand.Update(model);

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
        public async Task<IActionResult> Create(CarilerGetAllQueryViewModel model)
        {
            model.FirmaId = FirmaId;
            var result = await CariCommand.Add(model);

            return Json(result);
        }
        #endregion

    }
}
