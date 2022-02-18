using EfaturaPortal.Application.Faturas.ViewModels;
using EfaturaPortal.Models.EfaturaModel;
using EfaturaPortal.Models.ResultModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.EsmmApis
{
    public interface IESmmTransactions
    {
        Task<string> GetInvoiceForView(string xmlInvoice, byte[] design);
        Task<ResultJson> SendeInvoice(FaturaGetAllQueryViewModel invoice, byte[] xmlInvioce);
        Task<ResultJsonWithData<ResultInvoiceStatus>> GetInvoiceStatus(Guid FirmaId, Guid invoiceId);
        Task<ResultJsonWithData<ResultInvoiceStatus>> CancelInvoice(Guid FirmaId, Guid invoiceId);
    }
}
