using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EfaturaPortal.Application.Faturas.ViewModels;
using EfaturaPortal.Application.Firmalars.Commands;
using EfaturaPortal.Application.Firmalars.ViewModels;
using EfaturaPortal.Application.Interfaces.EfaturaApis;
using EfaturaPortal.Application.Interfaces.Firmalar;
using EfaturaPortal.Application.Interfaces.SeriNumaralars;
using EfaturaPortal.Application.Interfaces.Tools;
using EfaturaPortal.Application.SeriNumaralars.Commands;
using EfaturaPortal.Application.SeriNumaralars.ViewModels;

namespace EfaturaPortal.Application.EfaturaApi.Command
{
    public class CreateUbl : ICreateUbl
    {
        IFirmalarCrud _firmaCrud;
        ISeriNumaralarCrud _seriNumaralarCrud;
        IToolsCodes _toolsCodes;

        public CreateUbl(IFirmalarCrud firmalarCrud, ISeriNumaralarCrud seriNumaralarCrud, IToolsCodes toolsCodes)
        {
            _firmaCrud = firmalarCrud;
            _seriNumaralarCrud = seriNumaralarCrud;
            _toolsCodes = toolsCodes;
        }
        public async Task<string> Create(FaturaGetAllQueryViewModel faturaVM)
        {
            var invoice = new InvoiceType();

            invoice.UBLVersionID = new UBLVersionIDType { Value = "2.1" };
            invoice.CustomizationID = new CustomizationIDType { Value = "TR1.2" };

            invoice.ProfileID = await GetProfileIDType(faturaVM);

            invoice.ID = new IDType { Value = faturaVM.FaturaNumarasi };
            invoice.CopyIndicator = new CopyIndicatorType { Value = false };
            invoice.UUID = new UUIDType { Value = faturaVM.Id.ToString() };
            invoice.IssueDate = new IssueDateType { Value = faturaVM.Tarih };
            invoice.IssueTime = new IssueTimeType { Value = faturaVM.Tarih };

            invoice.InvoiceTypeCode = await GetInvoiceTypeCodeType(faturaVM);

            invoice.Note = await GetNoteType(faturaVM);

            invoice.DocumentCurrencyCode = new DocumentCurrencyCodeType { Value = faturaVM.Doviz };
            invoice.LineCountNumeric = new LineCountNumericType { Value = 1 };

            invoice.AdditionalDocumentReference = await GetDocumentReference(faturaVM); //Fatura Dizaynı Basılıyor...

            invoice.Signature = await GetSignatureTypes(faturaVM);  //E-imza / Mali Mühür için Gönderen Firma Bilgileri basılıyor...

            //invoice.AccountingSupplierParty = new SupplierPartyType





            return "";
        }

        private async Task<ProfileIDType> GetProfileIDType(FaturaGetAllQueryViewModel faturaVM)
        {
            switch (faturaVM.FaturaSenaryo)
            {
                case Models.Enum.FaturaSenaryo.Temel:
                    return new ProfileIDType { Value = "TEMELFATURA" };

                case Models.Enum.FaturaSenaryo.Ticari:
                    return new ProfileIDType { Value = "TICARIFATURA" };
                case Models.Enum.FaturaSenaryo.Kamu:
                    return new ProfileIDType { Value = "KAMUFATURA" };
                default:
                    return new ProfileIDType { Value = "TEMELFATURA" };
            }
        }

        private async Task<InvoiceTypeCodeType> GetInvoiceTypeCodeType(FaturaGetAllQueryViewModel faturaVM)
        {
            switch (faturaVM.FaturaTipi)
            {
                case Models.Enum.FaturaTipi.Satis:
                    return new InvoiceTypeCodeType { Value = "SATIS" };
                case Models.Enum.FaturaTipi.Iade:
                    return new InvoiceTypeCodeType { Value = "IADE" };
                case Models.Enum.FaturaTipi.Tevkifat:
                    return new InvoiceTypeCodeType { Value = "TEVKIFAT" };
                case Models.Enum.FaturaTipi.Istisna:
                    return new InvoiceTypeCodeType { Value = "ISTISNA" };
                default:
                    return new InvoiceTypeCodeType { Value = "SATIS" };
            }
        }

        private async Task<NoteType[]> GetNoteType(FaturaGetAllQueryViewModel faturaVM)
        {
            var _noteTypes = new List<NoteType>();

            _noteTypes.Add(new NoteType { Value = faturaVM.Notlar });

            _noteTypes.Add(new NoteType { Value = await _toolsCodes.YaziyaCevir(faturaVM.OdenecekTutar.ToString()) });

            return _noteTypes.ToArray();

        }

        private async Task<DocumentReferenceType[]> GetDocumentReference(FaturaGetAllQueryViewModel faturaVM)
        {
            var docref = new List<DocumentReferenceType>();


            if (!string.IsNullOrWhiteSpace(faturaVM.SeriNumaralar.SablonDosyaAdi) && File.Exists("/uploads/Xslt/" + faturaVM.SeriNumaralar.SablonDosyaAdi))
            {
                docref.Add(
                    new DocumentReferenceType
                    {
                        ID = new IDType { Value = Guid.NewGuid().ToString() },
                        IssueDate = new IssueDateType { Value = faturaVM.Tarih },
                        DocumentType = new DocumentTypeType { Value = "XSLT" },
                        Attachment = new AttachmentType
                        {
                            EmbeddedDocumentBinaryObject = new EmbeddedDocumentBinaryObjectType
                            {
                                characterSetCode = "UTF-8",
                                encodingCode = "Base64",
                                filename = "default.xslt",
                                mimeCode = "application/xml",
                                Value = await GetXSLTFiletoBinary(faturaVM.SeriNumaralar.SablonDosyaAdi)
                            }
                        }
                    });
            }
            docref.Add(
                new DocumentReferenceType
                {
                    ID = new IDType { Value = Guid.NewGuid().ToString() },
                    IssueDate = new IssueDateType { Value = faturaVM.Tarih },
                    DocumentTypeCode = new DocumentTypeCodeType { Value = "SendingType" },
                    DocumentType = new DocumentTypeType { Value = "ELEKTRONIK" }
                });


            return docref.ToArray();
        }

        private async Task<byte[]> GetXSLTFiletoBinary(string fileName)
        {
            var data = Encoding.UTF8.GetBytes(new StreamReader(new FileStream("/uploads/Xslt/" + fileName, FileMode.Open, FileAccess.Read), Encoding.UTF8).ReadToEnd());
            return data;

        }

        private async Task<SignatureType[]> GetSignatureTypes(FaturaGetAllQueryViewModel faturaVM)
        {
            var sign = new List<SignatureType>();

            string sirketturu = "VKN";
            if (faturaVM.Firmalar.VergiNumarasi.Length == 11) sirketturu = "TCKN";

            sign.Add(new SignatureType
            {

                ID = new IDType { schemeID = "VKN_TCKN", Value = faturaVM.Firmalar.VergiNumarasi },
                SignatoryParty = await GetSenderPartyType(faturaVM, sirketturu)

            });


            return sign.ToArray();
        }

        private async Task<PartyType> GetSenderPartyType(FaturaGetAllQueryViewModel faturaVM, string sirketturu)
        {
          var party =  new PartyType
            {

                PartyIdentification = new[]
                {
                    new PartyIdentificationType
                    {
                        ID= new IDType { schemeID = sirketturu,Value =faturaVM.Firmalar.VergiNumarasi }
                    //},
                    //new PartyIdentificationType
                    //{
                    //    ID = new IDType { schemeID = "MERSISNO", Value =  faturaVM.Firmalar.MersisNo }
                    //},
                    //new PartyIdentificationType
                    //{
                    //    ID = new IDType { schemeID = "TICARETSICILNO", Value =  faturaVM.Firmalar.TicariSicilNo }
                    //}

                }

            },
                PostalAddress = new AddressType
                {
                    CitySubdivisionName = new CitySubdivisionNameType { Value = faturaVM.Firmalar.Ilce },
                    CityName = new CityNameType { Value = faturaVM.Firmalar.Sehir },
                    Country = new CountryType { Name = new NameType1 { Value = "Türkiye" } },
                    StreetName = new StreetNameType { Value = faturaVM.Firmalar.Adres },
                    BuildingName = new BuildingNameType { Value = "" },
                    PostalZone = new PostalZoneType { Value = "" },
                    Room = new RoomType { Value = "" },
                    Region = new RegionType { Value = "" },
                    BlockName = new BlockNameType { Value = "" }
                },
                PartyName = new PartyNameType { Name = new NameType1 { Value = faturaVM.Firmalar.Unvani } },
                //  WebsiteURI = new WebsiteURIType {  Value=faturaVM.Firmalar.WebSitesi},
                Contact = new ContactType { ElectronicMail = new ElectronicMailType { Value = faturaVM.Firmalar.Email }, Telephone = new TelephoneType { Value = faturaVM.Firmalar.Telefon } },
                PartyTaxScheme = new PartyTaxSchemeType { TaxScheme = new TaxSchemeType { Name = new NameType1 { Value = faturaVM.Firmalar.VergiNumarasi } } }




            };

            if (sirketturu == "TCKN")
            {
                var adlar = faturaVM.Firmalar.Unvani.Split(' ');
                if (adlar.Length == 2) party.Person = new PersonType { FirstName = new FirstNameType { Value = adlar[0] }, FamilyName = new FamilyNameType { Value = adlar[1] } };
                else if (adlar.Length == 3) party.Person = new PersonType { FirstName = new FirstNameType { Value = adlar[0] }, MiddleName = new MiddleNameType { Value = adlar[1] }, FamilyName = new FamilyNameType { Value = adlar[2] } };
                else if (adlar.Length == 4) party.Person = new PersonType { FirstName = new FirstNameType { Value = adlar[0] }, MiddleName = new MiddleNameType { Value = adlar[1] + " " + adlar[2] }, FamilyName = new FamilyNameType { Value = adlar[3] } };
                else { }
            }

            return party;

        }

        //private async Task<SupplierPartyType> GetSupplierParty



    }
}
