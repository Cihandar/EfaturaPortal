using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Application.Firmalars.Commands;
using EfaturaPortal.Application.Firmalars.Queries;
using EfaturaPortal.Application.Interfaces.Firmalar;

namespace EfaturaPortal.Controllers
{
    public class FirmalarController : Controller
    {

        //FirmalarCreateCommand create;
        //FirmalarUpdateCommand update;
        public IFirmalarGetQuery GetFirma;
        public Guid FirmaId;

        public FirmalarController(IFirmalarGetQuery _GetFirma)
        {
            //create = _create;
            //update = _update;
            GetFirma = _GetFirma;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult GetAll()
        {
            var result = GetFirma.GetAll(FirmaId);
            return Json(result);
        }

        [HttpGet]
        public JsonResult GetById(Guid Id)
        {
            var result = GetFirma.GetById(Id);
            return Json(result);
        }

    }
}
