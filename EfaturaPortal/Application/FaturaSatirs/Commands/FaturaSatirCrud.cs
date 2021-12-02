using AutoMapper;
using EfaturaPortal.Application.FaturaSatirs;
using EfaturaPortal.Application.FaturaSatirs.ViewModels;
using EfaturaPortal.Application.Interfaces;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using EfaturaPortal.Application.Carilers.Commands;
using EfaturaPortal.Application.Interfaces.FaturaSatirs;
using EfaturaPortal.Application.Interfaces.Cariler;
using EfaturaPortal.Application.Interfaces.DovizKodlaris;
using EfaturaPortal.Application.Interfaces.OlcuBirimleris;
using EfaturaPortal.Application.Interfaces.IstisnaKodlaris;
using EfaturaPortal.Application.Interfaces.TevkifatKodlaris;

using EfaturaPortal.Models.ResultModel;

namespace EfaturaPortal.Application.FaturaSatirs.Commands
{
    public class FaturaSatirCrud  : IFaturaSatirCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;
        public ICarilerCrud carilerCrud;
        public IDovizKodlariCrud dovizKodlariCrud;
        public IOlcuBirimleriCrud olcuBirimleriCrud;
        public IIstisnaKodlariCrud istisnaKodlariCrud;
        public ITevkifatKodlariCrud tevkifatKodlariCrud;




        public FaturaSatirCrud(EfaturaPortalContext _context, IMapper _mapper, ICarilerCrud _carilerCrud, IDovizKodlariCrud _dovizKodlariCrud,IOlcuBirimleriCrud _olcuBirimleriCrud, IIstisnaKodlariCrud _istisnaKodlariCrud, ITevkifatKodlariCrud _tevkifatKodlariCrud)
        {
            context = _context;
            mapper = _mapper;
            carilerCrud = _carilerCrud;
            dovizKodlariCrud = _dovizKodlariCrud;
            olcuBirimleriCrud = _olcuBirimleriCrud;
            istisnaKodlariCrud = _istisnaKodlariCrud;
            tevkifatKodlariCrud = _tevkifatKodlariCrud;
 
        }

        public async Task<ResultJsonWithData<FaturaSatir>> Add(FaturaSatirGetAllQueryViewModel FaturaSatirvw)
        {
            try
            {
                var FaturaSatir = mapper.Map<FaturaSatir>(FaturaSatirvw);
                context.FaturaSatirs.Add(FaturaSatir);
                context.SaveChanges();

                return new ResultJsonWithData<FaturaSatir> { Success = true, Message = "Kayıt Başarılı", Data = FaturaSatir };

            }
            catch (Exception ex)
            {
                return new ResultJsonWithData<FaturaSatir> { Success = false, Message = "Hata : " + ex.Message };
            }

        }

        public async Task<ResultJson> Update(FaturaSatirGetAllQueryViewModel FaturaSatirvw)
        {
            try
            {
                var request = mapper.Map<FaturaSatir>(FaturaSatirvw);

                var FaturaSatir = context.FaturaSatirs.FirstOrDefault(x => x.Id == request.Id);

         

                context.SaveChanges();

                return new ResultJson { Success = true, Message = "Kayıt Başarılı"   };

            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }

    
        }

        public async Task<List<FaturaSatirGetAllQueryViewModel>> GetAll(Guid FaturaId)
        {


            var FaturaSatir = context.FaturaSatirs.Where(x => x.FaturaId==FaturaId).ToList();

            var result = mapper.Map<List<FaturaSatirGetAllQueryViewModel>>(FaturaSatir);

            return  result;


        }


        public async Task<FaturaSatirGetAllQueryViewModel> GetById(Guid FaturaSatirId)
        {
            var FaturaSatir = context.FaturaSatirs.Where(x => x.Id == FaturaSatirId).FirstOrDefault();

            var result = mapper.Map<FaturaSatirGetAllQueryViewModel>(FaturaSatir);   

            return result;

        }

        public async Task<FaturaSatirGetAllQueryViewModel> GetEmptyRow()
        {
            var result = new FaturaSatirGetAllQueryViewModel();

            result.LstOlcuBirimleri = await olcuBirimleriCrud.GetAll();

            result.LstIstisnaKodlari = await istisnaKodlariCrud.GetAll();

            result.LstTevkifatKodlari = await tevkifatKodlariCrud.GetAll();

            return result;

        }



    }
}
