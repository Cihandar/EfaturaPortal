using AutoMapper;
using EfaturaPortal.Application.SeriNumaralars.ViewModels;
using EfaturaPortal.Application.Interfaces.SeriNumaralars;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models.Enum;
using EfaturaPortal.Models.ResultModel;

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
                data.Yil = modelvw.Yil;

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

        public async Task<List<SeriNumaralarGetAllQueryViewModel>> GetSeriNumaraByFaturaTuru(FaturaTuru faturaTuru,Guid FirmaId)
        {
            var data = context.SeriNumaralars.Where(x => x.FirmaId == FirmaId && x.FaturaTuru==faturaTuru).ToList().OrderBy(x=>x.Oncelik);

            var result = mapper.Map<List<SeriNumaralarGetAllQueryViewModel>>(data);

            return result;

        }

        public async Task<ResultJson> GetLastInvoiceNumberAndUpdate(Guid FirmaId, string SeriNo,int Yil,FaturaTuru faturaTuru)
        {
            var result = new ResultJson();
            var InvNum = context.SeriNumaralars.Where(x => x.FirmaId == FirmaId && x.SeriNo == SeriNo && x.Yil == Yil && x.FaturaTuru == faturaTuru).FirstOrDefault();
            if(InvNum!=null)
            {
                result.Success = true;
                result.Value = await CreateInvoiceNumber(InvNum.SonFaturaNo + 1, Yil, SeriNo);

                InvNum.SonFaturaNo = InvNum.SonFaturaNo + 1;
                context.SaveChanges();

            }else
            {
                result.Success = false;
                result.Message = string.Format("{0} Yılı için tanımlı bir seri no bulunamadı !", Yil);
            }


            return result;

        }

        private async Task<string> CreateInvoiceNumber(int number,int yil,string seriNo)
        {
            var invnmbr = seriNo + yil.ToString() + number.ToString().PadLeft(9, '0');
            return invnmbr;
        }





    }
}
