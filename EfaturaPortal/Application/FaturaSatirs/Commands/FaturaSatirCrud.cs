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
using EfaturaPortal.Application.Interfaces.VergiKodlaris;
using EfaturaPortal.Models.ResultModel;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using EfaturaPortal.Application.Interfaces.Tools;

namespace EfaturaPortal.Application.FaturaSatirs.Commands
{
    public class FaturaSatirCrud : IFaturaSatirCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;
        public ICarilerCrud carilerCrud;
        public IDovizKodlariCrud dovizKodlariCrud;
        public IOlcuBirimleriCrud olcuBirimleriCrud;
        public IIstisnaKodlariCrud istisnaKodlariCrud;
        public ITevkifatKodlariCrud tevkifatKodlariCrud;
        public IVergiKodlariCrud vergiKodlariCrud;
        private IConfiguration _config;
        public IToolsCodes _tools;


        public FaturaSatirCrud(EfaturaPortalContext _context, IMapper _mapper, ICarilerCrud _carilerCrud, IDovizKodlariCrud _dovizKodlariCrud, IOlcuBirimleriCrud _olcuBirimleriCrud, IIstisnaKodlariCrud _istisnaKodlariCrud, ITevkifatKodlariCrud _tevkifatKodlariCrud, IVergiKodlariCrud _vergiKodlariCrud, IConfiguration config, IToolsCodes tools)
        {
            context = _context;
            mapper = _mapper;
            carilerCrud = _carilerCrud;
            dovizKodlariCrud = _dovizKodlariCrud;
            olcuBirimleriCrud = _olcuBirimleriCrud;
            istisnaKodlariCrud = _istisnaKodlariCrud;
            tevkifatKodlariCrud = _tevkifatKodlariCrud;
            vergiKodlariCrud = _vergiKodlariCrud;
            _config = config;
            _tools = tools;
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

                return new ResultJson { Success = true, Message = "Kayıt Başarılı" };

            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }


        }

        public async Task<List<FaturaSatirGetAllQueryViewModel>> GetAll(Guid FaturaId)
        {


            var FaturaSatir = context.FaturaSatirs.Where(x => x.FaturaId == FaturaId).Include(x => x.OlcuBirimleri).Include(x => x.IstisnaKodlari).ToList();


            //foreach (var data in FaturaSatir)
            //{
            //    if (data.IstisnaKodlariId != null && data.IstisnaKodlariId != 0) data.IstisnaKodlari = context.IstisnaKodlaris.Where(x => x.Id == data.IstisnaKodlariId ).FirstOrDefault();
            //}



            var data = mapper.Map<List<FaturaSatirGetAllQueryViewModel>>(FaturaSatir);

            var result = new List<FaturaSatirGetAllQueryViewModel>();

            foreach (var x in data)
            {
                x.FaturaSatirKdvler = context.FaturaSatirKdvlers.Where(y => y.FaturaSatirId == x.Id).ToList();

                result.Add(x);
            }

            return result;


        }

        public async Task<List<FaturaSatirCreateViewModel>> GetAllForCreate(Guid FaturaId)
        {


            var FaturaSatir = context.FaturaSatirs.Where(x => x.FaturaId == FaturaId).Include(x => x.OlcuBirimleri).Include(x => x.IstisnaKodlari).ToList();


            //foreach (var data in FaturaSatir)
            //{
            //    if (data.IstisnaKodlariId != null && data.IstisnaKodlariId != 0) data.IstisnaKodlari = context.IstisnaKodlaris.Where(x => x.Id == data.IstisnaKodlariId ).FirstOrDefault();
            //}



            var data = mapper.Map<List<FaturaSatirCreateViewModel>>(FaturaSatir);

            var result = new List<FaturaSatirCreateViewModel>();

            foreach (var x in data)
            {
                x.FaturaSatirKdvler = context.FaturaSatirKdvlers.Where(y => y.FaturaSatirId == x.Id).ToList();

                result.Add(x);
            }

            return result;


        }

        public async Task<FaturaSatirGetAllQueryViewModel> GetById(Guid FaturaSatirId)
        {
            var FaturaSatir = context.FaturaSatirs.Where(x => x.Id == FaturaSatirId).Include(x => x.OlcuBirimleri).Include(x => x.IstisnaKodlari).FirstOrDefault();
            // if (FaturaSatir.IstisnaKodlariId != null && FaturaSatir.IstisnaKodlariId != 0) FaturaSatir.IstisnaKodlari = context.IstisnaKodlaris.Where(x => x.Id == FaturaSatir.IstisnaKodlariId).FirstOrDefault();
            var result = mapper.Map<FaturaSatirGetAllQueryViewModel>(FaturaSatir);

            result.FaturaSatirKdvler = context.FaturaSatirKdvlers.Where(x => x.FaturaSatirId == result.Id).ToList();

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


        public async Task<List<KdvlerViewModel>> GetKdv(Guid FaturaId)
        {
            try
            {
                var con = new SqlConnection(_config.GetConnectionString("EfaturaPortalCon"));

                var query = string.Format(@"SELECT Kodu,Adi,ISNULL(KdvOran,0)  KdvOran,SUM(ISNULL(KdvTutar,0)) KdvTutar,SUM(ISNULL(Tutar,0)) Tutar,TevkifatKodu,TevkifatAdi,TevkifatOran,ISNULL(TevkifatTutar,0) TevkifatTutar,IstisnaKodu,IstisnaAciklama FROM  (
                                        SELECT '0015' Kodu,'KDV' Adi ,KdvOran,KdvTutar,Tutar,TevkifatKodu,Isnull(TevkifatAdi,'') TevkifatAdi,ISNULL(TevkifatOran,'') TevkifatOran,TevkifatTutar,IstisnaKodu,ISNULL(IstisnaAciklama,'') IstisnaAciklama  FROM FaturaSatirs FS WHERE FaturaId='{0}'
                                        UNION ALL
                                        SELECT FSK.Kodu,FSK.Adi,FSK.KdvOran,FSK.KdvTutar,FS.Tutar,'','','',0,'',''  FROM FaturaSatirs FS INNER JOIN FaturaSatirKdvlers FSK ON FS.Id=FSK.FaturaSatirId and  FS.FaturaId='{0}') as KdvTable
                                        GROUP BY Kodu,Adi,KdvOran,TevkifatKodu,TevkifatAdi,TevkifatOran,TevkifatTutar,IstisnaKodu,IstisnaAciklama", FaturaId.ToString());

                var cmd = new SqlCommand(query, con);
                if (con.State != System.Data.ConnectionState.Open) con.Open();
                var dr = cmd.ExecuteReader();
                var result = new List<KdvlerViewModel>();
                while (dr.Read())
                {
                    var kdv = new KdvlerViewModel();
                    kdv.Kodu = dr.GetFieldValue<string>(dr.GetOrdinal("Kodu"));
                    kdv.Adi = dr.GetFieldValue<string>(dr.GetOrdinal("Adi"));
                    kdv.KdvOran = await _tools.toFloat(dr.GetValue(2).ToString());
                    kdv.KdvTutar = await _tools.toFloat(dr.GetValue(3).ToString());
                    kdv.Tutar = await _tools.toFloat(dr.GetValue(4).ToString());
                    kdv.TevkifatKodu = dr.GetFieldValue<string>(dr.GetOrdinal("TevkifatKodu"));
                    kdv.TevkifatAdi = dr.GetFieldValue<string>(dr.GetOrdinal("TevkifatAdi"));
                    kdv.TevkifatOran = dr.GetFieldValue<string>(dr.GetOrdinal("TevkifatOran"));
                    kdv.TevkifatTutar = await _tools.toFloat(dr.GetValue(8).ToString());
                    kdv.IstisnaKodu = dr.GetFieldValue<string>(dr.GetOrdinal("IstisnaKodu"));
                    kdv.IstisnaAciklama = dr.GetFieldValue<string>(dr.GetOrdinal("IstisnaAciklama"));
                    result.Add(kdv);
                }



                con.Close();


                //var result = context.FaturaSatirs.FromSqlRaw(query).Select(y=> new KdvlerViewModel { Kodu= y.Aciklama,Adi=y.OlcuBirimi,KdvOran=y.KdvOran,KdvTutar=y.KdvTutar,Tutar =y.Tutar,TevkifatKodu=y.TevkifatKodu,TevkifatAdi=y.TevkifatAdi,TevkifatOran=y.TevkifatOran,TevkifatTutar=y.TevkifatTutar,IstisnaAciklama=y.IstisnaAciklama,IstisnaKodu=y.IstisnaKodu }).ToList();

                //  var result = data; // mapper.Map<List<KdvlerViewModel>>(data);

                return result;
            }
            catch (Exception ex)
            {

                return null;
            }

        }



    }
}
