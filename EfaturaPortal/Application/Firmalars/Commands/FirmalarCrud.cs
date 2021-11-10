using AutoMapper;
using EfaturaPortal.Application.Firmalars.ViewModels;
using EfaturaPortal.Application.Interfaces.Firmalar;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Firmalars.Commands
{
    public class FirmalarCrud : IFirmalarCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public FirmalarCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }

        public async Task<ResultJsonWithData<Firmalar>> Add(FirmalarGetAllQueryViewModel firmavw)
        {
            try
            {
                var firma = mapper.Map<Firmalar>(firmavw);

                context.Firmalars.Add(firma);
                context.SaveChanges();

                return new ResultJsonWithData<Firmalar> { Success = true, Message = "Kayıt Başarılı", Data = firma };

            }
            catch (Exception ex)
            {
                return new ResultJsonWithData<Firmalar> { Success = false, Message = "Hata : " + ex.Message };
            }


        }

        public async Task<ResultJson> Update(FirmalarGetAllQueryViewModel firmavw)
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
                firma.YetkiliAdSoyad = request.YetkiliAdSoyad;
                firma.WsGbKodu = request.WsGbKodu;
                firma.WsPkKodu = request.WsPkKodu;
                firma.WsSifre = request.WsSifre;
                firma.WsKullaniciAdi = request.WsKullaniciAdi;

                context.SaveChanges();

                return new ResultJson { Success = true, Message = "Kayıt Başarılı"   };

            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }

    
        }

        public async Task<List<FirmalarGetAllQueryViewModel>> GetAll(Guid FirmaId)
        {


            var firma =   context.Firmalars.ToList();

            var result = mapper.Map<List<FirmalarGetAllQueryViewModel>>(firma);

            return  result;


        }


        public async Task<FirmalarGetAllQueryViewModel> GetById(Guid FirmaId)
        {
            var firma = context.Firmalars.Where(x => x.Id == FirmaId).FirstOrDefault();

            var result = mapper.Map<FirmalarGetAllQueryViewModel>(firma);

            return result;

        }





    }
}
