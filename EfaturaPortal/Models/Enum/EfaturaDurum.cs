using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models.Enum
{
    public enum EfaturaDurum
    {
        [Display(Name = "Beklemede")]
        Beklemede =0,
        [Display(Name = "Yüklendi")]
        Yuklendi =1,
        [Display(Name = "Gönderildi")]
        Gonderildi =2,
        [Display(Name = "İptal Edilmiş")]
        Iptal =3
    }
}
