using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models.ResultModel
{
    public class ResultInvoiceStatus
    {
        public Guid Uuid { get; set; }
        public int GibCode { get; set; }
        public string GibMessage { get; set; }
        public string Message { get; set; }
        public string InvoiceNumber { get; set; }
        public bool Error { get; set; } = false;
        public string Icon { get; set; }
        public EfaturaDurum EfaturaDurum { get; set; }

    }
}
