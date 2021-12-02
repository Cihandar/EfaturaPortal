using EfaturaPortal.Application.IstisnaKodlaris.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.IstisnaKodlaris
{
   public interface IIstisnaKodlariCrud
    {
        Task<List<IstisnaKodlariGetAllQueryViewModel>> GetAll();
    }
}
