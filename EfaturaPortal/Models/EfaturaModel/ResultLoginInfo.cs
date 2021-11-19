using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Extentions
{
    public class ResultLoginInfo
    {
        public bool Success { get; set; }
        public string SessionId { get; set; }
        public string ErrorMessagge { get; set; }
    }
}
