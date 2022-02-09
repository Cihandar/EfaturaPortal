using EfaturaPortal.Application.Faturas.ViewModels;
using EfaturaPortal.Models.EfaturaModel;
using EfaturaPortal.Models.ResultModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.EfaturaApis
{
    public interface IEInvoiceTransactions
    {
        Task<CheckUserResult> Ef_GetEInvoiceMailBox(Guid FirmaId, string taxNumber);
        Task<string> GetInvoiceForView(string xmlInvoice, byte[] design);
        Task<ResultJson> SendeInvoice(FaturaGetAllQueryViewModel invoice, byte[] xmlInvioce);
        Task<ResultJsonWithData<ResultInvoiceStatus>> GetInvoiceStatus(Guid FirmaId, Guid invoiceId);
    }
}
