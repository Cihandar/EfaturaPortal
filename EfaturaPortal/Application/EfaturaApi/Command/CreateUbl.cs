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
using EfaturaPortal.Application.FaturaSatirs.ViewModels;
using EfaturaPortal.Models;
using System.Xml;
using System.Xml.Serialization;
using Microsoft.AspNetCore.Hosting;

namespace EfaturaPortal.Application.EfaturaApi.Command
{
    public class CreateUbl : ICreateUbl
    {
        IFirmalarCrud _firmaCrud;
        ISeriNumaralarCrud _seriNumaralarCrud;
        IToolsCodes _toolsCodes;
        private readonly IWebHostEnvironment _environment;
        public CreateUbl(IFirmalarCrud firmalarCrud, ISeriNumaralarCrud seriNumaralarCrud, IToolsCodes toolsCodes,IWebHostEnvironment environment)
        {
            _firmaCrud = firmalarCrud;
            _seriNumaralarCrud = seriNumaralarCrud;
            _toolsCodes = toolsCodes;
            _environment = environment;
        }
        public async Task<string> Create(FaturaGetAllQueryViewModel faturaVM, List<KdvlerViewModel> kdvler)
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

            invoice.AccountingSupplierParty = new SupplierPartyType { Party = await GetSenderPartyType(faturaVM) };  //Gönderici Fatura Bilgileri...

            invoice.AccountingCustomerParty = new CustomerPartyType { Party = await GetCustomerPartyType(faturaVM) }; // Alıcı Fatura Bilgileri...

            invoice.TaxTotal = await GetTaxTotalTypes(faturaVM, kdvler);

            invoice.LegalMonetaryTotal = await GetMonetaryTotal(faturaVM);

            invoice.WithholdingTaxTotal = await GetWithHoldingTaxTotal(faturaVM);

            invoice.InvoiceLine = await GetInvoiceLineTypes(faturaVM);


            var settings = new XmlWriterSettings { OmitXmlDeclaration = true, Indent = true };
            var ms = new MemoryStream();
            var writer = XmlWriter.Create(ms, settings);
            var srl = new XmlSerializer(invoice.GetType());
            srl.Serialize(writer, invoice, await namespacesgetir());
            ms.Flush();
            ms.Seek(0, SeekOrigin.Begin);
            var srRead = new StreamReader(ms, Encoding.GetEncoding("UTF-8"), false);
            var readXml = srRead.ReadToEnd();

            return readXml;
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

            var designfile = Path.Combine(_environment.WebRootPath, "uploads\\Xslt\\" + faturaVM.SeriNumaralar.SablonDosyaAdi);

            if (!string.IsNullOrWhiteSpace(faturaVM.SeriNumaralar.SablonDosyaAdi) && File.Exists(designfile))
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
                                Value = await GetXSLTFiletoBinary(designfile)
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
            var data = Encoding.UTF8.GetBytes(new StreamReader(new FileStream(fileName, FileMode.Open, FileAccess.Read), Encoding.UTF8).ReadToEnd());
            return data;

        }

        private async Task<SignatureType[]> GetSignatureTypes(FaturaGetAllQueryViewModel faturaVM)
        {
            var sign = new List<SignatureType>();

            sign.Add(new SignatureType
            {

                ID = new IDType { schemeID = "VKN_TCKN", Value = faturaVM.Firmalar.VergiNumarasi },
                SignatoryParty = await GetSenderPartyType(faturaVM)

            });


            return sign.ToArray();
        }

        private async Task<PartyType> GetSenderPartyType(FaturaGetAllQueryViewModel faturaVM)
        {
            string sirketturu = "VKN";
            if (faturaVM.Firmalar.VergiNumarasi.Length == 11) sirketturu = "TCKN";

            var party = new PartyType
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

        private async Task<PartyType> GetCustomerPartyType(FaturaGetAllQueryViewModel faturaVM)
        {
            var party = new PartyType();

            string alicifirmaturu = "";
            if (faturaVM.Cariler.VergiNumarasi.Length == 10) alicifirmaturu = "VKN"; else if (faturaVM.Cariler.VergiNumarasi.Length == 11) alicifirmaturu = "TCKN"; else { }

            party.PartyIdentification = new[] { new PartyIdentificationType { ID = new IDType { schemeID = alicifirmaturu, Value = faturaVM.Cariler.VergiNumarasi } } };

            party.PartyName = new PartyNameType { Name = new NameType1 { Value = faturaVM.Cariler.Unvani } };
            party.PostalAddress = new AddressType
            {
                CityName = new CityNameType { Value = faturaVM.Cariler.Sehir },
                CitySubdivisionName = new CitySubdivisionNameType { Value = faturaVM.Cariler.Ilce },
                StreetName = new StreetNameType { Value = faturaVM.Cariler.Adres },
                Country = new CountryType { Name = new NameType1 { Value = "Türkiye" } }
            };
            party.PartyTaxScheme = new PartyTaxSchemeType { TaxScheme = new TaxSchemeType { Name = new NameType1 { Value = faturaVM.Cariler.VergiDairesi } } };

            if (alicifirmaturu == "TCKN")
            {
                var adlar = faturaVM.Cariler.Unvani.Split(' ');
                if (adlar.Length == 2) party.Person = new PersonType { FirstName = new FirstNameType { Value = adlar[0] }, FamilyName = new FamilyNameType { Value = adlar[1] } };
                else if (adlar.Length == 3) party.Person = new PersonType { FirstName = new FirstNameType { Value = adlar[0] }, MiddleName = new MiddleNameType { Value = adlar[1] }, FamilyName = new FamilyNameType { Value = adlar[2] } };
                else if (adlar.Length >= 4) party.Person = new PersonType { FirstName = new FirstNameType { Value = adlar[0] }, MiddleName = new MiddleNameType { Value = adlar[1] + " " + adlar[2] }, FamilyName = new FamilyNameType { Value = adlar[3] } };
                else { }
            }


            return party;

        }


        private async Task<TaxTotalType[]> GetTaxTotalTypes(FaturaGetAllQueryViewModel faturaVM, List<KdvlerViewModel> kdvler)
        {
            var taxs = new List<TaxTotalType>();

            foreach (var kdv in kdvler)
            {
                var line = new TaxTotalType();

                line.TaxAmount = new TaxAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(kdv.KdvTutar.ToString()) };

                List<TaxSubtotalType> stl = new List<TaxSubtotalType>();
                TaxSubtotalType tx = new TaxSubtotalType();

                tx.TaxableAmount = new TaxableAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(kdv.Tutar.ToString()) };
                tx.TaxAmount = new TaxAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(kdv.KdvTutar.ToString()) };
                tx.CalculationSequenceNumeric = new CalculationSequenceNumericType { Value = 1 };
                tx.Percent = new PercentType1 { Value = await _toolsCodes.toDecimal(kdv.KdvOran.ToString()) };

                if (kdv.KdvOran < 1)
                {
                    tx.TaxCategory = new TaxCategoryType
                    {
                        TaxScheme = new TaxSchemeType { Name = new NameType1 { Value = "KDV" }, TaxTypeCode = new TaxTypeCodeType { Value = "0015" } },
                        TaxExemptionReason = new TaxExemptionReasonType { Value = kdv.IstisnaAciklama },
                        TaxExemptionReasonCode = new TaxExemptionReasonCodeType { Value = kdv.IstisnaKodu }
                    };
                }
                else
                {
                    tx.TaxCategory = new TaxCategoryType { TaxScheme = new TaxSchemeType { Name = new NameType1 { Value = "KDV" }, TaxTypeCode = new TaxTypeCodeType { Value = "0015" } } };
                }

                stl.Add(tx);
                line.TaxSubtotal = stl.ToArray();
                taxs.Add(line);

            }

            return taxs.ToArray();
        }

        private async Task<MonetaryTotalType> GetMonetaryTotal(FaturaGetAllQueryViewModel faturaVM)
        {
            var mtt = new MonetaryTotalType();

            mtt.LineExtensionAmount = new LineExtensionAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal((faturaVM.Toplam + faturaVM.Iskonto).ToString()) };
            mtt.TaxExclusiveAmount = new TaxExclusiveAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(faturaVM.Toplam.ToString()) };
            mtt.TaxInclusiveAmount = new TaxInclusiveAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal((faturaVM.OdenecekTutar).ToString()) };
            if (faturaVM.Iskonto > 0) mtt.AllowanceTotalAmount = new AllowanceTotalAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal((faturaVM.Iskonto.ToString())) };
            //    if (fatura.ArtirimToplam > 0) mtt.ChargeTotalAmount = new ChargeTotalAmountType { currencyID = faturaVM.Doviz, Value = mat.decimalecevir(fatura.ArtirimToplam.ToString()) };
            mtt.PayableAmount = new PayableAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(faturaVM.OdenecekTutar.ToString()) };





            return mtt;
        }

        private async Task<TaxTotalType[]> GetWithHoldingTaxTotal(FaturaGetAllQueryViewModel faturaVM)
        {
            var taxs = new List<TaxTotalType>();



            var tevkifatkodu = "";
            var tevkifatoran = "";
            decimal oran = 0;
            foreach (var x in faturaVM.FaturaSatir)
            {
                if (!string.IsNullOrEmpty(x.TevkifatKodu) && x.TevkifatKodu!="-1")
                {
                    tevkifatkodu = x.TevkifatKodu;
                    tevkifatoran = x.TevkifatOran;
                    if (tevkifatoran.Split('/').Length > 0)
                        oran = (await _toolsCodes.toDecimal(tevkifatoran.Split('/')[0])) * 10;
                }
            }

            var tx = new TaxTotalType
            {

                TaxAmount = new TaxAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(faturaVM.TevkifatToplam.ToString()) },
                TaxSubtotal = new[]
                                {
                                     new TaxSubtotalType
                                     {

                                         TaxableAmount = new TaxableAmountType { currencyID=faturaVM.Doviz, Value = await _toolsCodes.toDecimal(faturaVM.Kdv.ToString()) },
                                         Percent = new PercentType1 { Value = oran },
                                         CalculationSequenceNumeric= new CalculationSequenceNumericType { Value =1 },
                                         TaxAmount =  new TaxAmountType { currencyID="TRY", Value = await _toolsCodes.toDecimal(faturaVM.TevkifatToplam.ToString()) },
                                         TaxCategory = new TaxCategoryType { Name = new NameType1 { Value=tevkifatkodu } , TaxScheme = new TaxSchemeType  { Name      = new NameType1 { Value=tevkifatkodu }, TaxTypeCode = new TaxTypeCodeType { Value = tevkifatkodu.Split('-')[0] } }  }
                                     }
                                }
            };

            taxs.Add(tx);

            return taxs.ToArray();
        }

        private async Task<InvoiceLineType[]> GetInvoiceLineTypes(FaturaGetAllQueryViewModel faturaVM)
        {
            var iline = new List<InvoiceLineType>();
            var ln = new InvoiceLineType();

            foreach (var x in faturaVM.FaturaSatir)
            {
                ln.ID = new IDType { Value = x.Sirano.ToString() };
                ln.InvoicedQuantity = new InvoicedQuantityType { Value = await _toolsCodes.toDecimal(x.Miktar.ToString()), unitCode = x.OlcuBirimleri.Kodu };
                ln.LineExtensionAmount = new LineExtensionAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(x.Tutar.ToString()) };
                ln.Item = new ItemType { Description = new DescriptionType { Value = x.Aciklama }, Name = new NameType1 { Value = x.Aciklama } };
                ln.Price = new PriceType { PriceAmount = new PriceAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(x.BirimFiyat.ToString()) } };

                var tax = new TaxTotalType();
                tax.TaxAmount = new TaxAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(x.KdvTutar.ToString()) };
                tax.TaxAmount = new TaxAmountType { currencyID = "TRY", Value = await _toolsCodes.toDecimal(x.KdvTutar.ToString()) };

                List<TaxSubtotalType> txsub = new List<TaxSubtotalType>();

                txsub.Add(await GetTaxSubtotalTypes(faturaVM.Doviz, "0015", "KDV", x.IstisnaKodlari, x.KdvliTutar, x.Tutar, x.KdvOran));


                foreach (var kdvler in x.FaturaSatirKdvler)
                {
                    txsub.Add(await GetTaxSubtotalTypes(faturaVM.Doviz, kdvler.Kodu, kdvler.Adi, null, kdvler.KdvTutar, x.Tutar, kdvler.KdvOran));
                }

                tax.TaxSubtotal = txsub.ToArray();

                ln.TaxTotal = tax;

                //Tevkifatlar Ekleniyor...
                if (x.TevkifatTutar > 0)
                {
                    decimal oran = 0;
                    if (x.TevkifatOran.Split('/').Length == 2) oran = (await _toolsCodes.toDecimal(x.TevkifatOran.Split('/')[0])) * 10;
                    tax = new TaxTotalType();
                    txsub.Clear();
                    var sub = new TaxSubtotalType();
                    tax.TaxAmount = new TaxAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(x.TevkifatTutar.ToString()) };
                    sub.Percent = new PercentType1 { Value = oran };
                    sub.TaxableAmount = new TaxableAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(x.KdvTutar.ToString()) };
                    sub.TaxAmount = new TaxAmountType { currencyID = faturaVM.Doviz, Value = await _toolsCodes.toDecimal(x.TevkifatTutar.ToString()) };
                    sub.TaxCategory = new TaxCategoryType
                    {
                        Name = new NameType1 { Value = x.TevkifatKodu },
                        TaxScheme = new TaxSchemeType
                        {
                            Name = new NameType1
                            { Value = x.TevkifatKodu },
                            TaxTypeCode = new TaxTypeCodeType
                            {
                                Value = x.TevkifatKodu.Split('-')[0]
                            }
                        }
                    };

                    txsub.Add(sub);
                    tax.TaxSubtotal = txsub.ToArray();
                    ln.WithholdingTaxTotal = new[] { tax };
                }
                //Tevkifat Sonu

                if (x.IskontoTutar > 0)
                {
                    decimal indoran = 0;
                    if (x.IskontoOran > 0) indoran = await _toolsCodes.toDecimal(x.IskontoOran.ToString()) / 100;
                    List<AllowanceChargeType> ac = new List<AllowanceChargeType>();
                    ac.Add(new AllowanceChargeType
                    {
                        ChargeIndicator = new ChargeIndicatorType { Value = false },
                        Amount = new AmountType2 { Value = await _toolsCodes.toDecimal(x.IskontoTutar.ToString()), currencyID = faturaVM.Doviz },
                        MultiplierFactorNumeric = new MultiplierFactorNumericType { Value = indoran }
                    });

                    ln.AllowanceCharge = ac.ToArray();
                }

                iline.Add(ln);



            }

            return iline.ToArray();
        }

        private async Task<TaxSubtotalType> GetTaxSubtotalTypes(string Doviz, string Kodu, string Adi, IstisnaKodlari istisna, float KdvTutar, float Tutar, float KdvOran)
        {


            var sub = new TaxSubtotalType();
            sub.Percent = new PercentType1 { Value = await _toolsCodes.toDecimal(KdvOran.ToString()) };
            if (KdvOran < 1)
            {

                sub.TaxCategory = new TaxCategoryType
                {
                    Name = new NameType1 { Value = Adi },
                    TaxScheme = new TaxSchemeType { Name = new NameType1 { Value = Adi }, TaxTypeCode = new TaxTypeCodeType { Value = Kodu } },
                    TaxExemptionReason = new TaxExemptionReasonType { Value = istisna.Aciklama },
                    TaxExemptionReasonCode = new TaxExemptionReasonCodeType { Value = istisna.Kodu }
                };
            }
            else
            {
                sub.TaxCategory = new TaxCategoryType { Name = new NameType1 { Value = Adi }, TaxScheme = new TaxSchemeType { Name = new NameType1 { Value = Adi }, TaxTypeCode = new TaxTypeCodeType { Value = Kodu } } };
            }

            sub.CalculationSequenceNumeric = new CalculationSequenceNumericType { Value = 1 };
            sub.TaxAmount = new TaxAmountType { currencyID = Doviz, Value = await _toolsCodes.toDecimal(KdvTutar.ToString()) };
            sub.TaxableAmount = new TaxableAmountType { currencyID = Doviz, Value = await _toolsCodes.toDecimal(Tutar.ToString()) };

            return sub;

        }

        private async Task<XmlSerializerNamespaces> namespacesgetir()
        {
            var ms = new XmlSerializerNamespaces();
            ms.Add("n4", "http://www.altova.com/samplexml/other-namespace");
            ms.Add("cbc", "urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2");
            ms.Add("xades", "http://uri.etsi.org/01903/v1.3.2#");
            ms.Add("ds", "http://www.w3.org/2000/09/xmldsig#");
            ms.Add("ext", "urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2");
            ms.Add("cac", "urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2");
            ms.Add("xsi", "http://www.w3.org/2001/XMLSchema-instance");
            ms.Add("ubltr", "urn:oasis:names:specification:ubl:schema:xsd:TurkishCustomizationExtensionComponents");
            ms.Add("udt", "urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2");
            ms.Add("ccts", "urn:un:unece:uncefact:documentation:2");
            ms.Add("qdt", "urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2");


            return ms;

        }

    }
}
