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
using EfaturaPortal.Application.FaturaSatirKdvlers.ViewModels;

namespace EfaturaPortal.Application.FaturaSatirs.ViewModels
{
    public class FaturaSatirCreateViewModel : IHaveCustomMapping
    {
        public Guid Id { get; set; }
        public Guid FaturaId { get; set; }
        public int Sirano { get; set; }
        public string Aciklama { get; set; }
        public string Miktar { get; set; }
        public int OlcuBirimleriId { get; set; }
        public string BirimFiyat { get; set; }
        public string Tutar { get; set; }
        public string IskontoDurum { get; set; }
        public string IskontoOran { get; set; }
        public string IskontoTutar { get; set; }
        public string StopajOran { get; set; }
        public string StopajTutar { get; set; }
        public string KdvOran { get; set; }
        public string KdvTutar { get; set; }
        public string KdvliTutar { get; set; }
        public string TevkifatTutar { get; set; }
        public string TevkifatOran { get; set; }
        public string TevkifatKodu { get; set; }
        public string TevkifatAdi { get; set; }
        public string IstisnaKodu { get; set; }
        public string IstisnaAciklama { get; set; }

        public OlcuBirimleri OlcuBirimleri{ get; set; }

        public IstisnaKodlari IstisnaKodlari { get; set; }

        public  List<FaturaSatirKdvler> FaturaSatirKdvler  { get; set; }

        public List<OlcuBirimleriGetAllQueryViewModel> LstOlcuBirimleri { get; set; }
        public List<IstisnaKodlariGetAllQueryViewModel> LstIstisnaKodlari { get; set; }
        public List<TevkifatKodlariGetAllQueryViewModel> LstTevkifatKodlari { get; set; }

        public List<VergiKodlariGetAllQueryViewModel> LstVergiKodlari { get; set; }

        public List<FaturaSatirKdvlerCreateViewModel> Kdvler { get; set; }

        public void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<FaturaSatirCreateViewModel, FaturaSatir>();
            configuration.CreateMap<FaturaSatir, FaturaSatirCreateViewModel>();
        }
    }
}
