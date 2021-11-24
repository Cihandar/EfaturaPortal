using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models.Enum
{
    public enum FaturaSenaryo
    {
        [Display(Name = "Temel Fatura")]
        Temel = 0,
        [Display(Name = "Ticari Fatura")]
        Ticari = 1,
        [Display(Name = "Kamu Faturası")]
        Kamu = 2,

    }
}
