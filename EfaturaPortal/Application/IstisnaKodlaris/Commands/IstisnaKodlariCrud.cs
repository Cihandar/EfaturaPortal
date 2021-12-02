using AutoMapper;
using EfaturaPortal.Application.IstisnaKodlaris.ViewModels;
using EfaturaPortal.Application.Interfaces.IstisnaKodlaris;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models.Enum;

namespace EfaturaPortal.Application.IstisnaKodlaris.Commands
{
    public class IstisnaKodlariCrud : IIstisnaKodlariCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public IstisnaKodlariCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }
        
 

        public async Task<List<IstisnaKodlariGetAllQueryViewModel>> GetAll()
        {


            var data = context.IstisnaKodlaris.ToList().OrderBy(o=> o.Kodu);

            var result = mapper.Map<List<IstisnaKodlariGetAllQueryViewModel>>(data);

            return  result;


        }

 
 





    }
}
