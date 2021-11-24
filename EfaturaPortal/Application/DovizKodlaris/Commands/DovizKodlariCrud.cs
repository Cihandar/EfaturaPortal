using AutoMapper;
using EfaturaPortal.Application.DovizKodlaris.ViewModels;
using EfaturaPortal.Application.Interfaces.DovizKodlaris;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models.Enum;

namespace EfaturaPortal.Application.DovizKodlaris.Commands
{
    public class DovizKodlariCrud : IDovizKodlariCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public DovizKodlariCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }
        
 

        public async Task<List<DovizKodlariGetAllQueryViewModel>> GetAll()
        {


            var data = context.DovizKodlaris.ToList();

            var result = mapper.Map<List<DovizKodlariGetAllQueryViewModel>>(data);

            return  result;


        }

 
 





    }
}
