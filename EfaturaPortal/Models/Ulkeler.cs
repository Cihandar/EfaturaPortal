using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EfaturaPortal.Models
{
    public class Ulkeler
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }
        public string UlkeAdi { get; set; }
        public string Alpha2 { get; set; }
        public string Alpha3 { get; set; }
        public string Numeric { get; set; }
        public string Oncelik { get; set; }

    }
}
