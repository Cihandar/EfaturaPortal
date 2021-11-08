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
                .HasAnnotation("ProductVersion", "2.1.0-rtm-30799")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("EfaturaPortal.Models.AppUser", b =>
                {
                    b.Property<string>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("AccessFailedCount");

                    b.Property<string>("Avatar");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken();

                    b.Property<string>("Email")
                        .HasMaxLength(256);

                    b.Property<bool>("EmailConfirmed");

                    b.Property<Guid>("FirmaId");

                    b.Property<bool>("LockoutEnabled");

                    b.Property<DateTimeOffset?>("LockoutEnd");

                    b.Property<string>("NormalizedEmail")
                        .HasMaxLength(256);

                    b.Property<string>("NormalizedUserName")
                        .HasMaxLength(256);

                    b.Property<string>("PasswordHash");

                    b.Property<string>("PhoneNumber");

                    b.Property<bool>("PhoneNumberConfirmed");

                    b.Property<string>("SecurityStamp");

                    b.Property<bool>("TwoFactorEnabled");

                    b.Property<string>("UserName")
                        .HasMaxLength(256);

                    b.Property<byte>("status");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedEmail")
                        .HasName("EmailIndex");

                    b.HasIndex("NormalizedUserName")
                        .IsUnique()
                        .HasName("UserNameIndex")
                        .HasFilter("[NormalizedUserName] IS NOT NULL");

                    b.ToTable("AspNetUsers");
                });

            modelBuilder.Entity("EfaturaPortal.Models.Cariler", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Adres");

                    b.Property<string>("EfaturaPostaKutusu");

                    b.Property<DateTime>("EfaturaTarihi");

                    b.Property<string>("Email");

                    b.Property<Guid>("FirmaId");

                    b.Property<string>("Ilce");

                    b.Property<string>("Sehir");

                    b.Property<bool>("Silindi");

                    b.Property<DateTime>("SilmeTarihi");

                    b.Property<string>("Telefon");

                    b.Property<string>("Unvani");

                    b.Property<string>("VergiDairesi");

                    b.Property<string>("VergiNumarasi");

                    b.HasKey("Id");

                    b.ToTable("Carilers");
                });

            modelBuilder.Entity("EfaturaPortal.Models.Fatura", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<double>("Artirim");

                    b.Property<Guid>("CarilerId");

                    b.Property<double>("DovizKuru");

                    b.Property<Guid>("ETTN");

                    b.Property<int>("EfaturaDurum");

                    b.Property<string>("FaturaSenaryo");

                    b.Property<string>("FaturaTipi");

                    b.Property<int>("FaturaTuru");

                    b.Property<Guid>("FirmaId");

                    b.Property<double>("Iskonto");

                    b.Property<double>("Kdv");

                    b.Property<string>("Notlar");

                    b.Property<string>("OdemeHesapNo");

                    b.Property<string>("OdemeKanali");

                    b.Property<string>("OdemeSekli");

                    b.Property<DateTime>("OdemeTarihi");

                    b.Property<double>("OdenecekTutar");

                    b.Property<string>("ParaBirimi");

                    b.Property<Guid>("SeriNumaralarId");

                    b.Property<bool>("Silindi");

                    b.Property<DateTime>("SilmeTarihi");

                    b.Property<DateTime>("Tarih");

                    b.Property<double>("Toplam");

                    b.Property<string>("YaziylaTutar");

                    b.HasKey("Id");

                    b.ToTable("Faturas");
                });

            modelBuilder.Entity("EfaturaPortal.Models.FaturaSatir", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Aciklama");

                    b.Property<Guid>("FaturaId");

                    b.Property<Guid>("FirmaId");

                    b.Property<string>("IskontoDurum");

                    b.Property<double>("IskontoOran");

                    b.Property<int>("IskontoTutar");

                    b.Property<double>("KdvOran");

                    b.Property<double>("KdvTutar");

                    b.Property<double>("KdvliTutar");

                    b.Property<double>("Miktar");

                    b.Property<string>("OlcuBirimi");

                    b.Property<bool>("Silindi");

                    b.Property<DateTime>("SilmeTarihi");

                    b.Property<int>("Sirano");

                    b.Property<double>("Tutar");

                    b.HasKey("Id");

                    b.ToTable("FaturaSatirs");
                });

            modelBuilder.Entity("EfaturaPortal.Models.Firmalar", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Adres");

                    b.Property<string>("Email");

                    b.Property<int>("FirmaTuru");

                    b.Property<string>("Ilce");

                    b.Property<string>("PostaKodu");

                    b.Property<string>("Sehir");

                    b.Property<string>("Telefon");

                    b.Property<string>("Unvani");

                    b.Property<string>("VergiDairesi");

                    b.Property<string>("VergiNumarasi");

                    b.Property<string>("WsGbKodu");

                    b.Property<string>("WsKullaniciAdi");

                    b.Property<string>("WsPkKodu");

                    b.Property<string>("WsSifre");

                    b.Property<string>("YetkiliAdSoyad");

                    b.HasKey("Id");

                    b.ToTable("Firmalars");
                });

            modelBuilder.Entity("EfaturaPortal.Models.OlcuBirimleri", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Adi");

                    b.Property<Guid>("FirmaId");

                    b.Property<string>("Kodu");

                    b.Property<bool>("Silindi");

                    b.Property<DateTime>("SilmeTarihi");

                    b.HasKey("Id");

                    b.ToTable("OlcuBirimleris");
                });

            modelBuilder.Entity("EfaturaPortal.Models.ParaBirimleri", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Adi");

                    b.Property<Guid>("FirmaId");

                    b.Property<string>("Kodu");

                    b.Property<bool>("Silindi");

                    b.Property<DateTime>("SilmeTarihi");

                    b.HasKey("Id");

                    b.ToTable("ParaBirimleris");
                });

            modelBuilder.Entity("EfaturaPortal.Models.SeriNumaralar", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("FaturaTuru");

                    b.Property<Guid>("FirmaId");

                    b.Property<int>("Oncelik");

                    b.Property<byte[]>("Sablon");

                    b.Property<string>("SeriNo");

                    b.Property<bool>("Silindi");

                    b.Property<DateTime>("SilmeTarihi");

                    b.Property<int>("SonFaturaNo");

                    b.Property<DateTime>("SonFaturaTarihi");

                    b.HasKey("Id");

                    b.ToTable("SeriNumaralars");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRole", b =>
                {
                    b.Property<string>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken();

                    b.Property<string>("Name")
                        .HasMaxLength(256);

                    b.Property<string>("NormalizedName")
                        .HasMaxLength(256);

                    b.HasKey("Id");

                    b.HasIndex("NormalizedName")
                        .IsUnique()
                        .HasName("RoleNameIndex")
                        .HasFilter("[NormalizedName] IS NOT NULL");

                    b.ToTable("AspNetRoles");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("ClaimType");

                    b.Property<string>("ClaimValue");

                    b.Property<string>("RoleId")
                        .IsRequired();

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetRoleClaims");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("ClaimType");

                    b.Property<string>("ClaimValue");

                    b.Property<string>("UserId")
                        .IsRequired();

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserClaims");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.Property<string>("LoginProvider");

                    b.Property<string>("ProviderKey");

                    b.Property<string>("ProviderDisplayName");

                    b.Property<string>("UserId")
                        .IsRequired();

                    b.HasKey("LoginProvider", "ProviderKey");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserLogins");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.Property<string>("UserId");

                    b.Property<string>("RoleId");

                    b.HasKey("UserId", "RoleId");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetUserRoles");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.Property<string>("UserId");

                    b.Property<string>("LoginProvider");

                    b.Property<string>("Name");

                    b.Property<string>("Value");

                    b.HasKey("UserId", "LoginProvider", "Name");

                    b.ToTable("AspNetUserTokens");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole")
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.HasOne("EfaturaPortal.Models.AppUser")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.HasOne("EfaturaPortal.Models.AppUser")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole")
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("EfaturaPortal.Models.AppUser")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.HasOne("EfaturaPortal.Models.AppUser")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });
#pragma warning restore 612, 618
        }
    }
}
