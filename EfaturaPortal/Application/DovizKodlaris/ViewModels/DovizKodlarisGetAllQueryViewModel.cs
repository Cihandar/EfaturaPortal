using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.DovizKodlaris.ViewModels
{
    public class DovizKodlariGetAllQueryViewModel : IHaveCustomMapping
    {

        public string DovizAdi { get; set; }
        public string DovizKodu { get; set; }


        public  void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<DovizKodlariGetAllQueryViewModel, DovizKodlari>();
            configuration.CreateMap<DovizKodlari, DovizKodlariGetAllQueryViewModel>();
        }
    }
}
