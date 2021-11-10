using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.Email
{
    public interface ISendEmail
    {
        Boolean Send(string to, string subject, string message, string name, string Password, string template);
    }
}
