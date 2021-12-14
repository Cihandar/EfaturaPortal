using AutoMapper;
using EfaturaPortal.Application.FaturaSatirs;
using EfaturaPortal.Application.FaturaSatirKdvlers.ViewModels;
using EfaturaPortal.Application.Interfaces;
using EfaturaPortal.Extentions;
using EfaturaPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using EfaturaPortal.Application.Carilers.Commands;
using EfaturaPortal.Application.Interfaces.FaturaSatirKdvlers;

using EfaturaPortal.Models.ResultModel;

namespace EfaturaPortal.Application.FaturaSatirKdvlers.Commands
{
    public class FaturaSatirKdvlerCrud  : IFaturaSatirKdvlerCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;
 



        public FaturaSatirKdvlerCrud(EfaturaPortalContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;

 
        }

        public async Task<ResultJsonWithData<FaturaSatir>> Add(FaturaSatirKdvlerGetAllQueryViewModel FaturaSatirvw)
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

        public async Task<ResultJson> Update(FaturaSatirKdvlerGetAllQueryViewModel FaturaSatirvw)
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

        public async Task<List<FaturaSatirKdvlerGetAllQueryViewModel>> GetAll(Guid FaturaSatirId)
        {


            var FaturaSatir = context.FaturaSatirKdvlers.Where(x => x.FaturaSatirId== FaturaSatirId).ToList();

            var result = mapper.Map<List<FaturaSatirKdvlerGetAllQueryViewModel>>(FaturaSatir);

            return  result;


        }

        public async Task<ResultJson> Delete(Guid FaturaSatirId)
        {
            try
            {
                var data = context.FaturaSatirKdvlers.Where(x => x.FaturaSatirId == FaturaSatirId).ToList();
                foreach (var x in data)
                {
                    context.FaturaSatirKdvlers.Remove(x);
                }
                context.SaveChanges();

                return new ResultJson { Success = true, Message = "Silme Başarılı" };
            }
            catch (Exception ex)
            {

                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }



        }


 

 



    }
}
