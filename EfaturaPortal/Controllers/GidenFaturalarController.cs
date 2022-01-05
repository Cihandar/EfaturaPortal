using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Application.Faturas.Commands;
using EfaturaPortal.Application.Faturas.ViewModels;
using EfaturaPortal.Application.SeriNumaralars.Commands;
using EfaturaPortal.Application.SeriNumaralars.ViewModels;
using EfaturaPortal.Models.Enum;
using EfaturaPortal.Application.Interfaces.SeriNumaralars;
using EfaturaPortal.Application.Interfaces.Faturas;
using EfaturaPortal.Application.Interfaces.EfaturaApis;
using EfaturaPortal.Application.Interfaces.Extentions;
using EfaturaPortal.Application.Interfaces.Cariler;
using EfaturaPortal.Application.Interfaces.FaturaSatirs;
using EfaturaPortal.Application.Interfaces.VergiKodlaris;
using EfaturaPortal.Models.ResultModel;

namespace EfaturaPortal.Controllers
{
    public class GidenFaturalarController : BaseController
    {

        IFaturaCrud faturaCrud;
        ISeriNumaralarCrud SNumaralarCrud;
        IEdmEInvoiceLogin _edmLogin;
        IEInvoiceTransactions _eInvoiceCommand;
        ITcmbDovizKurlari _TcmbDovizKurlari;
        ICarilerCrud _carilerCrud;
        IFaturaSatirCrud _faturaSatirCrud;
        IVergiKodlariCrud _vergiKodlariCrud;

        public IActionResult Index()
        {
            return View();
        }

        public GidenFaturalarController(IFaturaCrud _faturaCrud, ISeriNumaralarCrud _SNumaralarCrud, IEdmEInvoiceLogin edmLogin, IEInvoiceTransactions eInvoiceCommand, ITcmbDovizKurlari TcmbDovizKurlari,ICarilerCrud carilerCrud, IFaturaSatirCrud faturaSatirCrud,IVergiKodlariCrud vergiKodlariCrud)
        {
            faturaCrud = _faturaCrud;
            SNumaralarCrud = _SNumaralarCrud;
            _edmLogin = edmLogin;
            _eInvoiceCommand = eInvoiceCommand;
            _TcmbDovizKurlari = TcmbDovizKurlari;
            _carilerCrud = carilerCrud;
            _faturaSatirCrud = faturaSatirCrud;
            _vergiKodlariCrud = vergiKodlariCrud;
        }



        [HttpPost]
        public async Task<IActionResult> GetAll()
        {
            var result = await faturaCrud.GetAll(FirmaId);

            return Json(result);
        }

        [HttpPost]
        public async Task<IActionResult> GetAllbyFiltre(InvoiceSearch filtre)
        {
            var result = await faturaCrud.GetAllbyfiltre(FirmaId,filtre);

            return Json(result);
        }


        #region Create


        #endregion



    }
}
