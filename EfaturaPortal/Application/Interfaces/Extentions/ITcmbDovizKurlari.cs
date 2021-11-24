using EfaturaPortal.Extentions;
using EfaturaPortal.Models.ResultModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.Extentions
{
   public interface ITcmbDovizKurlari
    {
        Task<ResultJson> DovizKuruAl(string DovizKodu, string _tarih);
    }
}
