using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.FaturaSatirs.ViewModels
{
    public class KdvlerViewModel : IHaveCustomMapping
    {

        public string Kodu { get; set; }
        public string Adi { get; set; }
        public float KdvOran { get; set; }
        public float KdvTutar { get; set; }
        public float Tutar { get; set; }
        public string TevkifatKodu { get; set; }
        public string TevkifatAdi { get; set; }
        public string TevkifatOran { get; set; }
        public float TevkifatTutar { get; set; }
        public string IstisnaKodu { get; set; }
        public string IstisnaAciklama { get; set; }
        public void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<KdvlerViewModel, FaturaSatir>();
            configuration.CreateMap<FaturaSatir, FaturaSatirGetAllQueryViewModel>();
        }

    }
}
