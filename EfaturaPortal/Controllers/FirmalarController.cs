using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Application.Firmalars.Commands;
using EfaturaPortal.Application.Interfaces.Firmalar;
using EfaturaPortal.Application.Firmalars.ViewModels;

namespace EfaturaPortal.Controllers
{
    public class FirmalarController : Controller
    {

        //FirmalarCreateCommand create;
        //FirmalarUpdateCommand update;
        public IFirmalarCrud FirmaCommand;
        public Guid FirmaId;

        public FirmalarController(IFirmalarCrud _FirmaCommand)
        {
            //create = _create;
            //update = _update;
            FirmaCommand = _FirmaCommand;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public async Task<JsonResult> GetAll()
        {
            var result = await FirmaCommand.GetAll(FirmaId);
            return Json(result);
        }

        [HttpGet]
        public async Task<JsonResult> GetById(Guid Id)
        {
            var result = await FirmaCommand.GetById(Id);
            return Json(result);
        }

        [HttpGet]
        public async Task<IActionResult> Update(Guid Id)
        {
            var result = await FirmaCommand.GetById(Id);

            return PartialView("_FormPartial", result);

        }

        [HttpPost]
        public async Task<IActionResult> Update(FirmalarGetAllQueryViewModel model)
        {
            var result = await FirmaCommand.Update(model);

            return Json(result);
        }

    }
}
