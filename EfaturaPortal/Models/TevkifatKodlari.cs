using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EfaturaPortal.Models
{
    public class TevkifatKodlari 
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }
        public string Kodu { get; set; }
        public string Aciklama { get; set; }
        public string Oran { get; set; }
    }
}
