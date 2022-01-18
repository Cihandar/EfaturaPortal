using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    public class SeriNumaralar:BaseModel
    {
        public FaturaTuru FaturaTuru { get; set; }
        public string SeriNo { get; set; }
        public int SonFaturaNo { get; set; }
        public DateTime SonFaturaTarihi { get; set; }
        public int Oncelik { get; set; }
        public string SablonAdi { get; set; }
        public string SablonDosyaAdi { get; set; }
        public int Yil { get; set; }

    }
}
