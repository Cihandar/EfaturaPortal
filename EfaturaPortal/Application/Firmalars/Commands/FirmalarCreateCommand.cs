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

namespace EfaturaPortal.Application.Firmalars.Commands
{
    public class FirmalarCreateCommand : Controller
    {

        public EfaturaPortalContext context;
        public IMapper mapper;
        public ResultJson result;

        public  FirmalarCreateCommand(EfaturaPortalContext _context,IMapper _mapper,ResultJson _result)
        {
            context = _context;
            mapper = _mapper;
            result = _result;

        }

        public JsonResult Add(FirmalarGetAllQueryViewModel firmavw)
        {
            try
            {
                var firma = mapper.Map<Firmalar>(firmavw);

                context.Firmalars.Add(firma);
                context.SaveChanges();

                result.Result = true;
                result.Explanation = "Kayıt Başarılı";

            }
            catch (Exception ex)
            {
                result.Result = false;
                result.Explanation = "Hata : " + ex.Message;
            }

            return  Json(result);
        }


    }


}
