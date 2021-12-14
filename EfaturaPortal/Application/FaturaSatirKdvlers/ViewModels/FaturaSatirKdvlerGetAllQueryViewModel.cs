using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
 


namespace EfaturaPortal.Application.FaturaSatirKdvlers.ViewModels
{
    public class FaturaSatirKdvlerGetAllQueryViewModel : IHaveCustomMapping
    {
        public int Id { get; set; }
        public Guid FaturaSatirId { get; set; }
        public string Kodu { get; set; }
        public string Adi { get; set; }
        public double KdvOran { get; set; }
        public double KdvTutar { get; set; }



        public void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<FaturaSatirKdvlerGetAllQueryViewModel, FaturaSatirKdvler>();
            configuration.CreateMap<FaturaSatirKdvler, FaturaSatirKdvlerGetAllQueryViewModel>();
        }
    }
}
