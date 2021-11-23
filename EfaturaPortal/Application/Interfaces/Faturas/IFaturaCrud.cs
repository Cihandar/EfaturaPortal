using EfaturaPortal.Application.Faturas.ViewModels;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.Faturas
{


    public interface IFaturaCrud
    {
        Task<ResultJsonWithData<Fatura>> Add(FaturaGetAllQueryViewModel faturavw);
        Task<ResultJson> Update(FaturaGetAllQueryViewModel faturavw);
        Task<List<FaturaGetAllQueryViewModel>> GetAll(Guid faturaId);
        Task<FaturaGetAllQueryViewModel> GetById(Guid faturaId, Guid FirmaId);

    }
}
