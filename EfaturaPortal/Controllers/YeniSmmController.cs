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
using EfaturaPortal.Models.EfaturaModel;

namespace EfaturaPortal.Controllers
{
    public class YeniSmmController : BaseController
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

        public YeniSmmController(IFaturaCrud _faturaCrud, ISeriNumaralarCrud _SNumaralarCrud, IEdmEInvoiceLogin edmLogin, IEInvoiceTransactions eInvoiceCommand, ITcmbDovizKurlari TcmbDovizKurlari,ICarilerCrud carilerCrud, IFaturaSatirCrud faturaSatirCrud,IVergiKodlariCrud vergiKodlariCrud)
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



        [HttpGet]
        public async Task<IActionResult> GetSeriNumaralar(int Yil)
        {
            var result = await SNumaralarCrud.GetSeriNumaraByFaturaTuru(FaturaTuru.ESmm, FirmaId,Yil);

            return Json(result);
        }

        public async Task<IActionResult> CheckTaxNumber(string TaxNumber)
        {

            var result = new CheckUserResult(); // Efatura Kullanıcı Kontrol 

            var cari = await _carilerCrud.GetCaribyTaxNumber(TaxNumber);  // Sistemde Cari olarak Kayıtlımı ? Bir Bak Gel. 

            if(cari!=null) result.Cari = cari;        // Eğer Sistemde Kayıtlı ise result cariyi doldur. >> Result.Cari CarilerGetAllQueryViewModel alır..
            
            return Json(result);

        }

        public async Task<IActionResult> GetCariWithId(Guid Id)
        {
            var cari = await _carilerCrud.GetById(Id);
            var result =await _eInvoiceCommand.Ef_GetEInvoiceMailBox(FirmaId, cari.VergiNumarasi);
            result.Cari = cari;

            return Json(result);
        }

        public async Task<IActionResult> GetDovizKuru(string DovizKodu,string Tarih)
        {
            var result = await _TcmbDovizKurlari.DovizKuruAl(DovizKodu, Tarih);

            return Json(result);
        }

        public async Task<IActionResult> GetCariler()
        {
            var result = await _carilerCrud.GetAll(FirmaId);

            return PartialView("_FormPartialCariSec", result);
        }

        public async Task<IActionResult> GetInvoiceLine(int index)
        {
            var result = await _faturaSatirCrud.GetEmptyRow();
            ViewBag.Index = index;
            return PartialView("_InvoiceLineForm",result);
        }

        public async Task<IActionResult> GetInvoiceTaxLine(int index,int KdvIndex)
        {
            var result = await _vergiKodlariCrud.GetAll();
            ViewBag.Index = index;
            ViewBag.KdvIndex = KdvIndex;
            return PartialView("_InvoiceLineTax", result);
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
            model.FaturaTipi = FaturaTipi.Satis;
            model.FaturaTuru = FaturaTuru.ESmm;
 
            var result = await faturaCrud.Add(model);
            return Json(result);
        }

        [HttpPost]
        public async Task<IActionResult> Create2(FaturaVw model)
        { 
            return Json(null);
        }

        #endregion



    }
}
