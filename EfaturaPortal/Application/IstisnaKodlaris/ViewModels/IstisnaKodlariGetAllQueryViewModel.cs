using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.IstisnaKodlaris.ViewModels
{
    public class IstisnaKodlariGetAllQueryViewModel : IHaveCustomMapping
    {

        public string Kodu { get; set; }
        public string Aciklama { get; set; }


        public  void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<IstisnaKodlariGetAllQueryViewModel, IstisnaKodlari>();
            configuration.CreateMap<IstisnaKodlari, IstisnaKodlariGetAllQueryViewModel>();
        }
    }
}
