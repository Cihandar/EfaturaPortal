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
using Microsoft.EntityFrameworkCore;
using EfaturaPortal.Application.Carilers.Commands;
using EfaturaPortal.Application.Interfaces.Faturas;
using EfaturaPortal.Application.Interfaces.Cariler;
using EfaturaPortal.Application.Interfaces.DovizKodlaris;
using EfaturaPortal.Application.Interfaces.OdemeTurleris;
using EfaturaPortal.Models.ResultModel;

namespace EfaturaPortal.Application.Faturas.Commands
{
    public class FaturaCrud  : IFaturaCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;
        public ICarilerCrud carilerCrud;
        public IDovizKodlariCrud dovizKodlariCrud;
        public IOdemeTurleriCrud odemeTurleriCrud;
        

        public FaturaCrud(EfaturaPortalContext _context, IMapper _mapper, ICarilerCrud _carilerCrud, IDovizKodlariCrud _dovizKodlariCrud, IOdemeTurleriCrud _odemeTurleriCrud)
        {
            context = _context;
            mapper = _mapper;
            carilerCrud = _carilerCrud;
            dovizKodlariCrud = _dovizKodlariCrud;
            odemeTurleriCrud = _odemeTurleriCrud;
 
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
                fatura.OdemeSekliKodu = request.OdemeSekliKodu;
                fatura.OdemeSekliAdi = request.OdemeSekliAdi;
                fatura.OdemeTarihi = request.OdemeTarihi;
                fatura.OdenecekTutar = request.OdenecekTutar;
                fatura.ParaBirimi = request.ParaBirimi;
                fatura.SeriNumaralarId = request.SeriNumaralarId;
                fatura.Tarih = request.Tarih;
                fatura.Toplam = request.Toplam;                
                fatura.YaziylaTutar = request.YaziylaTutar;
                fatura.TevkifatToplam = request.TevkifatToplam;
                fatura.DigerVergilerToplam = request.DigerVergilerToplam;
                

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


            var fatura = context.Faturas.Include(x=>x.Cariler).Where(x => x.Id == faturaId).ToList();

            var result = mapper.Map<List<FaturaGetAllQueryViewModel>>(fatura);

            return  result;


        }


        public async Task<FaturaGetAllQueryViewModel> GetById(Guid faturaId,Guid FirmaId)
        {
            var fatura = context.Faturas.Where(x => x.Id == faturaId).FirstOrDefault();

            var result = mapper.Map<FaturaGetAllQueryViewModel>(fatura);

            if (result == null) { result = new FaturaGetAllQueryViewModel(); result.Tarih = DateTime.Now; result.DovizKuru = 1; }

            result.CarilerMwList = await carilerCrud.GetAll(FirmaId);  //Firmaya Ait Cariler Alınıyor..

            result.DovizKodlari = await dovizKodlariCrud.GetAll();

            result.OdemeTurleriList = await odemeTurleriCrud.GetAll();

            return result;

        }





    }
}
