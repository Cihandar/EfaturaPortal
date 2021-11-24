using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models.ExtentionsModel
{
    public class EmailSettings
    {
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Smtp { get; set; }
        public int Port { get; set; }
        public bool Ssl { get; set; }
    }
}
