using EfaturaPortal.Application.SeriNumaralars.ViewModels;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models.Enum;
using EfaturaPortal.Models.ResultModel;
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
        Task<List<SeriNumaralarGetAllQueryViewModel>> GetSeriNumaraByFaturaTuru(FaturaTuru faturaTuru, Guid FirmaId,int Yil);
        Task<ResultJson> GetLastInvoiceNumberAndUpdate(Guid FirmaId, string SeriNo, int Yil, FaturaTuru faturaTuru,DateTime Tarih);
    }
}
