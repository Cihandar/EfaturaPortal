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

namespace EfaturaPortal.Application.Firmalars.Queries
{
    public class FirmalarGetQuery : Controller
    {
        public EfaturaPortalContext context;
        public IMapper mapper;
        public ResultJson result;

        public FirmalarGetQuery(EfaturaPortalContext _context, IMapper _mapper, ResultJson _result)
        {
            context = _context;
            mapper = _mapper;
            result = _result;
        }


        public List<FirmalarGetAllQueryViewModel> GetAll(Guid FirmaId)
        {
            var firma = context.Firmalars.Where(x => x.Id == FirmaId).ToList();

            return mapper.Map<List<FirmalarGetAllQueryViewModel>>(firma);

        }


        public FirmalarGetAllQueryViewModel GetById(Guid FirmaId)
        {
            var firma = context.Firmalars.Where(x => x.Id == FirmaId).FirstOrDefault();

            return mapper.Map<FirmalarGetAllQueryViewModel>(firma);

        }



    }
}
