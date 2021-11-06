using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models;
using Microsoft.AspNetCore.Mvc;
using EfaturaPortal.Application.Firmalars;
using EfaturaPortal.Application.Firmalars.ViewModels;
using AutoMapper;
using EfaturaPortal.Extentions;
using EfaturaPortal.Application.Firmalars.ViewModels;
using EfaturaPortal.Application.Interfaces.Firmalar;

namespace EfaturaPortal.Application.Firmalars.Queries
{
    //TODO:Data CRUD islemlerinde Controller gerek yok 
    //TODO:async methodlar eklenebilir
    public class FirmalarGetQuery : Controller,IFirmalarGetQuery
    {
        public EfaturaPortalContext context;
        public IMapper mapper;
 

        public FirmalarGetQuery(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
 
        }


        public List<FirmalarGetAllQueryViewModel> GetAll(Guid FirmaId)
        {
            var firma = context.Firmalars.Where(x => x.Id == FirmaId).ToList();

            return mapper.Map<List<FirmalarGetAllQueryViewModel>>(firma);
            //TODO:Return bolumleri bir degisken icerisine atilip gonderilecek Exp : return result; map işlemi return içerisinde yapilmicak

        }


        public FirmalarGetAllQueryViewModel GetById(Guid FirmaId)
        {
            var firma = context.Firmalars.Where(x => x.Id == FirmaId).FirstOrDefault();

            return mapper.Map<FirmalarGetAllQueryViewModel>(firma);

        }



    }
}
