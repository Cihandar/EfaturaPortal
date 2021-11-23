﻿// <auto-generated />
using System;
using EfaturaPortal.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace EfaturaPortal.Migrations
{
    [DbContext(typeof(EfaturaPortalContext))]
    partial class EfaturaPortalContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.12")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("EfaturaPortal.Models.AppUser", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("nvarchar(450)");

                    b.Property<int>("AccessFailedCount")
                        .HasColumnType("int");

                    b.Property<string>("AdSoyad")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Avatar")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Email")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<bool>("EmailConfirmed")
                        .HasColumnType("bit");

                    b.Property<Guid>("FirmaId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<bool>("LockoutEnabled")
                        .HasColumnType("bit");

                    b.Property<DateTimeOffset?>("LockoutEnd")
                        .HasColumnType("datetimeoffset");

                    b.Property<string>("NormalizedEmail")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<string>("NormalizedUserName")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<string>("PasswordHash")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PhoneNumber")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("PhoneNumberConfirmed")
                        .HasColumnType("bit");

                    b.Property<string>("SecurityStamp")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("TwoFactorEnabled")
                        .HasColumnType("bit");

                    b.Property<string>("UserName")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<byte>("status")
                        .HasColumnType("tinyint");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedEmail")
                        .HasDatabaseName("EmailIndex");

                    b.HasIndex("NormalizedUserName")
                        .IsUnique()
                        .HasDatabaseName("UserNameIndex")
                        .HasFilter("[NormalizedUserName] IS NOT NULL");

                    b.ToTable("AspNetUsers");
                });

            modelBuilder.Entity("EfaturaPortal.Models.Cariler", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Adres")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("EfaturaPostaKutusu")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("EfaturaTarihi")
                        .HasColumnType("datetime2");

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("FirmaId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Ilce")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Sehir")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Silindi")
                        .HasColumnType("bit");

                    b.Property<DateTime>("SilmeTarihi")
                        .HasColumnType("datetime2");

                    b.Property<string>("Telefon")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Unvani")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("VergiDairesi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("VergiNumarasi")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Carilers");
                });

            modelBuilder.Entity("EfaturaPortal.Models.Fatura", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<double>("Artirim")
                        .HasColumnType("float");

                    b.Property<Guid>("CarilerId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<double>("DovizKuru")
                        .HasColumnType("float");

                    b.Property<Guid>("ETTN")
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("EfaturaDurum")
                        .HasColumnType("int");

                    b.Property<string>("FaturaNumarasi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FaturaSenaryo")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FaturaTipi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("FaturaTuru")
                        .HasColumnType("int");

                    b.Property<Guid>("FirmaId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<double>("Iskonto")
                        .HasColumnType("float");

                    b.Property<double>("Kdv")
                        .HasColumnType("float");

                    b.Property<string>("Notlar")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("OdemeHesapNo")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("OdemeKanali")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("OdemeSekli")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("OdemeTarihi")
                        .HasColumnType("datetime2");

                    b.Property<double>("OdenecekTutar")
                        .HasColumnType("float");

                    b.Property<string>("ParaBirimi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Saat")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("SeriNumaralarId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<bool>("Silindi")
                        .HasColumnType("bit");

                    b.Property<DateTime>("SilmeTarihi")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("Tarih")
                        .HasColumnType("datetime2");

                    b.Property<double>("Toplam")
                        .HasColumnType("float");

                    b.Property<string>("YaziylaTutar")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("CarilerId");

                    b.HasIndex("SeriNumaralarId");

                    b.ToTable("Faturas");
                });

            modelBuilder.Entity("EfaturaPortal.Models.FaturaSatir", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Aciklama")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("FaturaId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("FirmaId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("IskontoDurum")
                        .HasColumnType("nvarchar(max)");

                    b.Property<double>("IskontoOran")
                        .HasColumnType("float");

                    b.Property<int>("IskontoTutar")
                        .HasColumnType("int");

                    b.Property<double>("KdvOran")
                        .HasColumnType("float");

                    b.Property<double>("KdvTutar")
                        .HasColumnType("float");

                    b.Property<double>("KdvliTutar")
                        .HasColumnType("float");

                    b.Property<double>("Miktar")
                        .HasColumnType("float");

                    b.Property<string>("OlcuBirimi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Silindi")
                        .HasColumnType("bit");

                    b.Property<DateTime>("SilmeTarihi")
                        .HasColumnType("datetime2");

                    b.Property<int>("Sirano")
                        .HasColumnType("int");

                    b.Property<double>("Tutar")
                        .HasColumnType("float");

                    b.HasKey("Id");

                    b.HasIndex("FaturaId");

                    b.ToTable("FaturaSatirs");
                });

            modelBuilder.Entity("EfaturaPortal.Models.Firmalar", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Adres")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("FirmaTuru")
                        .HasColumnType("int");

                    b.Property<string>("Ilce")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PostaKodu")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Sehir")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Telefon")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Unvani")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("VergiDairesi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("VergiNumarasi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("WsGbKodu")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("WsKullaniciAdi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("WsPkKodu")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("WsSifre")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("YetkiliAdSoyad")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Firmalars");
                });

            modelBuilder.Entity("EfaturaPortal.Models.OlcuBirimleri", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Adi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("FirmaId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Kodu")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Silindi")
                        .HasColumnType("bit");

                    b.Property<DateTime>("SilmeTarihi")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.ToTable("OlcuBirimleris");
                });

            modelBuilder.Entity("EfaturaPortal.Models.ParaBirimleri", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Adi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("FirmaId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Kodu")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Silindi")
                        .HasColumnType("bit");

                    b.Property<DateTime>("SilmeTarihi")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.ToTable("ParaBirimleris");
                });

            modelBuilder.Entity("EfaturaPortal.Models.SeriNumaralar", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("FaturaTuru")
                        .HasColumnType("int");

                    b.Property<Guid>("FirmaId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("Oncelik")
                        .HasColumnType("int");

                    b.Property<string>("SablonAdi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("SablonDosyaAdi")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("SeriNo")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Silindi")
                        .HasColumnType("bit");

                    b.Property<DateTime>("SilmeTarihi")
                        .HasColumnType("datetime2");

                    b.Property<int>("SonFaturaNo")
                        .HasColumnType("int");

                    b.Property<DateTime>("SonFaturaTarihi")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.ToTable("SeriNumaralars");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRole", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<string>("NormalizedName")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedName")
                        .IsUnique()
                        .HasDatabaseName("RoleNameIndex")
                        .HasFilter("[NormalizedName] IS NOT NULL");

                    b.ToTable("AspNetRoles");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("ClaimType")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("RoleId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetRoleClaims");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("ClaimType")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserClaims");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.Property<string>("LoginProvider")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("ProviderKey")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("ProviderDisplayName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("LoginProvider", "ProviderKey");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserLogins");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("RoleId")
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("UserId", "RoleId");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetUserRoles");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("LoginProvider")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Value")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("UserId", "LoginProvider", "Name");

                    b.ToTable("AspNetUserTokens");
                });

            modelBuilder.Entity("EfaturaPortal.Models.Fatura", b =>
                {
                    b.HasOne("EfaturaPortal.Models.Cariler", "Cariler")
                        .WithMany()
                        .HasForeignKey("CarilerId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EfaturaPortal.Models.SeriNumaralar", "SeriNumaralar")
                        .WithMany()
                        .HasForeignKey("SeriNumaralarId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Cariler");

                    b.Navigation("SeriNumaralar");
                });

            modelBuilder.Entity("EfaturaPortal.Models.FaturaSatir", b =>
                {
                    b.HasOne("EfaturaPortal.Models.Fatura", "Fatura")
                        .WithMany()
                        .HasForeignKey("FaturaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Fatura");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.HasOne("EfaturaPortal.Models.AppUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.HasOne("EfaturaPortal.Models.AppUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EfaturaPortal.Models.AppUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.HasOne("EfaturaPortal.Models.AppUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });
#pragma warning restore 612, 618
        }
    }
}
