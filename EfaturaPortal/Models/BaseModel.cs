using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    public class BaseModel
    {
        public Guid Id { get; set; }

        [ForeignKey("Firmalar")]
        public Guid FirmaId { get; set; }
        public bool Silindi { get; set; }
        public DateTime SilmeTarihi { get; set; }
        
    }
}
