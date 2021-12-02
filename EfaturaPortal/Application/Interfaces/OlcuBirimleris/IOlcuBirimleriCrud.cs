using EfaturaPortal.Application.OlcuBirimleris.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.OlcuBirimleris
{
   public interface IOlcuBirimleriCrud
    {
        Task<List<OlcuBirimleriGetAllQueryViewModel>> GetAll();
    }
}
