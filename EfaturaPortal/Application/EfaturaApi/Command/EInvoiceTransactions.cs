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

 

    }
}
