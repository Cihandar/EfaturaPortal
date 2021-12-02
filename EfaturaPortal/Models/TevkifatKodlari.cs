using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    public class TevkifatKodlari : BaseModel
    {
        public string Kodu { get; set; }
        public string Aciklama { get; set; }
        public string Oran { get; set; }
    }
}
