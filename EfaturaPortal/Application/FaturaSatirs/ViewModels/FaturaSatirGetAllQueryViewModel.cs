using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.OlcuBirimleris.ViewModels;
using EfaturaPortal.Application.IstisnaKodlaris.ViewModels;
using EfaturaPortal.Application.TevkifatKodlaris.ViewModels;
using EfaturaPortal.Application.VergiKodlaris.ViewModels;


namespace EfaturaPortal.Application.FaturaSatirs.ViewModels
{
    public class FaturaSatirGetAllQueryViewModel : IHaveCustomMapping
    {
        public Guid Id { get; set; }
        public Guid FaturaId { get; set; }
        public int Sirano { get; set; }
        public string Aciklama { get; set; }
        public double Miktar { get; set; }
        public string OlcuBirimi { get; set; }
        public double BirimFiyat { get; set; }
        public double Tutar { get; set; }

        public string IskontoDurum { get; set; }
        public double IskontoOran { get; set; }
        public int IskontoTutar { get; set; }

        public double KdvOran { get; set; }
        public double KdvTutar { get; set; }

        public double KdvliTutar { get; set; }

        public List<OlcuBirimleriGetAllQueryViewModel> LstOlcuBirimleri { get; set; }
        public List<IstisnaKodlariGetAllQueryViewModel> LstIstisnaKodlari { get; set; }
        public List<TevkifatKodlariGetAllQueryViewModel> LstTevkifatKodlari { get; set; }

        public List<VergiKodlariGetAllQueryViewModel> LstVergiKodlari { get; set; }

        public void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<FaturaSatirGetAllQueryViewModel, FaturaSatir>();
            configuration.CreateMap<FaturaSatir, FaturaSatirGetAllQueryViewModel>();
        }
    }
}
