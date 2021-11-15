using EfaturaPortal.Extentions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.FileUploads
{
    public interface IFileUpload
    {
        Task<ResultJson> UploadFileXslt(string filePath, string name);
    }
}
