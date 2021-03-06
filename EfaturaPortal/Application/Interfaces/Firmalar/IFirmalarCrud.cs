using EfaturaPortal.Application.Firmalars.ViewModels;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models.ResultModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
 

namespace EfaturaPortal.Application.Interfaces.Firmalar
{


    public interface IFirmalarCrud
    {
        Task<List<FirmalarGetAllQueryViewModel>> GetAll(Guid FirmaId);
        Task<FirmalarGetAllQueryViewModel> GetById(Guid FirmaId);
        Task<ResultJson> Update(FirmalarGetAllQueryViewModel firmavw);
        Task<ResultJsonWithData<EfaturaPortal.Models.Firmalar>> Add(FirmalarGetAllQueryViewModel firmavw);
    }
}
