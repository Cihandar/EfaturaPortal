using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.EfaturaApi.Authorization;
using EfaturaPortal.Models;
using EfaturaPortal.Models.EfaturaModel;
using EdmEfatura;
using EfaturaPortal.Application.Interfaces.EfaturaApis;
using EfaturaPortal.Extentions;
using System.Xml.Xsl;
using System.Xml;
using System.IO;
using System.Text;
using EfaturaPortal.Models.ResultModel;
using EfaturaPortal.Application.Faturas.ViewModels;


namespace EfaturaPortal.Application.EfaturaApi.Command
{
    public class EInvoiceTransactions : IEInvoiceTransactions
    {

        IEdmEInvoiceLogin _login;
        EFaturaEDMPortClient _client;


        public EInvoiceTransactions(IEdmEInvoiceLogin login, EFaturaEDMPortClient client)
        {
            _login = login;
            _client = client;
        }


        public async Task<ResultLoginInfo> GetLoginInfo(Guid FirmaId)
        {
            var result = await _login.Ef_LoginEdm(FirmaId);
            return result;
        }

        public async Task<CheckUserResult> Ef_GetEInvoiceMailBox(Guid FirmaId, string taxNumber)
        {

            var logininfo = await GetLoginInfo(FirmaId);

            if (!logininfo.Success) return new CheckUserResult { Success = false, ErrorMessage = logininfo.ErrorMessagge };


            var ChekUser = new CheckUserRequest
            {
                REQUEST_HEADER = await _login.Ef_CreateHeaderType(logininfo),
                USER = new GIBUSER { IDENTIFIER = taxNumber, UNIT = "PK" }
            };

            try
            {
                var result = await _client.CheckUserAsync(ChekUser);

                if (result.CheckUserResponse.Length > 0)
                {
                    return new CheckUserResult
                    {
                        Success = true,
                        GibUser = result.CheckUserResponse.ToList<GIBUSER>()
                    };
                }
                else
                {
                    return new CheckUserResult { Success = false, ErrorCode = "E-Archive" };
                }

            }
            catch (System.ServiceModel.FaultException<REQUEST_ERRORType> ex)
            {
                return new CheckUserResult { Success = false, ErrorCode = ex.Detail.ERROR_CODE.ToString(), ErrorMessage = ex.Detail.ERROR_LONG_DES };
            }
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
                var result = await _client.SendInvoiceAsync(new SendInvoiceRequest
                {
                    REQUEST_HEADER = await _login.Ef_CreateHeaderType(logininfo),
                    SENDER = new SendInvoiceRequestSENDER { alias = invoice.Firmalar.WsGbKodu, vkn = invoice.Firmalar.VergiNumarasi },
                    RECEIVER = new SendInvoiceRequestRECEIVER { vkn = invoice.Cariler.VergiNumarasi, alias = invoice.Cariler.EfaturaPostaKutusu },
                    INVOICE = new[] { new INVOICE { 
                        ID=invoice.FaturaNumarasi, 
                        UUID = invoice.Id.ToString(),
                        HEADER = new INVOICEHEADER { SENDER = invoice.Firmalar.VergiNumarasi,RECEIVER = invoice.Cariler.VergiNumarasi, FROM = invoice.Firmalar.WsGbKodu, EARCHIVE=false,INTERNETSALES=false },
                        CONTENT = new EdmEfatura.base64Binary { contentType="XML",Value=xmlInvioce }
                    } }
                });

                return new ResultJson { Success = true, Message = string.Format("{0} Nolu {1} Faturası Portala Yüklendi.", invoice.FaturaNumarasi, invoice.Cariler.Unvani) };
            }
            catch (System.ServiceModel.FaultException<REQUEST_ERRORType> ex)
            {
                return new ResultJson { Success = false, Message = string.Format("Fatura Yüklenirken Hata Oluştu Hata Kodu : {0}. Açıklama:{1}", ex.Detail.ERROR_CODE, ex.Detail.ERROR_LONG_DES) };
            }
        }


    }
}
