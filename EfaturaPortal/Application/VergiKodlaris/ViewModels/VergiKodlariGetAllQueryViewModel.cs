using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.VergiKodlaris.ViewModels
{
    public class VergiKodlariGetAllQueryViewModel : IHaveCustomMapping
    {

        public string Kodu { get; set; }
        public string Adi { get; set; }
        public string Kisaltma { get; set; }


        public  void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<VergiKodlariGetAllQueryViewModel, VergiKodlari>();
            configuration.CreateMap<VergiKodlari, VergiKodlariGetAllQueryViewModel>();
        }
    }
}
