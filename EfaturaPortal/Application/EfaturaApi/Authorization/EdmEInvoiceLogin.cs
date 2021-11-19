using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EdmEfatura;
using EfaturaPortal.Models.EfaturaModel;
using EfaturaPortal.Application.Firmalars.ViewModels;
using EfaturaPortal.Extentions;

namespace EfaturaPortal.Application.EfaturaApi.Authorization
{
    public class EdmEInvoiceLogin
    {
        EFaturaEDMPortClient _client;
        public EdmEInvoiceLogin(EFaturaEDMPortClient client)
        {
            _client = client;
        }
        public async Task<REQUEST_HEADERType> Ef_CreateHeaderType(LoginInfo _logininfo)
        {
            var HeaderType = new REQUEST_HEADERType
            {
                ACTION_DATE = DateTime.Now,
                ACTION_DATESpecified = true,
                APPLICATION_NAME = "AlzeEPortal",
                CHANNEL_NAME = _logininfo.FirmaAdi,
                HOSTNAME = Environment.MachineName,
                REASON = "CANLI",
                COMPRESSED = "N",
                CLIENT_TXN_ID = Guid.NewGuid().ToString(),
                SESSION_ID = _logininfo.SessionId
            };

            return HeaderType;
 
        }

        public async Task<ResultLoginInfo> Ef_LoginEdm(FirmalarGetAllQueryViewModel _firma)
        {
            try
            {
                var login = new LoginRequest
                {
                    USER_NAME = _firma.WsKullaniciAdi,
                    PASSWORD = _firma.WsSifre,
                    REQUEST_HEADER = await Ef_CreateHeaderType(new LoginInfo { SessionId = null, FirmaAdi = _firma.Unvani })
                };

                var result = await _client.LoginAsync(login);

                return new ResultLoginInfo { Success = true, SessionId = result.LoginResponse.SESSION_ID };


            }
            catch (System.ServiceModel.FaultException<REQUEST_ERRORType> ex)
            {

                return new ResultLoginInfo { Success = false, SessionId = null, ErrorMessagge = ex.Detail.ERROR_CODE + " - " + ex.Detail.ERROR_LONG_DES };
            }
        }
    }
}
