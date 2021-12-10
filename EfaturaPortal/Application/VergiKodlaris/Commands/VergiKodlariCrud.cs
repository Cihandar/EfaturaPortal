using AutoMapper;
using EfaturaPortal.Application.VergiKodlaris.ViewModels;
using EfaturaPortal.Application.Interfaces.VergiKodlaris;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models.Enum;

namespace EfaturaPortal.Application.VergiKodlaris.Commands
{
    public class VergiKodlariCrud : IVergiKodlariCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public VergiKodlariCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }



        public async Task<List<VergiKodlariGetAllQueryViewModel>> GetAll()
        {


            var data = context.VergiKodlaris.ToList().OrderBy(o => o.Kodu);

            var result = mapper.Map<List<VergiKodlariGetAllQueryViewModel>>(data);

            return result;


        }

    }
}
