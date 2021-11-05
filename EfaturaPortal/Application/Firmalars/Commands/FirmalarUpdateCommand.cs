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
    public class FirmalarUpdateCommand :Controller
    {

        public EfaturaPortalContext context;
        public IMapper mapper;
        public ResultJson result;

        public  FirmalarUpdateCommand(EfaturaPortalContext _context,IMapper _mapper,ResultJson _result)
        {
            context = _context;
            mapper = _mapper;
            result = _result;
        }

        public JsonResult Update(FirmalarGetAllQueryViewModel firmavw)
        {
            try
            {
                var request = mapper.Map<Firmalar>(firmavw);

                var firma = context.Firmalars.FirstOrDefault(x => x.Id == request.Id);

                firma.Adres = request.Adres;
                firma.Email = request.Email;
                firma.Ilce = request.Ilce;
                firma.PostaKodu = request.PostaKodu;
                firma.Sehir = request.Sehir;
                firma.Telefon = request.Telefon;
                firma.Unvani = request.Unvani;
                firma.VergiDairesi = request.VergiDairesi;
                firma.VergiNumarasi = request.VergiNumarasi;
                firma.VergiNumarasi = request.YetkiliAdSoyad;
               
                context.SaveChanges();

                result.Result = true;
                result.Explanation = "Kayıt Başarılı";

            }
            catch (Exception ex)
            {
                result.Result = false;
                result.Explanation = "Hata : " + ex.Message;
            }

            return Json(result);
        }


    }


}
