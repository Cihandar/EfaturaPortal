using EfaturaPortal.Application.FaturaSatirs.ViewModels;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using EfaturaPortal.Models.ResultModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.FaturaSatirs
{


    public interface IFaturaSatirCrud
    {
        Task<ResultJsonWithData<FaturaSatir>> Add(FaturaSatirGetAllQueryViewModel FaturaSatirvw);
        Task<ResultJson> Update(FaturaSatirGetAllQueryViewModel FaturaSatirvw);
        Task<List<FaturaSatirGetAllQueryViewModel>> GetAll(Guid FaturaId);
        Task<FaturaSatirGetAllQueryViewModel> GetById(Guid FaturaSatirId);
        Task<FaturaSatirGetAllQueryViewModel> GetEmptyRow();
        Task<List<KdvlerViewModel>> GetKdv(Guid FaturaId);
    }
}
