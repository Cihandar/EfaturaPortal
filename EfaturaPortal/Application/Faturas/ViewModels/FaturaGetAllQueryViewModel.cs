using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.SeriNumaralars.ViewModels;
using EfaturaPortal.Application.Carilers.ViewModels;
using EfaturaPortal.Application.DovizKodlaris.ViewModels;

namespace EfaturaPortal.Application.Faturas.ViewModels
{
    public class FaturaGetAllQueryViewModel : IHaveCustomMapping
    {

        public Guid Id { get; set; }
        public Guid FirmaId { get; set; }
        public FaturaTuru FaturaTuru { get; set; }
        public DateTime Tarih { get; set; }
        public string Saat { get; set; }
        public string FaturaNumarasi { get; set; }
        public Guid SeriNumaralarId { get; set; }
 
        public string ParaBirimi { get; set; }
        public double DovizKuru { get; set; }

        public string Doviz { get; set; }

        public Guid CarilerId { get; set; }

        public DateTime OdemeTarihi { get; set; }
        public string OdemeSekli { get; set; }
        public string OdemeKanali { get; set; }
        public string OdemeHesapNo { get; set; }

        public string Notlar { get; set; }

        public string YaziylaTutar { get; set; }

        public double Toplam { get; set; }
        public double Artirim { get; set; }
        public double Iskonto { get; set; }
        public double Kdv { get; set; }
        public double OdenecekTutar { get; set; }

        public FaturaTipi FaturaTipi { get; set; }

        public FaturaSenaryo FaturaSenaryo { get; set; }


        public Guid ETTN { get; set; }
        public EfaturaDurum EfaturaDurum { get; set; }


        public Cariler Cariler { get; set; }

        public List<DovizKodlariGetAllQueryViewModel> DovizKodlari { get; set; }
        public SeriNumaralar SeriNumaralar { get; set; }

        public List<SeriNumaralarGetAllQueryViewModel> SeriNumaralarMwList { get; set; }

        public List<CarilerGetAllQueryViewModel> CarilerMwList { get; set; }

        public  void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<FaturaGetAllQueryViewModel, Fatura>();
            configuration.CreateMap<Fatura, FaturaGetAllQueryViewModel>();
        }
    }
}
