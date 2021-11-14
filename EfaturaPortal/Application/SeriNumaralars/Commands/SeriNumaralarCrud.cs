using AutoMapper;
using EfaturaPortal.Application.SeriNumaralars.ViewModels;
using EfaturaPortal.Application.Interfaces.SeriNumaralars;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.SeriNumaralars.Commands
{
    public class SeriNumaralarCrud : ISeriNumaralarCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public SeriNumaralarCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }

        public async Task<ResultJson> Add(SeriNumaralarGetAllQueryViewModel modelvw)
        {
            try
            {
                var data = mapper.Map<SeriNumaralar>(modelvw);

                context.SeriNumaralars.Add(data);
                context.SaveChanges();

                return new ResultJson { Success = true, Message = "Kayıt Başarılı" };
            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }

        
        }

        public async Task<ResultJson> Update(SeriNumaralarGetAllQueryViewModel modelvw)
        {
            try
            {
                var request = mapper.Map<SeriNumaralar>(modelvw);

                var data = context.SeriNumaralars.FirstOrDefault(x => x.Id == request.Id);

                data.FaturaTuru = modelvw.FaturaTuru;
                data.Oncelik = modelvw.Oncelik;
                data.SablonDosyaAdi = modelvw.SablonDosyaAdi;
                data.SablonAdi = modelvw.SablonAdi;
                data.SeriNo = modelvw.SeriNo;

                context.SaveChanges();

                return new ResultJson { Success = true, Message = "Kayıt Başarılı" };

            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }

    
        }

        public async Task<ResultJson> UpdateLastInvoiceInfo(SeriNumaralarGetAllQueryViewModel modelvw)
        {
            try
            {
                var request = mapper.Map<SeriNumaralar>(modelvw);

                var data = context.SeriNumaralars.FirstOrDefault(x => x.Id == request.Id);

                data.SonFaturaNo = modelvw.SonFaturaNo;
                data.SonFaturaTarihi = modelvw.SonFaturaTarihi;
   
                context.SaveChanges();

                return new ResultJson { Success = true, Message = "Kayıt Başarılı" };

            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }

        }

        public async Task<List<SeriNumaralarGetAllQueryViewModel>> GetAll(Guid FirmaId)
        {


            var data = context.SeriNumaralars.Where(x => x.FirmaId == FirmaId).ToList();

            var result = mapper.Map<List<SeriNumaralarGetAllQueryViewModel>>(data);

            return  result;


        }


        public async Task<SeriNumaralarGetAllQueryViewModel> GetById(Guid Id)
        {
            var data = context.SeriNumaralars.Where(x => x.Id == Id).FirstOrDefault();

            var result = mapper.Map<SeriNumaralarGetAllQueryViewModel>(data);

            return result;

        }





    }
}
