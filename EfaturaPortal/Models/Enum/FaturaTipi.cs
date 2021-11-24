using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models.Enum
{
    public enum FaturaTipi
    {
        [Display(Name = "Satış Faturası")]
        Satis = 0,
        [Display(Name = "İade Faturası")]
        Iade = 1,
        [Display(Name = "Tevkifatlı Fatura")]
        Tevkifat = 2,
        [Display(Name = "İstisnalı Fatura (KDV'siz)")]
        Istisna = 3
    }
}
