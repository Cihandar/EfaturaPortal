using AutoMapper;
using EfaturaPortal.Application.TevkifatKodlaris.ViewModels;
using EfaturaPortal.Application.Interfaces.TevkifatKodlaris;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models.Enum;

namespace EfaturaPortal.Application.TevkifatKodlaris.Commands
{
    public class TevkifatKodlariCrud : ITevkifatKodlariCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public TevkifatKodlariCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }



        public async Task<List<TevkifatKodlariGetAllQueryViewModel>> GetAll()
        {


            var data = context.TevkifatKodlaris.ToList().OrderBy(o => o.Kodu);

            var result = mapper.Map<List<TevkifatKodlariGetAllQueryViewModel>>(data);

            return result;


        }

    }
}
