using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    public class FaturaSatir : BaseModel
    {
        public Guid FaturaId { get; set; }
        public int Sirano { get; set; }
        public string Aciklama { get; set; }
        public float Miktar { get; set; }
        public string OlcuBirimi { get; set; }
        public int OlcuBirimleriId { get; set; }
        public float BirimFiyat { get; set; }
        public float Tutar { get; set; }

        public string IskontoDurum { get; set; }
        public float IskontoOran { get; set; }
        public float IskontoTutar { get; set; }

        public float KdvOran { get; set; }
        public float KdvTutar { get; set; }

        public float KdvliTutar { get; set; }

        public string TevkifatKodu { get; set; }
        public string TevkifatAdi { get; set; }
        public string TevkifatOran { get; set; }
        public float TevkifatTutar { get; set; }


        public int? IstisnaKodlariId { get; set; }
        public string IstisnaKodu { get; set; }
        public string IstisnaAciklama { get; set; }


        public virtual Fatura Fatura { get; set; }
        public virtual OlcuBirimleri OlcuBirimleri { get; set; }
        public virtual IstisnaKodlari IstisnaKodlari { get; set; }
 
    }
}
