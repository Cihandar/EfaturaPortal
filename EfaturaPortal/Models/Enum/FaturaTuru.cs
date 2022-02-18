using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models.Enum
{
    public enum FaturaTuru
    {
        [Display(Name = "E-Fatura")]
        EFatura =0,
        [Display(Name = "E-Arşiv")]
        EArsiv =1,
        [Display(Name = "E-SMM")]
        ESmm =2
    }
}
