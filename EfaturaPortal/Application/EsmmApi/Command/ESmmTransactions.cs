using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.EfaturaApi.Authorization;
using EfaturaPortal.Models;
using EfaturaPortal.Models.EfaturaModel;
using EdmEsmm;
using EfaturaPortal.Application.Interfaces.EsmmApis;
using EfaturaPortal.Extentions;
using System.Xml.Xsl;
using System.Xml;
using System.IO;
using System.Text;
using EfaturaPortal.Models.ResultModel;
using EfaturaPortal.Application.Faturas.ViewModels;
using EfaturaPortal.Application.Interfaces.Faturas;

namespace EfaturaPortal.Application.EfaturaApi.Command
{
    public class ESmmTransactions : IESmmTransactions
    {

        IEdmESmmLogin _login;
        ESmmEDMPortClient _client;
        IFaturaCrud _faturaCrud;

        public ESmmTransactions(IEdmESmmLogin login, ESmmEDMPortClient client,IFaturaCrud faturaCrud)
        {
            _login = login;
            _client = client;
            _faturaCrud = faturaCrud;
        }


        public async Task<ResultLoginInfo> GetLoginInfo(Guid FirmaId)
        {
            var result = await _login.Ef_LoginEdm(FirmaId);
            return result;
        } 

        public async Task<string> GetInvoiceForView(string xmlInvoice, byte[] design)
        {

            XslCompiledTransform transform = new XslCompiledTransform();
            using (XmlReader reader = XmlReader.Create(new StringReader(Encoding.UTF8.GetString(design))))
            {
                transform.Load(reader);
            }
            StringWriter results = new StringWriter();
            using (XmlReader reader = XmlReader.Create(new StringReader(xmlInvoice)))
            {
                transform.Transform(reader, null, results);
            }

            return results.ToString();
        }

        public async Task<ResultJson> SendeInvoice(FaturaGetAllQueryViewModel invoice, byte[] xmlInvioce)
        {
            var logininfo = await GetLoginInfo(invoice.FirmaId);
            try
            {
                var result = await _client.SendSMMAsync(new SendSMMRequest
                {
                    SMM_CONTENT_TYPE=SMM_CONTENT_TYPE.XML,
                    REQUEST_HEADER = await _login.Ef_CreateHeaderType(logininfo),
                    SENDER = new SendSMMRequestSENDER { alias = invoice.Firmalar.WsGbKodu, vkn = invoice.Firmalar.VergiNumarasi },
                    RECEIVER = new SendSMMRequestRECEIVER { vkn = invoice.Cariler.VergiNumarasi, alias = invoice.Cariler.Email },
                    SMM =  await CreateSmm(invoice,xmlInvioce)
                });

                return new ResultJson { Success = true, Message = string.Format("{0} Nolu {1} Faturası Portala Yüklendi.", invoice.FaturaNumarasi, invoice.Cariler.Unvani) };
            }
            catch (System.ServiceModel.FaultException<REQUEST_ERRORType> ex)
            {
                return new ResultJson { Success = false, Message = string.Format("Fatura Yüklenirken Hata Oluştu Hata Kodu : {0}. Açıklama:{1}", ex.Detail.ERROR_CODE, ex.Detail.ERROR_LONG_DES) };
            }
        }

        public async Task<ResultJsonWithData<ResultInvoiceStatus>> GetInvoiceStatus(Guid FirmaId,Guid invoiceId)
        {
 
            var logininfo = await GetLoginInfo(FirmaId);
            try
            {
                var invoiceStatusResult = await _client.GetSMMStatusAsync(new GetSMMStatusRequest { SMM = new SMM { UUID = invoiceId.ToString() }, REQUEST_HEADER = await _login.Ef_CreateHeaderType(logininfo) });
                return new ResultJsonWithData<ResultInvoiceStatus> { Success = true, Data = await UpdateInvoiceStatus(invoiceId, invoiceStatusResult.GetSMMStatusResponse.SMM_STATUS) };
            }
            catch (System.ServiceModel.FaultException<REQUEST_ERRORType> ex)
            {
                return new ResultJsonWithData<ResultInvoiceStatus> { Success = false, Data = null, Message = ex.Message };
            }
        }

        public async Task<ResultInvoiceStatus> UpdateInvoiceStatus(Guid invoiceId,GetSMMStatusResponseSMM_STATUS status)
        {
            var result  = new ResultInvoiceStatus();
            result.InvoiceNumber = status.ID;
            result.Uuid = Guid.Parse(status.UUID);
            switch (status.STATUS)
            {
                case "SEND - SUCCEED":
                    result.Message = "E-Smm Gönderildi..(Tamamlandı)";
                    result.EfaturaDurum = Models.Enum.EfaturaDurum.Gonderildi;
                    result.Icon = "fas fa fa-check-circle"; 
                    break;
                case "SEND - PROCESSING":
                    result.Message = "E-Smm Portala Yüklendi..(Kuyruğa Alındı İşlenmesi Bekleniyor..)";
                    result.EfaturaDurum = Models.Enum.EfaturaDurum.Yuklendi;
                    result.Icon = "fas fa-angle-up text-warning";
                    break;
                case "LOAD - SUCCEED":
                    result.Message = "E-Smm Portala Yüklendi..(Gib'e Gönderilmesi Bekleniyor)";
                    result.EfaturaDurum = Models.Enum.EfaturaDurum.Yuklendi;
                    result.Icon = "fas fa-angle-double-up text-primary";
                    break;
                case "SEND - FAILED":
                    result.Message = "E-Smm Gönderimi Hatalı !";
                    result.EfaturaDurum = Models.Enum.EfaturaDurum.Beklemede;
                    result.Icon = "fas fa-exclamation-circle text-danger";
                    result.Error = true;
                    break;
                case "CANCELLED - SUCCEED":
                    result.Message = "E-Smm Portaldan İptal Edilmiş!";
                    result.EfaturaDurum = Models.Enum.EfaturaDurum.Iptal;
                    result.Icon = "fas  fa-window-close text-secondery";
                    break;
                case "PACKAGE - FAILED":
                    result.Message = "Gönderim Kontrol Ediliyor..";
                    result.EfaturaDurum = Models.Enum.EfaturaDurum.Yuklendi;
                    result.Icon = "fas fa-angle-up text-warning";
                    break;
            }

            var resultUpdate = await _faturaCrud.UpdateInvoiceStatus(invoiceId, result.EfaturaDurum);

            return result;
        }

        public async Task<ResultJsonWithData<ResultInvoiceStatus>> CancelInvoice(Guid FirmaId, Guid invoiceId)
        {
            var logininfo = await GetLoginInfo(FirmaId);
            try
            {
                var invoiceCancelResult = await _client.CancelSMMAsync(new CancelSMMRequest { SMM = new[] { new SMM { UUID = invoiceId.ToString() } }, REQUEST_HEADER = await _login.Ef_CreateHeaderType(logininfo) });
                return new ResultJsonWithData<ResultInvoiceStatus> { Success = true,  Message = invoiceCancelResult.CancelSMMResponse.REQUEST_RETURN.RETURN_CODE.ToString(), Data = null };
            }
            catch (System.ServiceModel.FaultException<REQUEST_ERRORType> ex)
            {
                return new ResultJsonWithData<ResultInvoiceStatus> { Success = false, Data = null, Message = ex.Message };
            }
        }

        public async  Task<SMM []> CreateSmm(FaturaGetAllQueryViewModel inv, byte[] xmlInvioce)
        {
            List<SMM> smm = new List<SMM>();
            List<SMMSMM_LINE_ITEMS> items = new List<SMMSMM_LINE_ITEMS>();

            foreach (var x in inv.FaturaSatir)
            {
                SMMSMM_LINE_ITEMS line = new SMMSMM_LINE_ITEMS();
                line.FEE_REASON = x.Aciklama;
                line.GROSS_AMOUNT = x.KdvliTutar;
                line.STOPPAGE_RATE = x.StopajOran;
                line.NET_AMOUNT = x.Tutar;
                line.TAX_RATE = x.KdvOran;
                line.NET_REVENUE = x.KdvliTutar;
                if (!string.IsNullOrEmpty(x.TevkifatKodu))
                {
                    line.WITHHOLDING_TAX_CODE = x.TevkifatKodu;
                    line.WITHHOLDING_TAX_RATE = 0; //ToDo:Tevkifat Oranı
                }
                items.Add(line);
            }

            SMM sm = new SMM();

            sm.CURRENCY_CODE = "TRY";
            sm.UUID = inv.Id.ToString();
            sm.ID = inv.FaturaNumarasi;

            sm.SUPPLIER_NAME = inv.Cariler.Unvani;
            sm.SUPPLIER_ADRESS = inv.Cariler.Adres;
            sm.SUPPLIER_CITY = inv.Cariler.Sehir;
            sm.SUPPLIER_COUNTY = inv.Cariler.Ilce;
            sm.SUPPLIER_EMAIL = inv.Cariler.Email;
            sm.SUPPLIER_TAX_OFFICE = inv.Cariler.VergiDairesi;
            sm.SUPPLIER_COUNTRY = inv.Cariler.Ulke;

            sm.SMM_LINE_ITEMS = items.ToArray();

            var header = new SMMHEADER();


            header.SENDER = inv.Firmalar.VergiNumarasi;
            header.RECEIVER = inv.Cariler.VergiNumarasi;
            header.TO = inv.Firmalar.WsGbKodu;
            header.SMM_DATE = inv.Tarih;

            sm.HEADER = header;

            EdmEsmm.base64Binary base64Binary = new EdmEsmm.base64Binary();
            base64Binary.Value = xmlInvioce; //Encoding.UTF8.GetBytes(esmmtaslak);
            base64Binary.contentType = "application/xml";

            sm.CONTENT = base64Binary;


            smm.Add(sm);

            return smm.ToArray();
        }

    }
}
