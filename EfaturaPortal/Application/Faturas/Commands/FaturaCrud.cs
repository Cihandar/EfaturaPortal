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
using EfaturaPortal.Application.Interfaces.FaturaSatirs;
using EfaturaPortal.Application.Interfaces.FaturaSatirKdvlers;

namespace EfaturaPortal.Application.Faturas.Commands
{
    public class FaturaCrud : IFaturaCrud
    {
        public EfaturaPortalContext context;
        public IMapper mapper;
        public ICarilerCrud carilerCrud;
        public IDovizKodlariCrud dovizKodlariCrud;
        public IOdemeTurleriCrud odemeTurleriCrud;
        public IFaturaSatirCrud faturaSatirCrud;
        public IFaturaSatirKdvlerCrud faturaSatirKdvlerCrud;


        public FaturaCrud(EfaturaPortalContext _context, IMapper _mapper, ICarilerCrud _carilerCrud, IDovizKodlariCrud _dovizKodlariCrud, IOdemeTurleriCrud _odemeTurleriCrud, IFaturaSatirCrud _faturaSatirCrud, IFaturaSatirKdvlerCrud _faturaSatirKdvlerCrud)
        {
            context = _context;
            mapper = _mapper;
            carilerCrud = _carilerCrud;
            dovizKodlariCrud = _dovizKodlariCrud;
            odemeTurleriCrud = _odemeTurleriCrud;
            faturaSatirCrud = _faturaSatirCrud;
            faturaSatirKdvlerCrud = _faturaSatirKdvlerCrud;

        }

        public async Task<ResultJsonWithData<Fatura>> Add(FaturaGetAllQueryViewModel faturavw)
        {
            try
            {
                var fatura = mapper.Map<Fatura>(faturavw);

                var faturaid = Guid.NewGuid();

                fatura.Id = faturaid;

            

                foreach (var fsatir in faturavw.FaturaSatir)
                {
                    var faturasatir = mapper.Map<FaturaSatir>(fsatir);
                    faturasatir.FaturaId = faturaid;
                    var faturasatirid = Guid.NewGuid();
                    faturasatir.Id = faturasatirid;
                    context.FaturaSatirs.Add(faturasatir);
                    if (fsatir.Kdvler != null)
                    {
                        foreach (var fskdv in fsatir.Kdvler)
                        {
                            var kdvler = mapper.Map<FaturaSatirKdvler>(fskdv);
                            kdvler.FaturaSatirId = faturasatirid;
                            var datakdv = context.VergiKodlaris.Where(x => x.Kodu == kdvler.Kodu).FirstOrDefault();
                            kdvler.Adi = datakdv.Adi;
                            context.FaturaSatirKdvlers.Add(kdvler);
                        }
                    }


                    if (fsatir.TevkifatKodu != "-1" && fsatir.TevkifatKodu != null)
                    {
                        var datatevkifat = context.TevkifatKodlaris.Where(x => x.Kodu == fsatir.TevkifatKodu).FirstOrDefault();
                        fsatir.TevkifatAdi = datatevkifat.Aciklama;
                        fsatir.TevkifatOran = datatevkifat.Oran;
                    }

                    if (fsatir.IstisnaKodu != "-1" && fsatir.IstisnaKodu != null)
                    {
                        var dataistisna = context.IstisnaKodlaris.Where(x => x.Kodu == fsatir.IstisnaKodu).FirstOrDefault();
                        fsatir.IstisnaAciklama = dataistisna.Aciklama;                        
                    }                

                }

                if(faturavw.OdemeSekliKodu!="-1" && faturavw.OdemeSekliKodu!=null)
                {
                    var dataodemesekli = context.OdemeTurleris.Where(x => x.Kodu == faturavw.OdemeSekliKodu).FirstOrDefault();
                    fatura.OdemeSekliAdi = dataodemesekli.Adi;
                }

                if (faturavw.CarilerId == null || fatura.CarilerId == Guid.Empty)
                {

                    context.Carilers.Add(faturavw.Cariler);
                    
                }

                fatura.Cariler = null;
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

                return new ResultJson { Success = true, Message = "Kayıt Başarılı" };

            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = "Hata : " + ex.Message };
            }


        }

        public async Task<List<FaturaGetAllQueryViewModel>> GetAll(Guid firmaId)
        {


            var fatura = context.Faturas.Include(x => x.Cariler).Where(x => x.FirmaId == firmaId).ToList();

            var result = mapper.Map<List<FaturaGetAllQueryViewModel>>(fatura);

            return result;


        }

        public async Task<List<FaturaGetAllQueryViewModel>> GetAllbyfiltre(Guid firmaId,InvoiceSearch filtre)
        {

            string whereQuery = "SELECT F.* FROM Faturas F INNER JOIN Carilers Cari ON Cari.Id=F.CarilerId Where F.FirmaId='"+ firmaId.ToString() + "' ";

            if (!string.IsNullOrWhiteSpace(filtre.FaturaNumarasi)) whereQuery += " AND F.FaturaNumarasi LIKE '%" + filtre.FaturaNumarasi + "%'  ";
            if (!string.IsNullOrWhiteSpace(filtre.Unvan)) whereQuery += " AND Cari.Unvani LIKE '%" + filtre.Unvan + "%'  ";
            if (!string.IsNullOrWhiteSpace(filtre.Vdno)) whereQuery += " AND Cari.VergiNumarasi LIKE '%" + filtre.Vdno + "%'  ";
           
            whereQuery += " AND F.Tarih BETWEEN '" + filtre.IlkTarih.ToString("MM.dd.yyyy") + " 00:00' AND '" + filtre.SonTarih.ToString("MM.dd.yyyy") + " 23:59'  ";


            var fatura = context.Faturas.FromSqlRaw(whereQuery).Include(x => x.Cariler).ToList();

            var result = mapper.Map<List<FaturaGetAllQueryViewModel>>(fatura);

            return result;


        }

        public async Task<FaturaGetAllQueryViewModel> GetById(Guid faturaId, Guid FirmaId)
        {
            var fatura = context.Faturas.Where(x => x.Id == faturaId).Include(x => x.Cariler).Include(y => y.Firmalar).Include(z => z.SeriNumaralar).FirstOrDefault();

            var result = mapper.Map<FaturaGetAllQueryViewModel>(fatura);

            if (result == null) { result = new FaturaGetAllQueryViewModel(); result.Tarih = DateTime.Now; result.DovizKuru = 1; }

            result.CarilerMwList = await carilerCrud.GetAll(FirmaId);  //Firmaya Ait Cariler Alınıyor..

            result.DovizKodlari = await dovizKodlariCrud.GetAll();

            result.OdemeTurleriList = await odemeTurleriCrud.GetAll();

            return result;

        }





    }
}
