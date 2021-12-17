using AutoMapper;
using EfaturaPortal.Application.OdemeTurleris.ViewModels;
using EfaturaPortal.Application.Interfaces.OdemeTurleris;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models.Enum;

namespace EfaturaPortal.Application.OdemeTurleris.Commands
{
    public class OdemeTurleriCrud : IOdemeTurleriCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public OdemeTurleriCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }



        public async Task<List<OdemeTurleriGetAllQueryViewModel>> GetAll()
        {


            var data = context.OdemeTurleris.ToList().OrderBy(o => o.Kodu);

            var result = mapper.Map<List<OdemeTurleriGetAllQueryViewModel>>(data);

            return result;


        }

    }
}
