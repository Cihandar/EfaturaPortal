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
using EfaturaPortal.Models.Enum;
using EfaturaPortal.Application.Carilers.ViewModels;

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

        public async Task<ResultJsonWithData<Fatura>> Add(FaturaCreateViewModel faturavw)
        {
            try
            {
                if (faturavw.Toplam != null) faturavw.Toplam = faturavw.Toplam.Replace(".", ",");
                if (faturavw.TevkifatToplam != null) faturavw.TevkifatToplam = faturavw.TevkifatToplam.Replace(".", ",");
                if (faturavw.Iskonto != null) faturavw.Iskonto = faturavw.Iskonto.Replace(".", ",");
                if (faturavw.Kdv != null) faturavw.Kdv = faturavw.Kdv.Replace(".", ",");
                if (faturavw.Artirim != null) faturavw.Artirim = faturavw.Artirim.Replace(".", ",");
                if (faturavw.OdenecekTutar != null) faturavw.OdenecekTutar = faturavw.OdenecekTutar.Replace(".", ",");
                if (faturavw.DigerVergilerToplam != null) faturavw.DigerVergilerToplam = faturavw.DigerVergilerToplam.Replace(".", ",");
                if (faturavw.Stopaj != null) faturavw.Stopaj = faturavw.Stopaj.Replace(".", ",");
                if (faturavw.DovizKuru != null) faturavw.DovizKuru = faturavw.DovizKuru.Replace(".", ",");

                for (int i = 0; i < faturavw.FaturaSatir.Count; i++)
                {
                    if (faturavw.FaturaSatir[i].Miktar != null) faturavw.FaturaSatir[i].Miktar = faturavw.FaturaSatir[i].Miktar.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].BirimFiyat != null) faturavw.FaturaSatir[i].BirimFiyat = faturavw.FaturaSatir[i].BirimFiyat.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].Tutar != null) faturavw.FaturaSatir[i].Tutar = faturavw.FaturaSatir[i].Tutar.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].IskontoOran != null) faturavw.FaturaSatir[i].IskontoOran = faturavw.FaturaSatir[i].IskontoOran.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].IskontoTutar != null) faturavw.FaturaSatir[i].IskontoTutar = faturavw.FaturaSatir[i].IskontoTutar.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].StopajOran != null) faturavw.FaturaSatir[i].StopajOran = faturavw.FaturaSatir[i].StopajOran.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].StopajTutar != null) faturavw.FaturaSatir[i].StopajTutar = faturavw.FaturaSatir[i].StopajTutar.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].KdvOran != null) faturavw.FaturaSatir[i].KdvOran = faturavw.FaturaSatir[i].KdvOran.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].KdvTutar != null) faturavw.FaturaSatir[i].KdvTutar = faturavw.FaturaSatir[i].KdvTutar.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].KdvliTutar != null) faturavw.FaturaSatir[i].KdvliTutar = faturavw.FaturaSatir[i].KdvliTutar.Replace(".", ",");
                    if (faturavw.FaturaSatir[i].TevkifatTutar != null) faturavw.FaturaSatir[i].TevkifatTutar = faturavw.FaturaSatir[i].TevkifatTutar.Replace(".", ",");

                    if (faturavw.FaturaSatir[i].Kdvler != null)
                    {
                        for (int c = 0; c < faturavw.FaturaSatir[i].FaturaSatirKdvler.Count; c++)
                        {
                            if (faturavw.FaturaSatir[i].Kdvler[c].KdvOran != null) faturavw.FaturaSatir[i].Kdvler[c].KdvOran = faturavw.FaturaSatir[i].Kdvler[c].KdvOran.Replace(".", ",");
                            if (faturavw.FaturaSatir[i].Kdvler[c].KdvTutar != null) faturavw.FaturaSatir[i].Kdvler[c].KdvTutar = faturavw.FaturaSatir[i].Kdvler[c].KdvTutar.Replace(".", ",");
                        }
                    }


                }






                var fatura = mapper.Map<Fatura>(faturavw);

                if (faturavw.CarilerId == null || fatura.CarilerId == Guid.Empty)
                {
                    fatura.Cariler.FirmaId = fatura.FirmaId;
                    var cariVm = mapper.Map<CarilerGetAllQueryViewModel>(fatura.Cariler);
                    cariVm.Id = Guid.NewGuid();
                    fatura.CarilerId = cariVm.Id;
                    var cariResult = carilerCrud.Add(cariVm);
                    //  context.Carilers.Add(faturavw.Cariler);

                }

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

                if (faturavw.OdemeSekliKodu != "-1" && faturavw.OdemeSekliKodu != null)
                {
                    var dataodemesekli = context.OdemeTurleris.Where(x => x.Kodu == faturavw.OdemeSekliKodu).FirstOrDefault();
                    fatura.OdemeSekliAdi = dataodemesekli.Adi;
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

        public async Task<List<FaturaGetAllQueryViewModel>> GetAllbyfiltre(Guid firmaId, InvoiceSearch filtre)
        {

            string whereQuery = "SELECT F.* FROM Faturas F INNER JOIN Carilers Cari ON Cari.Id=F.CarilerId Where F.FirmaId='" + firmaId.ToString() + "' ";

            if (!string.IsNullOrWhiteSpace(filtre.FaturaNumarasi)) whereQuery += " AND F.FaturaNumarasi LIKE '%" + filtre.FaturaNumarasi + "%'  ";
            if (!string.IsNullOrWhiteSpace(filtre.Unvan)) whereQuery += " AND Cari.Unvani LIKE '%" + filtre.Unvan + "%'  ";
            if (!string.IsNullOrWhiteSpace(filtre.Vdno)) whereQuery += " AND Cari.VergiNumarasi LIKE '%" + filtre.Vdno + "%'  ";
            switch (filtre.FaturaTuru)
            {
                case "E-Fatura":
                    whereQuery += " AND FaturaTuru=0 ";
                    break;
                case "E-Arsiv":
                    whereQuery += " AND FaturaTuru=1 ";
                    break;
            }

            whereQuery += " AND isnull(F.Silindi,0)<>1  AND F.Tarih BETWEEN '" + filtre.IlkTarih.ToString("MM.dd.yyyy") + " 00:00' AND '" + filtre.SonTarih.ToString("MM.dd.yyyy") + " 23:59'  ";


            var fatura = context.Faturas.FromSqlRaw(whereQuery).Include(x => x.Cariler).ToList().OrderByDescending(x => x.Tarih);

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

            result.FaturaSatir = await faturaSatirCrud.GetAll(faturaId);

            return result;

        }

        public async Task<FaturaCreateViewModel> GetByIdforCreate(Guid faturaId, Guid FirmaId)
        {
            var fatura = context.Faturas.Where(x => x.Id == faturaId).Include(x => x.Cariler).Include(y => y.Firmalar).Include(z => z.SeriNumaralar).FirstOrDefault();

            var result = mapper.Map<FaturaCreateViewModel>(fatura);

            if (result == null) { result = new FaturaCreateViewModel(); result.Tarih = DateTime.Now; result.DovizKuru = "1"; }

            result.CarilerMwList = await carilerCrud.GetAll(FirmaId);  //Firmaya Ait Cariler Alınıyor..

            result.DovizKodlari = await dovizKodlariCrud.GetAll();

            result.OdemeTurleriList = await odemeTurleriCrud.GetAll();
            result.OdemeTarihi = DateTime.Now;

            result.FaturaSatir = await faturaSatirCrud.GetAllForCreate(faturaId);

            return result;

        }

        public async Task<ResultJson> UpdateInvoiceStatus(Guid FaturaId, EfaturaDurum status)
        {
            try
            {


                var fatura = context.Faturas.Where(x => x.Id == FaturaId).FirstOrDefault();
                if (fatura != null)
                {
                    fatura.EfaturaDurum = status;
                }
                context.SaveChanges();

                return new ResultJson { Success = true };
            }
            catch (Exception ex)
            {

                return new ResultJson { Success = false, Message = ex.Message };
            }
        }


        public async Task<ResultJson> UpdateInvoiceNumber(Guid FaturaId, string InNumber)
        {
            try
            {


                var fatura = context.Faturas.Where(x => x.Id == FaturaId).FirstOrDefault();
                if (fatura != null)
                {
                    fatura.FaturaNumarasi = InNumber;
                }
                context.SaveChanges();

                return new ResultJson { Success = true };
            }
            catch (Exception ex)
            {

                return new ResultJson { Success = false, Message = ex.Message };
            }
        }

        public async Task<ResultJson> DeleteInvoice(Guid FaturaId)
        {
            try
            {
                var fatura = context.Faturas.Where(x => x.Id == FaturaId).FirstOrDefault();
                if (fatura != null)
                {
                    fatura.Silindi = true;
                }
                context.SaveChanges();

                return new ResultJson { Success = true };
            }
            catch (Exception ex)
            {

                return new ResultJson { Success = false, Message = ex.Message };
            }
        }






    }
}
