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
    public class FaturaSatirGetAllQueryViewModel : IHaveCustomMapping
    {
        public Guid Id { get; set; }
        public Guid FaturaId { get; set; }
        public int Sirano { get; set; }
        public string Aciklama { get; set; }
        public float Miktar { get; set; }
        public string OlcuBirimi { get; set; }
        public float BirimFiyat { get; set; }
        public float Tutar { get; set; }

        public string IskontoDurum { get; set; }
        public float IskontoOran { get; set; }
        public float IskontoTutar { get; set; }

        public float KdvOran { get; set; }
        public float KdvTutar { get; set; }

        public float KdvliTutar { get; set; }


        public float TevkifatTutar { get; set; }
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

        public List<FaturaSatirKdvlerGetAllQueryViewModel> Kdvler { get; set; }

        public void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<FaturaSatirGetAllQueryViewModel, FaturaSatir>();
            configuration.CreateMap<FaturaSatir, FaturaSatirGetAllQueryViewModel>();
        }
    }
}
