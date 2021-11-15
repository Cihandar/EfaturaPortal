using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FluentValidation;
using EfaturaPortal.Application.SeriNumaralars.ViewModels;

namespace EfaturaPortal.Application.SeriNumaralars.Validators
{
    public class SeriNumaralarValidator : AbstractValidator<SeriNumaralarGetAllQueryViewModel>
    {

        public SeriNumaralarValidator()
        {
            RuleFor(x => x.SeriNo).NotEmpty().WithMessage("Bu alanı boş geçemezsiniz.").MaximumLength(4).WithMessage("Çok Fazla Karakter Girdiniz.").MinimumLength(3).WithMessage("En az 3 Karakter Girebilirsiniz.") ;

        }

    }
}
