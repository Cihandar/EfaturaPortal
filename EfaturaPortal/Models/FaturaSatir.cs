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
        public double Miktar { get; set; }
        public string OlcuBirimi { get; set; }
        public double Tutar { get; set; }

        public string IskontoDurum { get; set; }
        public double IskontoOran { get; set; }
        public int IskontoTutar { get; set; }

        public double KdvOran { get; set; }
        public double KdvTutar { get; set; }

        public double KdvliTutar { get; set; }
    }
}
