using EfaturaPortal.Application.TevkifatKodlaris.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.TevkifatKodlaris
{
   public interface ITevkifatKodlariCrud
    {
        Task<List<TevkifatKodlariGetAllQueryViewModel>> GetAll();
    }
}
