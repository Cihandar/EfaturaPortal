using EfaturaPortal.Models.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.Tools
{
    public interface IToolsCodes
    {
        Task<string> YaziyaCevir(string gelentutar, string doviz);
        Task<decimal> toDecimal(string value);
        Task<float> toFloat(string value);
        Task<byte[]> GetXSLTFiletoBinary(string fileName,FaturaTuru fturu);
        Task<string> esmmsablongetir();
    }
}
