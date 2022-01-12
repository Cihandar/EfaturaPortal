using EfaturaPortal.Application.Faturas.ViewModels;
using EfaturaPortal.Application.FaturaSatirs.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.EfaturaApis
{
   public interface ICreateUbl
    {
        Task<string> Create(FaturaGetAllQueryViewModel faturaVM, List<KdvlerViewModel> kdvler);
    }
}
