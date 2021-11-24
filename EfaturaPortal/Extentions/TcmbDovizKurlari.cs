using EfaturaPortal.Application.Interfaces.Extentions;
using EfaturaPortal.Models.ResultModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml;

namespace EfaturaPortal.Extentions
{
    public class TcmbDovizKurlari : ITcmbDovizKurlari
    {
        public async Task<ResultJson> DovizKuruAl(string DovizKodu,string Tarih)
        {
            string kur = "1";

            DateTime _tarih;

            if (!DateTime.TryParse(Tarih, out _tarih)) return new ResultJson { Success = false, Message = "Tarih Formatı Yanlış" };
            


            if (_tarih.DayOfWeek == DayOfWeek.Monday) _tarih = _tarih.AddDays(-2);
            if (_tarih.DayOfWeek == DayOfWeek.Saturday) _tarih = _tarih.AddDays(-1);

           
            string yilay = _tarih.ToString("yyyyMM");
            string tamtarih = _tarih.ToString("ddMMyyyy");
            string arsiv = "https://www.tcmb.gov.tr/kurlar/" + yilay + "/" + tamtarih + ".xml";
            string today = "https://www.tcmb.gov.tr/kurlar/today.xml";

            string XmlUrl = arsiv; 

            if (DateTime.Now.ToShortDateString() == _tarih.ToShortDateString()) XmlUrl = today;

            // DataTableımıza 6 sütün ekliyoruz ve değişken tiplerini tanımlıyoruz.
            XmlTextReader rdr = new XmlTextReader(XmlUrl);
            // XmlTextReader nesnesini yaratıyoruz ve parametre olarak xml dokümanın urlsini veriyoruz
            // XmlTextReader urlsi belirtilen xml dokümanlarına hızlı ve forward-only giriş imkanı sağlar.
            XmlDocument myxml = new XmlDocument();
            // XmlDocument nesnesini oluşturuyoruz.
            try
            {
                myxml.Load(rdr);
            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Value = ex.Message };
            }

            // Load metodu ile xml yüklüyoruz
            XmlNode tarih = myxml.SelectSingleNode("/Tarih_Date/@Tarih");
            XmlNodeList mylist = myxml.SelectNodes("/Tarih_Date/Currency");
            XmlNodeList adi = myxml.SelectNodes("/Tarih_Date/Currency/Isim");
            XmlNodeList kod = myxml.SelectNodes("/Tarih_Date/Currency/@Kod");
            XmlNodeList doviz_alis = myxml.SelectNodes("/Tarih_Date/Currency/ForexBuying");
            XmlNodeList doviz_satis = myxml.SelectNodes("/Tarih_Date/Currency/ForexSelling");

            int x = 19;

            for (int i = 0; i < x; i++)
            {
           
                if (kod.Item(i).InnerText.ToString().Trim()==DovizKodu)
                {
                    //dr[0] = adi.Item(i).InnerText.ToString(); // i. adi nodunun 
                    // Adı isimli DataColumn un satırlarını  /Tarih_Date/Currency/Isim node ları ile dolduruyoruz.
 
                    // Kod satırları
                    kur = doviz_alis.Item(i).InnerText.ToString().Replace(".", ",");

                    break;
                    // Döviz Alış                     
                    //  dr[4] = efektif_alis.Item(i).InnerText.ToString().Replace(".", ",");
                    // Efektif Alış
                    // dr[5] = efektif_satis.Item(i).InnerText.ToString().Replace(".", ",");
                    // Efektif Satış.          
     
                }
            }

            return new ResultJson { Success = true, Value = kur };


        }
    }
}
