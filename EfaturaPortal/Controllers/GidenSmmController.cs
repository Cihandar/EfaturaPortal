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
using EfaturaPortal.Application.Interfaces.EsmmApis;
using EfaturaPortal.Application.Interfaces.Extentions;
using EfaturaPortal.Application.Interfaces.Cariler;
using EfaturaPortal.Application.Interfaces.FaturaSatirs;
using EfaturaPortal.Application.Interfaces.VergiKodlaris;
using EfaturaPortal.Models.ResultModel;
using EfaturaPortal.Application.Interfaces.Tools;
using System.Text;

namespace EfaturaPortal.Controllers
{
    public class GidenSmmController : BaseController
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
        ICreateSmmUbl _createSmmUbl;
        IToolsCodes _toolsCodes;

        IESmmTransactions _eSmmTransactions;
        public IActionResult Index()
        {
            return View();
        }

        public GidenSmmController(IFaturaCrud _faturaCrud, ISeriNumaralarCrud SNumaralarCrud, IEdmEInvoiceLogin edmLogin, IEInvoiceTransactions eInvoiceCommand, ITcmbDovizKurlari TcmbDovizKurlari, ICarilerCrud carilerCrud, IFaturaSatirCrud faturaSatirCrud, IVergiKodlariCrud vergiKodlariCrud, ICreateUbl createUbl, IToolsCodes toolsCodes, IESmmTransactions eSmmTransactions, ICreateSmmUbl createSmmUbl)
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
            _eSmmTransactions = eSmmTransactions;
            _createSmmUbl = createSmmUbl;
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
            var result = await faturaCrud.GetAllbyfiltre(FirmaId, filtre);
            return Json(result);
        }
        public async Task<IActionResult> GetInvoiceView(Guid Id)
        {
            var faturaResult = await faturaCrud.GetById(Id, FirmaId);
            var kdvResult = await _faturaSatirCrud.GetKdv(Id);
            var xmlInvoice = await _createSmmUbl.Create(faturaResult, kdvResult);
            var design =  Convert.FromBase64String(await _toolsCodes.esmmsablongetir());
            var result = await _eInvoiceCommand.GetInvoiceForView(xmlInvoice, design);
            //   result = result.Replace(@"""", "&quot;");
            ViewBag.InvoiceView = result;
            return PartialView("_InvoiceViewFormPartial", null);
        }

        [HttpPost]
        public async Task<IActionResult> SendInvoice([FromBody] SendInvoiceIds sendInvoiceIds)
        {
            var result = new List<ResultJson>();

            foreach (var invId in sendInvoiceIds.id)
            {
                var faturaResult = await faturaCrud.GetById(invId, FirmaId);
                if (string.IsNullOrEmpty(faturaResult.FaturaNumarasi))
                {
                    var resultNumber = await _SeriNumaralarCrud.GetLastInvoiceNumberAndUpdate(FirmaId, faturaResult.SeriNumaralar.SeriNo, faturaResult.Tarih.Year, faturaResult.FaturaTuru, faturaResult.Tarih);
                    if (resultNumber.Success)
                    {
                        faturaResult.FaturaNumarasi = resultNumber.Value;
                        var InNumberResult = faturaCrud.UpdateInvoiceNumber(invId, resultNumber.Value);
                    }
                    else
                    {
                        return Json(faturaResult);
                    }
                }

                var kdvResult = await _faturaSatirCrud.GetKdv(invId);
                string xmlInvoice = "";
                var resultSended = new ResultJson();
          
                    xmlInvoice = await _createSmmUbl.Create(faturaResult, kdvResult);
                    resultSended = await _eSmmTransactions.SendeInvoice(faturaResult, Encoding.UTF8.GetBytes(xmlInvoice));

                result.Add(resultSended);

                if (resultSended.Success)
                {
                    var statusResult = await faturaCrud.UpdateInvoiceStatus(faturaResult.Id, EfaturaDurum.Yuklendi);
                }
            }
            return Json(result);
        }

        public async Task<IActionResult> GetInvoiceStatus([FromBody] SendInvoiceIds sendInvoiceIds)
        {
            var result = new List<ResultJsonWithData<ResultInvoiceStatus>>();
            foreach (var invId in sendInvoiceIds.id)
            { 
                    var resultStatus = await _eSmmTransactions.GetInvoiceStatus(FirmaId, invId);
                    result.Add(resultStatus);
           
            }

            return Json(result);

        }

        public async Task<IActionResult> CancelInvoice(Guid Id)
        {
            
                var result = await _eSmmTransactions.CancelInvoice(FirmaId, Id);
                return Json(result);
          
        }




    }
}
