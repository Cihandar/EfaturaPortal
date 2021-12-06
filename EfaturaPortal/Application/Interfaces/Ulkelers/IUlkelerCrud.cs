using EfaturaPortal.Application.Ulkelers.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.Ulkelers
{
    public interface IUlkelerCrud
    {
        Task<List<UlkelerGetAllQueryViewModel>> GetAll();
    }
}
