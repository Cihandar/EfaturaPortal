using EfaturaPortal.Application.Firmalars.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Application.Interfaces.Firmalar
{
//TODO:Interfaceleri sadece Query Olarak ayirmaya gerek kalmayabilir , TUM CRUD islemlerinin kurallarini burdan yazabilirsin

    public interface IFirmalarGetQuery
    {
           List<FirmalarGetAllQueryViewModel> GetAll(Guid FirmaId);
           FirmalarGetAllQueryViewModel GetById(Guid FirmaId);
    }
}
