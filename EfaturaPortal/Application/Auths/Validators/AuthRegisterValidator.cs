using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Application.Auths.ViewModels;
using EfaturaPortal.Models;
using FluentValidation;
using EfaturaPortal.Application.Firmalars.Validators;


namespace EfaturaPortal.Application.Auths.Validators
{
    public class AuthRegisterValidator : AbstractValidator<AuthRegisterViewModel>
    {
        public AuthRegisterValidator()
        {

            RuleFor(x => x.Email).NotEmpty().WithMessage("Bu alanı boş geçemezsiniz").EmailAddress().WithMessage("Geçerli Bir Email Girin");
            RuleFor(x => x.HizmetSozlesmesi).NotEmpty().When(x => x.HizmetSozlesmesi == true).WithMessage("Lütfen Hizmet Sözleşmesini Onaylayınız");
            RuleFor(x => x.IletiGonderimi).NotEmpty().When(x => x.HizmetSozlesmesi == true).WithMessage("Lütfen İleti Gönderimini Onaylayınız");
            RuleFor(x => x.Kvkk).NotEmpty().When(x => x.HizmetSozlesmesi == true).WithMessage("Lütfen Kvkk Metnini Onaylayınız");
            RuleFor(x => x.Firma).SetValidator(new FirmalarValidator());
 

            //RuleForEach(x => x.Firma).ChildRules(frm =>
            //  {
            //      frm.RuleFor(x => x.).NotEmpty().WithMessage("Bu alanı boş geçemezsiniz.").MaximumLength(150).WithMessage("Çok Fazla Karakter Girdiniz.");
            //      frm.RuleFor(x => x.VergiNumarasi).NotEmpty().WithMessage("Bu alanı boş geçemezsiniz.").MinimumLength(10).WithMessage("10 haneli Vergi numarası ve 11 haneli Tc numaranızı yazın.").MaximumLength(11).WithMessage("10 haneli Vergi numarası ve 11 haneli Tc numaranızı yazın.");
            //      frm.RuleFor(x => x.Telefon).NotEmpty().WithMessage("Bu alanı boş geçemezsiniz");
            //  });
        }
    }
}
