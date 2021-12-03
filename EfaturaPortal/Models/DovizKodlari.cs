using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    public class DovizKodlari   
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }
        public string DovizKodu { get; set; }
        public string DovizAdi { get; set; }
        public int Oncelik { get; set; }
    }
}
