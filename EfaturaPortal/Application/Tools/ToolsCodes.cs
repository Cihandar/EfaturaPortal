using EfaturaPortal.Application.Interfaces.Tools;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Tools
{
    public class ToolsCodes : IToolsCodes
    {
        public async  Task<string> YaziyaCevir(string gelentutar)
        {
            //Todo:Dövize göre uyarlanacak
            decimal dectutar = Convert.ToDecimal(gelentutar);
            string strTutar = dectutar.ToString("F2").Replace('.', ',');    // Replace('.',',') ondalık ayraç ayracı           
            string lira = strTutar.Substring(0, strTutar.IndexOf(',')); //tutarın lira kısmı
            string kurus = strTutar.Substring(strTutar.IndexOf(',') + 1, 2);
            string yazi = "";
            string[] birler = { "", "Bir", "İki", "Üç", "Dört", "Beş", "Altı", "Yedi", "Sekiz", "Dokuz" };
            string[] onlar = { "", "On", "Yirmi", "Otuz", "Kırk", "Elli", "Altmış", "Yetmiş", "Seksen", "Doksan" };
            string[] binler = { "Katirilyon", "Trilyon", "Milyar", "Milyon", "Bin", "" }; //KATRİLYON'un önüne ekleme yapılarak artırabilir.
            int grupSayisi = 6;
            lira = lira.PadLeft(grupSayisi * 3, '0'); //sayının soluna '0' eklenerek sayı 'grup sayısı x 3' basakmaklı yapılıyor.
            string grupDegeri;
            for (int i = 0; i < grupSayisi * 3; i += 3) //sayı 3'erli gruplar halinde ele alınıyor.
            {
                grupDegeri = "";
                if (lira.Substring(i, 1) != "0")
                    grupDegeri += birler[Convert.ToInt32(lira.Substring(i, 1))] + "Yüz"; //yüzler
                if (grupDegeri == "BirYüz") //biryüz düzeltiliyor.
                    grupDegeri = "Yüz";
                grupDegeri += onlar[Convert.ToInt32(lira.Substring(i + 1, 1))]; //onlar
                grupDegeri += birler[Convert.ToInt32(lira.Substring(i + 2, 1))]; //birler
                if (grupDegeri != "") //binler
                    grupDegeri += "" + binler[i / 3];
                if (grupDegeri == "BirBin") //birbin düzeltiliyor.
                    grupDegeri = "Bin";
                yazi += grupDegeri;
            }
            if (yazi != "")
                yazi += "Lira";
            int yaziUzunlugu = yazi.Length;
            if (kurus.Substring(0, 1) != "0") //kuruş onlar
                yazi += onlar[Convert.ToInt32(kurus.Substring(0, 1))];
            if (kurus.Substring(1, 1) != "0") //kuruş birler
                yazi += birler[Convert.ToInt32(kurus.Substring(1, 1))];
            if (yazi.Length > yaziUzunlugu)
                yazi += "Kuruş";
            else
                yazi += "";
            return yazi;
        }

        public async Task<decimal> toDecimal(string value)
        {
            decimal result = 0;
            if (decimal.TryParse(value, out result))
                return result;
            else return 0;
        }


        public async Task<byte[]> GetXSLTFiletoBinary(string fileName)
        {
            byte[] data;

            if (!string.IsNullOrWhiteSpace(fileName) && File.Exists("/uploads/Xslt/" + fileName))
            {
                 data = Encoding.UTF8.GetBytes(new StreamReader(new FileStream("/uploads/Xslt/" + fileName, FileMode.Open, FileAccess.Read), Encoding.UTF8).ReadToEnd());
            }else { data = null; }
           
            return data;

        }
    }
}
