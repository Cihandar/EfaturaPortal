using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.OdemeTurleris.ViewModels
{
    public class OdemeTurleriGetAllQueryViewModel : IHaveCustomMapping
    {

        public string Kodu { get; set; }
        public string Adi { get; set; }
 


        public  void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<OdemeTurleriGetAllQueryViewModel, OdemeTurleri>();
            configuration.CreateMap<OdemeTurleri, OdemeTurleriGetAllQueryViewModel>();
        }
    }
}
