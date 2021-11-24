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

namespace EfaturaPortal.Controllers
{
    public class YeniFaturaController : BaseController
    {

        IFaturaCrud faturaCrud;
        ISeriNumaralarCrud SNumaralarCrud;
        IEdmEInvoiceLogin _edmLogin;
        IEInvoiceTransactions _eInvoiceCommand;
        ITcmbDovizKurlari _TcmbDovizKurlari;
        public IActionResult Index()
        {
            return View();
        }

        public YeniFaturaController(IFaturaCrud _faturaCrud, ISeriNumaralarCrud _SNumaralarCrud, IEdmEInvoiceLogin edmLogin, IEInvoiceTransactions eInvoiceCommand, ITcmbDovizKurlari TcmbDovizKurlari)
        {
            faturaCrud = _faturaCrud;
            SNumaralarCrud = _SNumaralarCrud;
            _edmLogin = edmLogin;
            _eInvoiceCommand = eInvoiceCommand;
            _TcmbDovizKurlari = TcmbDovizKurlari;
        }



        [HttpGet]
        public async Task<IActionResult> GetSeriNumaralar(FaturaTuru faturaTuru)
        {
            var result = await SNumaralarCrud.GetSeriNumaraByFaturaTuru(faturaTuru, FirmaId);

            return Json(result);
        }

        public async Task<IActionResult> CheckTaxNumber(string TaxNumber)
        {
            var result = await _eInvoiceCommand.Ef_GetEInvoiceMailBox(FirmaId, TaxNumber);

            return Json(result);

        }

        public async Task<IActionResult> GetDovizKuru(string DovizKodu,string Tarih)
        {
            var result = await _TcmbDovizKurlari.DovizKuruAl(DovizKodu, Tarih);

            return Json(result);
        }

        #region Create
        [HttpGet]
        public async Task<IActionResult> Create()
        {
            var result = await faturaCrud.GetById(Guid.NewGuid(), FirmaId);
            return View("Index",result);
        }

        [HttpPost]
        public async Task<IActionResult> Create(FaturaGetAllQueryViewModel model)
        {
            model.FirmaId = FirmaId;
            var result = await faturaCrud.Add(model);
            return Json(result);
        }
        #endregion



    }
}
