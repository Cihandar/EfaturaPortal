using AutoMapper;
using EfaturaPortal.Application.Faturas;
using EfaturaPortal.Application.Faturas.ViewModels;
using EfaturaPortal.Application.Interfaces;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Faturas.Commands
{
    public class FaturaCrud  
    {
        public EfaturaPortalContext context;
        public IMapper mapper;

        public FaturaCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }

        public async Task<ResultJsonWithData<Fatura>> Add(FaturaGetAllQueryViewModel faturavw)
        {
            try
            {
                var fatura = mapper.Map<Fatura>(faturavw);
                context.Faturas.Add(fatura);
                context.SaveChanges();

                return new ResultJsonWithData<Fatura> { Success = true, Message = "Kayıt Başarılı", Data = fatura };

            }
            catch (Exception ex)
            {
                return new ResultJsonWithData<Fatura> { Success = false, Message = "Hata : " + ex.Message };
            }

        }

        public async Task<ResultJson> Update(FaturaGetAllQueryViewModel faturavw)
        {
            try
            {
                var request = mapper.Map<Fatura>(faturavw);

                var fatura = context.Faturas.FirstOrDefault(x => x.Id == request.Id);

                fatura.Artirim = request.Artirim;
                fatura.CarilerId = request.CarilerId;
                fatura.DovizKuru = request.DovizKuru;
                fatura.EfaturaDurum = request.EfaturaDurum;
                fatura.ETTN = request.ETTN;
                fatura.FaturaSenaryo = request.FaturaSenaryo;
                fatura.FaturaTipi = request.FaturaTipi;
                fatura.FaturaTuru = request.FaturaTuru;
                fatura.Iskonto = request.Iskonto;
                fatura.Kdv = request.Kdv;
                fatura.Notlar = request.Notlar;
                fatura.OdemeHesapNo = request.OdemeHesapNo;
                fatura.OdemeKanali = request.OdemeKanali;
                fatura.OdemeSekli = request.OdemeSekli;
                fatura.OdemeTarihi = request.OdemeTarihi;
                fatura.OdenecekTutar = request.OdenecekTutar;
                fatura.ParaBirimi = request.ParaBirimi;
                fatura.SeriNumaralarId = request.SeriNumaralarId;
                fatura.Tarih = request.Tarih;
                fatura.Toplam = request.Toplam;
                fatura.YaziylaTutar = request.YaziylaTutar;              

                context.SaveChanges();

                return new ResultJson { Success = true, Message = "Kayıt Başarılı"   };

            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }

    
        }

        public async Task<List<FaturaGetAllQueryViewModel>> GetAll(Guid faturaId)
        {


            var fatura = context.Faturas.Where(x => x.Id == faturaId).ToList();
            

            var result = mapper.Map<List<FaturaGetAllQueryViewModel>>(fatura);

            return  result;


        }


        public async Task<FaturaGetAllQueryViewModel> GetById(Guid faturaId)
        {
            var fatura = context.Faturas.Where(x => x.Id == faturaId).FirstOrDefault();

            var result = mapper.Map<FaturaGetAllQueryViewModel>(fatura);

            return result;

        }





    }
}
