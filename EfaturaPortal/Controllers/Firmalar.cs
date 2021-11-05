using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Application.Firmalars.Commands;
using EfaturaPortal.Application.Firmalars.Queries;
using EfaturaPortal.Application.Firmalars.ViewModels;



namespace EfaturaPortal.Controllers
{
    public class Firmalar : Controller
    {

        FirmalarCreateCommand create;
        FirmalarUpdateCommand update;
        public  FirmalarGetQuery GetFirma;
        public Guid FirmaId;

        public Firmalar(FirmalarCreateCommand _create, FirmalarUpdateCommand _update,FirmalarGetQuery _GetFirma)
        {
            create = _create;
            update = _update;
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
