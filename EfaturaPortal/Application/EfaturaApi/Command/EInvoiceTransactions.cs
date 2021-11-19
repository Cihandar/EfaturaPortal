using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.EfaturaApi.Authorization;
using EfaturaPortal.Models;
using EfaturaPortal.Models.EfaturaModel;
using EdmEfatura;

namespace EfaturaPortal.Application.EfaturaApi.Command
{
    public class EInvoiceTransactions
    {
        EdmEInvoiceLogin _login;
        EFaturaEDMPortClient _client;

        public EInvoiceTransactions(EdmEInvoiceLogin login, EFaturaEDMPortClient client)
        {
            _login = login;
            _client = client;
        }


        public async Task<CheckUserResult> Ef_GetEInvoiceMailBox(LoginInfo loginInfo, string taxNumber)
        {
            var ChekUser = new CheckUserRequest
            {
                REQUEST_HEADER = await _login.Ef_CreateHeaderType(loginInfo),
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
