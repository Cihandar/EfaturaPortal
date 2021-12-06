using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Ulkelers.ViewModels
{
    public class UlkelerGetAllQueryViewModel : IHaveCustomMapping
    {

        public int Id { get; set; }
        public string UlkeAdi { get; set; }
        public string Alpha2 { get; set; }
        public string Alpha3 { get; set; }
        public string Numeric { get; set; }


        public  void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<UlkelerGetAllQueryViewModel, Ulkeler>();
            configuration.CreateMap<Ulkeler, UlkelerGetAllQueryViewModel>();
        }
    }
}
