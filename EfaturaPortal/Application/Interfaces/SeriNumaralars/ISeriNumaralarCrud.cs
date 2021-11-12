using EfaturaPortal.Application.SeriNumaralars.ViewModels;
using EfaturaPortal.Extentions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.SeriNumaralars
{


    public interface ISeriNumaralarCrud
    {
        Task<List<SeriNumaralarGetAllQueryViewModel>> GetAll(Guid FirmaId);
        Task<SeriNumaralarGetAllQueryViewModel> GetById(Guid Id);
        Task<ResultJson> Update(SeriNumaralarGetAllQueryViewModel modelvw);
        Task<ResultJson> Add(SeriNumaralarGetAllQueryViewModel modelvw);

    }
}
