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
using EfaturaPortal.Application.Interfaces.Tools;
using System.Text;

namespace EfaturaPortal.Controllers
{
    public class GidenFaturalarController : BaseController
    {
        IFaturaCrud faturaCrud;
        ISeriNumaralarCrud _SeriNumaralarCrud;
        IEdmEInvoiceLogin _edmLogin;
        IEInvoiceTransactions _eInvoiceCommand;
        ITcmbDovizKurlari _TcmbDovizKurlari;
        ICarilerCrud _carilerCrud;
        IFaturaSatirCrud _faturaSatirCrud;
        IVergiKodlariCrud _vergiKodlariCrud;
        ICreateUbl _createUbl;
        IToolsCodes _toolsCodes;
        public IActionResult Index()
        {
            return View();
        }

        public GidenFaturalarController(IFaturaCrud _faturaCrud, ISeriNumaralarCrud SNumaralarCrud, IEdmEInvoiceLogin edmLogin, IEInvoiceTransactions eInvoiceCommand, ITcmbDovizKurlari TcmbDovizKurlari,ICarilerCrud carilerCrud, IFaturaSatirCrud faturaSatirCrud,IVergiKodlariCrud vergiKodlariCrud,ICreateUbl createUbl,IToolsCodes toolsCodes)
        {
            faturaCrud = _faturaCrud;
            _SeriNumaralarCrud = SNumaralarCrud;
            _edmLogin = edmLogin;
            _eInvoiceCommand = eInvoiceCommand;
            _TcmbDovizKurlari = TcmbDovizKurlari;
            _carilerCrud = carilerCrud;
            _faturaSatirCrud = faturaSatirCrud;
            _vergiKodlariCrud = vergiKodlariCrud;
            _createUbl = createUbl;
            _toolsCodes = toolsCodes;
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
        public async Task<IActionResult> GetInvoiceView(Guid Id)
        {
            var faturaResult = await faturaCrud.GetById(Id, FirmaId);
            var kdvResult = await _faturaSatirCrud.GetKdv(Id);
            var xmlInvoice = await _createUbl.Create(faturaResult, kdvResult);
            var design = await _toolsCodes.GetXSLTFiletoBinary(faturaResult.SeriNumaralar.SablonDosyaAdi);
            var result = await _eInvoiceCommand.GetInvoiceForView(xmlInvoice, design);
         //   result = result.Replace(@"""", "&quot;");
            ViewBag.InvoiceView = result;
            return PartialView("_InvoiceViewFormPartial", null);
        }

        public async Task<IActionResult> SendInvoice(Guid Id)
        {

            var faturaResult = await faturaCrud.GetById(Id, FirmaId);
            if(string.IsNullOrEmpty(faturaResult.FaturaNumarasi))
            {
                var resultNumber = await _SeriNumaralarCrud.GetLastInvoiceNumberAndUpdate(FirmaId, faturaResult.SeriNumaralar.SeriNo, faturaResult.Tarih.Year, faturaResult.FaturaTuru);
                if(resultNumber.Success)
                {
                    faturaResult.FaturaNumarasi = resultNumber.Value;
                }else
                {
                    return Json(faturaResult);
                }
             
            }
            var kdvResult = await _faturaSatirCrud.GetKdv(Id);
            var xmlInvoice = await _createUbl.Create(faturaResult, kdvResult);

            var result = await _eInvoiceCommand.SendeInvoice(faturaResult, Encoding.ASCII.GetBytes(xmlInvoice));

            if(result.Success)
            {
                var statusResult = await faturaCrud.UpdateInvoiceStatus(faturaResult.Id, EfaturaDurum.Yuklendi);
            }

            return Json(result);


        }
        #region Create


        #endregion



    }
}
