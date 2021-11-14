using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.SeriNumaralars.ViewModels
{
    public class SeriNumaralarGetAllQueryViewModel : IHaveCustomMapping
    {

        public Guid Id { get; set; }
        public FaturaTuru FaturaTuru { get; set; }
        public string SeriNo { get; set; }
        public int SonFaturaNo { get; set; }
        public DateTime SonFaturaTarihi { get; set; }
        public int Oncelik { get; set; }
        public string SablonAdi { get; set; }
        public string SablonDosyaAdi { get; set; }
        public Guid FirmaId { get; set; }

        public  void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<SeriNumaralarGetAllQueryViewModel, SeriNumaralar>();
            configuration.CreateMap<SeriNumaralar, SeriNumaralarGetAllQueryViewModel>();
        }
    }
}
