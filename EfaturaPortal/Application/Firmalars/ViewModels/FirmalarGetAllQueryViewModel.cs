using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Firmalars.ViewModels
{
    public class FirmalarGetAllQueryViewModel : IHaveCustomMapping
    {

        public Guid Id { get; set; }
        public string Unvani { get; set; }
        public string VergiDairesi { get; set; }
        public string VergiNumarasi { get; set; }
        public string YetkiliAdSoyad { get; set; }
        public string Adres { get; set; }
        public string Sehir { get; set; }
        public string Ilce { get; set; }
        public string PostaKodu { get; set; }
        public string Email { get; set; }
        public string Telefon { get; set; }
        public FirmaTuru FirmaTuru { get; set; }

        public  void CreateMappings(Profile configuration)
        {

        }
    }
}
