using EfaturaPortal.Application.VergiKodlaris.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.VergiKodlaris
{
   public interface IVergiKodlariCrud
    {
         Task<List<VergiKodlariGetAllQueryViewModel>> GetAll();
    }
}
