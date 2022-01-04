using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    public class Fatura :BaseModel
    {
        public FaturaTuru FaturaTuru{ get; set; }
        public DateTime Tarih { get; set; }
        public string Saat { get; set; }
        public string FaturaNumarasi { get; set; }
        public Guid SeriNumaralarId { get; set; }
 
        public string   ParaBirimi { get; set; }
        public string Doviz { get; set; }
        public float DovizKuru { get; set; }

        public Guid CarilerId { get; set; }

        public DateTime OdemeTarihi { get; set; }
        public string OdemeSekliKodu { get; set; }
        public string OdemeSekliAdi { get; set; }
        public string OdemeKanali { get; set; }
        public string OdemeHesapNo { get; set; }

        public string Notlar { get; set; }

        public string YaziylaTutar { get; set; }

        public float Toplam { get; set; }
        public float Artirim { get; set; }
        public float Iskonto { get; set; }
        public float Kdv { get; set; }
        public float OdenecekTutar { get; set; }
        public float TevkifatToplam { get; set; }
        public float DigerVergilerToplam { get; set; }

        

        public FaturaSenaryo FaturaSenaryo { get; set; }
        public FaturaTipi FaturaTipi  { get; set; }


        public Guid ETTN { get; set; }
        public EfaturaDurum EfaturaDurum { get; set; }

        public virtual Cariler Cariler { get; set; }
        public virtual SeriNumaralar SeriNumaralar { get; set; }

    }
}
