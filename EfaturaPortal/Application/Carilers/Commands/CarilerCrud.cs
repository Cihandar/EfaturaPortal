using AutoMapper;
using EfaturaPortal.Application.Carilers.ViewModels;
using EfaturaPortal.Application.Interfaces.Cariler;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Carilers.Commands
{
    public class CarilerCrud : ICarilerCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public CarilerCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }

        public async Task<ResultJson> Add(CarilerGetAllQueryViewModel modelvw)
        {
            try
            {
                var data = mapper.Map<Cariler>(modelvw);

                context.Carilers.Add(data);
                context.SaveChanges();

                return new ResultJson { Success = true, Message = "Kayıt Başarılı" };
            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }

        
        }

        public async Task<ResultJson> Update(CarilerGetAllQueryViewModel modelvw)
        {
            try
            {
                var request = mapper.Map<Cariler>(modelvw);

                var data = context.Carilers.FirstOrDefault(x => x.Id == request.Id);

                data.Adres = request.Adres;
                data.EfaturaPostaKutusu = request.EfaturaPostaKutusu;
                data.EfaturaTarihi = request.EfaturaTarihi;
                data.Email = request.Email;
                data.Ilce = request.Ilce;
                data.Sehir = request.Sehir;
                data.Telefon = request.Telefon;
                data.Unvani = request.Unvani;
                data.VergiDairesi = request.VergiDairesi;
                data.VergiNumarasi = request.VergiNumarasi;               

                context.SaveChanges();

                return new ResultJson { Success = true, Message = "Kayıt Başarılı" };

            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }

    
        }

        public async Task<List<CarilerGetAllQueryViewModel>> GetAll(Guid FirmaId)
        {


            var data =   context.Carilers.ToList();

            var result = mapper.Map<List<CarilerGetAllQueryViewModel>>(data);

            return  result;


        }


        public async Task<CarilerGetAllQueryViewModel> GetById(Guid Id)
        {
            var data = context.Carilers.Where(x => x.Id == Id).FirstOrDefault();

            var result = mapper.Map<CarilerGetAllQueryViewModel>(data);

            return result;

        }





    }
}
