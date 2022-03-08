using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.Carilers.ViewModels;
using EdmEfatura;

namespace EfaturaPortal.Models.EfaturaModel
{
    public class CheckUserResult
    {
        public bool Success { get; set; }
        public string ErrorCode { get; set; }
        public string ErrorMessage { get; set; }
        public List<GIBUSER> GibUser { get; set; }        
        public CarilerGetAllQueryViewModel Cari { get; set; }
        public string UserType { get; set; }

    }
}
