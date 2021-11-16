using AutoMapper;
using EfaturaPortal.Application.Interfaces.Mapping;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Auths.ViewModels
{
    public class AuthGetAllViewModel : IHaveCustomMapping
    {
        public Guid Id { get; set; }
        public string Email { get; set; }
        public string Sifre { get; set; }
        public string AdSoyad { get; set; }
        public Guid FirmaId { get; set; }
        public string PhoneNumber { get; set; }

        public void CreateMappings(Profile configuration)
        {
            configuration.CreateMap<AuthGetAllViewModel, AppUser>();
            configuration.CreateMap<AppUser, AuthGetAllViewModel>();
        }
    }
}
