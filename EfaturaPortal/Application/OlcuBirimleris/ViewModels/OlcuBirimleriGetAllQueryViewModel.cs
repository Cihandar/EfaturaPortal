using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.OlcuBirimleris.ViewModels
{
    public class OlcuBirimleriGetAllQueryViewModel : IHaveCustomMapping
    {
        public int Id { get; set; }
        public string Kodu { get; set; }
        public string Adi { get; set; }


        public  void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<OlcuBirimleriGetAllQueryViewModel, OlcuBirimleri>();
            configuration.CreateMap<OlcuBirimleri, OlcuBirimleriGetAllQueryViewModel>();
        }
    }
}
