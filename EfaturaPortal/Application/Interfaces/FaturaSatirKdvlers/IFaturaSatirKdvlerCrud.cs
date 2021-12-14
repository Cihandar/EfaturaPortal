using EfaturaPortal.Application.FaturaSatirKdvlers.ViewModels;
using EfaturaPortal.Models;
using EfaturaPortal.Models.ResultModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.FaturaSatirKdvlers
{
    interface IFaturaSatirKdvlerCrud
    {
        Task<ResultJsonWithData<FaturaSatir>> Add(FaturaSatirKdvlerGetAllQueryViewModel FaturaSatirvw);
        Task<List<FaturaSatirKdvlerGetAllQueryViewModel>> GetAll(Guid FaturaSatirId);
        Task<ResultJson> Delete(Guid FaturaSatirId);

    }
}
