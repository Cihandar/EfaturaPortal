using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Models;
using EfaturaPortal.Application.EfaturaApi.Command;
using EfaturaPortal.Application.Faturas.Commands;
using EfaturaPortal.Application.Interfaces.EfaturaApis;
using EfaturaPortal.Application.Interfaces.Faturas;

namespace EfaturaPortal.Controllers
{
    public class HomeController : BaseController
    {

        ICreateUbl _createUbl;
        IFaturaCrud _faturaCrud;
        
        public HomeController(ICreateUbl createUbl,IFaturaCrud faturaCrud)
        {
            _createUbl = createUbl;
            _faturaCrud = faturaCrud;
        }

        public async Task<IActionResult> Index()
        {
            var faturaId = Guid.Parse("77550957-c3c5-484e-a213-bcb40ec7e024");

            //var firma = await _faturaCrud.GetById(faturaId, FirmaId);

            //var data = await _createUbl.Create(firma);


            return View();
        }

        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
