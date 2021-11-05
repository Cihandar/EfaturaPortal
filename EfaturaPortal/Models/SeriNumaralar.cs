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

        public byte[] Sablon { get; set; }

    }
}
