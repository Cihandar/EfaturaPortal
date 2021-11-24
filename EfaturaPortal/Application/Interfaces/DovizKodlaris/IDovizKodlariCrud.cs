using EfaturaPortal.Application.DovizKodlaris.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.DovizKodlaris
{
   public interface IDovizKodlariCrud
    {
        Task<List<DovizKodlariGetAllQueryViewModel>> GetAll();
    }
}
