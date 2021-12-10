using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EfaturaPortal.Models
{
    public class VergiKodlari
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }
        public string Kodu { get; set; }
        public string Adi { get; set; }
        public string Kisaltma { get; set; }
    }
}
