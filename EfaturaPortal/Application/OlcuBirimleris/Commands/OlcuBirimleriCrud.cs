using AutoMapper;
using EfaturaPortal.Application.OlcuBirimleris.ViewModels;
using EfaturaPortal.Application.Interfaces.OlcuBirimleris;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models.Enum;

namespace EfaturaPortal.Application.OlcuBirimleris.Commands
{
    public class OlcuBirimleriCrud : IOlcuBirimleriCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public OlcuBirimleriCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }



        public async Task<List<OlcuBirimleriGetAllQueryViewModel>> GetAll()
        {


            var data = context.OlcuBirimleris.ToList().OrderBy(o => o.Adi);

            var result = mapper.Map<List<OlcuBirimleriGetAllQueryViewModel>>(data);

            return result;


        }








    }
}
