using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    public class FaturaSatirKdvler
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }
        public Guid FaturaSatirId { get; set; }
        public string Kodu { get; set; }
        public string Adi { get; set; }
        public float KdvOran { get; set; }
        public float KdvTutar { get; set; }


        public virtual FaturaSatir FaturaSatir { get; set; }
    }
}
