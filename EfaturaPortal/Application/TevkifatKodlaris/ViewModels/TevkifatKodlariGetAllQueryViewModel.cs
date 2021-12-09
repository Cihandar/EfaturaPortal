using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.TevkifatKodlaris.ViewModels
{
    public class TevkifatKodlariGetAllQueryViewModel : IHaveCustomMapping
    {

        public string Kodu { get; set; }
        public string Aciklama { get; set; }
        public string Oran { get; set; }


        public  void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<TevkifatKodlariGetAllQueryViewModel, TevkifatKodlari>();
            configuration.CreateMap<TevkifatKodlari, TevkifatKodlariGetAllQueryViewModel>();
        }
    }
}
