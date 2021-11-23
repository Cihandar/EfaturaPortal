using EfaturaPortal.Models.EfaturaModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.EfaturaApis
{
    public interface IEInvoiceTransactions
    {
        Task<CheckUserResult> Ef_GetEInvoiceMailBox(Guid FirmaId, string taxNumber);
    }
}
