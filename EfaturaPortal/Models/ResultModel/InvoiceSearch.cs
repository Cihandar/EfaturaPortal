using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models.ResultModel
{
    public class InvoiceSearch
    {
        public string FaturaNumarasi { get; set; }
        public string Unvan { get; set; }
        public string Vdno { get; set; }
        public DateTime IlkTarih { get; set; }
        public DateTime SonTarih { get; set; }
        public string FaturaTuru { get; set; }
    }
}
