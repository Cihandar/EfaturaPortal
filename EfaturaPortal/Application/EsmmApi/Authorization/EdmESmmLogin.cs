using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EdmEsmm;
using EfaturaPortal.Models.EfaturaModel;
using EfaturaPortal.Application.Firmalars.ViewModels;
using EfaturaPortal.Extentions;
using EfaturaPortal.Application.Interfaces.EsmmApis;
using EfaturaPortal.Application.Interfaces.Firmalar;


namespace EfaturaPortal.Application.EsmmApi.Authorization
{
    public class EdmESmmLogin : IEdmESmmLogin
    {
        ESmmEDMPortClient _client;
        IFirmalarCrud _firmaCrud;
        public EdmESmmLogin(ESmmEDMPortClient client, IFirmalarCrud firma)
        {
            _client = client;
            _firmaCrud = firma;
        }

        public async Task<REQUEST_HEADERType> Ef_CreateHeaderType(ResultLoginInfo _logininfo)
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



        public async Task<ResultLoginInfo> Ef_LoginEdm(Guid FirmaId)
        {

            var _firma =  await _firmaCrud.GetById(FirmaId);

            if (_firma == null) return new ResultLoginInfo { Success = false, ErrorMessagge = "Firma Bilgileri Veritabanından Çekilemedi!" };

            try
            {
                var login = new LoginRequest
                {
                    USER_NAME = _firma.WsKullaniciAdi,
                    PASSWORD = _firma.WsSifre,
                    REQUEST_HEADER = await Ef_CreateHeaderType(new ResultLoginInfo { SessionId = null, FirmaAdi = _firma.Unvani })
                };

                var result = await _client.LoginAsync(login);

                return new ResultLoginInfo { Success = true, SessionId = result.LoginResponse.SESSION_ID, FirmaAdi = _firma.Unvani };


            }
            catch (System.ServiceModel.FaultException<REQUEST_ERRORType> ex)
            {
                return new ResultLoginInfo { Success = false, SessionId = null, ErrorMessagge = ex.Detail.ERROR_CODE + " - " + ex.Detail.ERROR_LONG_DES };
            }
        }
    }
}
