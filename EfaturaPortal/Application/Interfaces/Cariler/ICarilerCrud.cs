using EfaturaPortal.Application.Carilers.ViewModels;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models.ResultModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.Cariler
{


    public interface ICarilerCrud
    {
        Task<List<CarilerGetAllQueryViewModel>> GetAll(Guid FirmaId);
        Task<CarilerGetAllQueryViewModel> GetById(Guid Id);
        Task<ResultJson> Update(CarilerGetAllQueryViewModel modelvw);
        Task<ResultJson> Add(CarilerGetAllQueryViewModel modelvw);
        Task<CarilerGetAllQueryViewModel> GetCaribyTaxNumber(string TaxNumber);
    }
}
