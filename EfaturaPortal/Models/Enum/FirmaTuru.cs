using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models.Enum
{
    public enum FirmaTuru
    {
        [Display(Name = "Ticari - E-Fatura")]
        Ticari =0,
        [Display(Name = "Serbest Meslek - E-Smm")]
        Smm =1
    }
}
