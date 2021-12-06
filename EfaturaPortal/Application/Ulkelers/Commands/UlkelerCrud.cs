using AutoMapper;
using EfaturaPortal.Application.Ulkelers.ViewModels;
using EfaturaPortal.Application.Interfaces.Ulkelers;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models.Enum;

namespace EfaturaPortal.Application.Ulkelers.Commands
{
    public class UlkelerCrud : IUlkelerCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public UlkelerCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }



        public async Task<List<UlkelerGetAllQueryViewModel>> GetAll()
        {


            var data = context.Ulkelers.ToList().OrderBy(o => o.Oncelik);

            var result = mapper.Map<List<UlkelerGetAllQueryViewModel>>(data);

            return result;


        }

    }
}
