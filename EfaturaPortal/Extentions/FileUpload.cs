using EfaturaPortal.Application.Interfaces.FileUploads;
using EfaturaPortal.Models.ResultModel;
using Microsoft.AspNetCore.Hosting;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EfaturaPortal.Extentions
{
    public class FileUpload : IFileUpload
    {

        private readonly IWebHostEnvironment _env;

        public FileUpload(IWebHostEnvironment env)
        {
            _env = env;
        }

        public async Task<ResultJson> UploadFileXslt(string filePath, string name)
        {

            try
            {


                var uploadDirecotroy = "uploads/Xslt/";
                var uploadPath = Path.Combine(_env.WebRootPath, uploadDirecotroy);

                if (!Directory.Exists(uploadPath))
                    Directory.CreateDirectory(uploadPath);

                name = Guid.NewGuid().ToString() + "-" + name;
                var bytes = Convert.FromBase64String(filePath.Split(',')[1]);

                var fileName = Path.Combine(uploadPath, name);

                var xsltFile = Encoding.UTF8.GetString(bytes);

                using (var sWriter = new StreamWriter(fileName, false, Encoding.UTF8))
                {
                    sWriter.Write(xsltFile);
                    sWriter.Close();
                }

                return new ResultJson { Success = true, Message = name };
            }
            catch (Exception ex)
            {
                return new ResultJson { Success = false, Message = ex.Message };
            }




        }
    }
}
