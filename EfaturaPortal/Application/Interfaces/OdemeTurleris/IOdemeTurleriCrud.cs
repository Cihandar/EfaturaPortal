using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.OdemeTurleris.ViewModels;

namespace EfaturaPortal.Application.Interfaces.OdemeTurleris
{
   public interface IOdemeTurleriCrud
    {
        Task<List<OdemeTurleriGetAllQueryViewModel>> GetAll();
    }
}
