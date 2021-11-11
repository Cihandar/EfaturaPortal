using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FluentValidation;
using EfaturaPortal.Application.Firmalars.ViewModels;

namespace EfaturaPortal.Application.Firmalars.Validators
{
    public class FirmalarValidator : AbstractValidator<FirmalarGetAllQueryViewModel>
    {

        public FirmalarValidator()
        {
            RuleFor(x => x.Unvani).NotEmpty().WithMessage("Bu alanı boş geçemezsiniz.").MaximumLength(150).WithMessage("Çok Fazla Karakter Girdiniz.");
            RuleFor(x => x.VergiNumarasi).NotEmpty().WithMessage("Bu alanı boş geçemezsiniz.").MinimumLength(10).WithMessage("10 haneli Vergi numarası ve 11 haneli Tc numaranızı yazın.").MaximumLength(11).WithMessage("10 haneli Vergi numarası ve 11 haneli Tc numaranızı yazın.");
            RuleFor(x => x.Telefon).NotEmpty().WithMessage("Bu alanı boş geçemezsiniz");
        }

    }
}
