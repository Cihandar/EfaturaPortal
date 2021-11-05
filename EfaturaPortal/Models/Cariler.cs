using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    public class Cariler : BaseModel
    {
        public string Unvani { get; set; }
        public string VergiDairesi { get; set; }
        public string VergiNumarasi { get; set; }
        public  DateTime EfaturaTarihi { get; set; }
        public string EfaturaPostaKutusu { get; set; }
        public string Sehir { get; set; }
        public string Ilce { get; set; }
        public string Adres { get; set; }
        public string Email { get; set; }
        public string Telefon { get; set; }


    }
}
