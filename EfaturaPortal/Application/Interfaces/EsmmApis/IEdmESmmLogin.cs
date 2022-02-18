using EdmEsmm;
using EfaturaPortal.Application.Firmalars.ViewModels;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models.EfaturaModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.EsmmApis
{
  public  interface IEdmESmmLogin
    {
        Task<REQUEST_HEADERType> Ef_CreateHeaderType(ResultLoginInfo _logininfo);
        Task<ResultLoginInfo> Ef_LoginEdm(Guid FirmaId);
    }
}
