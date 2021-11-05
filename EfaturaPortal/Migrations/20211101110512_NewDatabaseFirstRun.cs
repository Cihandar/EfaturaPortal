using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class NewDatabaseFirstRun : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AspNetRoles",
                columns: table => new
                {
                    Id = table.Column<string>(nullable: false),
                    Name = table.Column<string>(maxLength: 256, nullable: true),
                    NormalizedName = table.Column<string>(maxLength: 256, nullable: true),
                    ConcurrencyStamp = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUsers",
                columns: table => new
                {
                    Id = table.Column<string>(nullable: false),
                    UserName = table.Column<string>(maxLength: 256, nullable: true),
                    NormalizedUserName = table.Column<string>(maxLength: 256, nullable: true),
                    Email = table.Column<string>(maxLength: 256, nullable: true),
                    NormalizedEmail = table.Column<string>(maxLength: 256, nullable: true),
                    EmailConfirmed = table.Column<bool>(nullable: false),
                    PasswordHash = table.Column<string>(nullable: true),
                    SecurityStamp = table.Column<string>(nullable: true),
                    ConcurrencyStamp = table.Column<string>(nullable: true),
                    PhoneNumber = table.Column<string>(nullable: true),
                    PhoneNumberConfirmed = table.Column<bool>(nullable: false),
                    TwoFactorEnabled = table.Column<bool>(nullable: false),
                    LockoutEnd = table.Column<DateTimeOffset>(nullable: true),
                    LockoutEnabled = table.Column<bool>(nullable: false),
                    AccessFailedCount = table.Column<int>(nullable: false),
                    Avatar = table.Column<string>(nullable: true),
                    status = table.Column<byte>(nullable: false),
                    FirmaId = table.Column<Guid>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUsers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Carilers",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    FirmaId = table.Column<Guid>(nullable: false),
                    Silindi = table.Column<bool>(nullable: false),
                    SilmeTarihi = table.Column<DateTime>(nullable: false),
                    Unvani = table.Column<string>(nullable: true),
                    VergiDairesi = table.Column<string>(nullable: true),
                    VergiNumarasi = table.Column<string>(nullable: true),
                    EfaturaTarihi = table.Column<DateTime>(nullable: false),
                    EfaturaPostaKutusu = table.Column<string>(nullable: true),
                    Sehir = table.Column<string>(nullable: true),
                    Ilce = table.Column<string>(nullable: true),
                    Adres = table.Column<string>(nullable: true),
                    Email = table.Column<string>(nullable: true),
                    Telefon = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Carilers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Faturas",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    FirmaId = table.Column<Guid>(nullable: false),
                    Silindi = table.Column<bool>(nullable: false),
                    SilmeTarihi = table.Column<DateTime>(nullable: false),
                    FaturaTuru = table.Column<int>(nullable: false),
                    Tarih = table.Column<DateTime>(nullable: false),
                    SeriNumaralarId = table.Column<Guid>(nullable: false),
                    FaturaTipi = table.Column<string>(nullable: true),
                    FaturaSenaryo = table.Column<string>(nullable: true),
                    ParaBirimi = table.Column<string>(nullable: true),
                    DovizKuru = table.Column<double>(nullable: false),
                    CarilerId = table.Column<Guid>(nullable: false),
                    OdemeTarihi = table.Column<DateTime>(nullable: false),
                    OdemeSekli = table.Column<string>(nullable: true),
                    OdemeKanali = table.Column<string>(nullable: true),
                    OdemeHesapNo = table.Column<string>(nullable: true),
                    Notlar = table.Column<string>(nullable: true),
                    YaziylaTutar = table.Column<string>(nullable: true),
                    Toplam = table.Column<double>(nullable: false),
                    Artirim = table.Column<double>(nullable: false),
                    Iskonto = table.Column<double>(nullable: false),
                    Kdv = table.Column<double>(nullable: false),
                    OdenecekTutar = table.Column<double>(nullable: false),
                    ETTN = table.Column<Guid>(nullable: false),
                    EfaturaDurum = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Faturas", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "FaturaSatirs",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    FirmaId = table.Column<Guid>(nullable: false),
                    Silindi = table.Column<bool>(nullable: false),
                    SilmeTarihi = table.Column<DateTime>(nullable: false),
                    FaturaId = table.Column<Guid>(nullable: false),
                    Sirano = table.Column<int>(nullable: false),
                    Aciklama = table.Column<string>(nullable: true),
                    Miktar = table.Column<double>(nullable: false),
                    OlcuBirimi = table.Column<string>(nullable: true),
                    Tutar = table.Column<double>(nullable: false),
                    IskontoDurum = table.Column<string>(nullable: true),
                    IskontoOran = table.Column<double>(nullable: false),
                    IskontoTutar = table.Column<int>(nullable: false),
                    KdvOran = table.Column<double>(nullable: false),
                    KdvTutar = table.Column<double>(nullable: false),
                    KdvliTutar = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FaturaSatirs", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Firmalars",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Unvani = table.Column<string>(nullable: true),
                    VergiDairesi = table.Column<string>(nullable: true),
                    VergiNumarasi = table.Column<string>(nullable: true),
                    YetkiliAdSoyad = table.Column<string>(nullable: true),
                    Adres = table.Column<string>(nullable: true),
                    Sehir = table.Column<string>(nullable: true),
                    Ilce = table.Column<string>(nullable: true),
                    PostaKodu = table.Column<string>(nullable: true),
                    Email = table.Column<string>(nullable: true),
                    Telefon = table.Column<string>(nullable: true),
                    FirmaTuru = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Firmalars", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "OlcuBirimleris",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    FirmaId = table.Column<Guid>(nullable: false),
                    Silindi = table.Column<bool>(nullable: false),
                    SilmeTarihi = table.Column<DateTime>(nullable: false),
                    Kodu = table.Column<string>(nullable: true),
                    Adi = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OlcuBirimleris", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ParaBirimleris",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    FirmaId = table.Column<Guid>(nullable: false),
                    Silindi = table.Column<bool>(nullable: false),
                    SilmeTarihi = table.Column<DateTime>(nullable: false),
                    Kodu = table.Column<string>(nullable: true),
                    Adi = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ParaBirimleris", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "SeriNumaralars",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    FirmaId = table.Column<Guid>(nullable: false),
                    Silindi = table.Column<bool>(nullable: false),
                    SilmeTarihi = table.Column<DateTime>(nullable: false),
                    FaturaTuru = table.Column<int>(nullable: false),
                    SeriNo = table.Column<string>(nullable: true),
                    SonFaturaNo = table.Column<int>(nullable: false),
                    SonFaturaTarihi = table.Column<DateTime>(nullable: false),
                    Oncelik = table.Column<int>(nullable: false),
                    Sablon = table.Column<byte[]>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SeriNumaralars", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "AspNetRoleClaims",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    RoleId = table.Column<string>(nullable: false),
                    ClaimType = table.Column<string>(nullable: true),
                    ClaimValue = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoleClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetRoleClaims_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserClaims",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    UserId = table.Column<string>(nullable: false),
                    ClaimType = table.Column<string>(nullable: true),
                    ClaimValue = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetUserClaims_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserLogins",
                columns: table => new
                {
                    LoginProvider = table.Column<string>(nullable: false),
                    ProviderKey = table.Column<string>(nullable: false),
                    ProviderDisplayName = table.Column<string>(nullable: true),
                    UserId = table.Column<string>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserLogins", x => new { x.LoginProvider, x.ProviderKey });
                    table.ForeignKey(
                        name: "FK_AspNetUserLogins_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserRoles",
                columns: table => new
                {
                    UserId = table.Column<string>(nullable: false),
                    RoleId = table.Column<string>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserRoles", x => new { x.UserId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserTokens",
                columns: table => new
                {
                    UserId = table.Column<string>(nullable: false),
                    LoginProvider = table.Column<string>(nullable: false),
                    Name = table.Column<string>(nullable: false),
                    Value = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserTokens", x => new { x.UserId, x.LoginProvider, x.Name });
                    table.ForeignKey(
                        name: "FK_AspNetUserTokens_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AspNetRoleClaims_RoleId",
                table: "AspNetRoleClaims",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "RoleNameIndex",
                table: "AspNetRoles",
                column: "NormalizedName",
                unique: true,
                filter: "[NormalizedName] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserClaims_UserId",
                table: "AspNetUserClaims",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserLogins_UserId",
                table: "AspNetUserLogins",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserRoles_RoleId",
                table: "AspNetUserRoles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "EmailIndex",
                table: "AspNetUsers",
                column: "NormalizedEmail");

            migrationBuilder.CreateIndex(
                name: "UserNameIndex",
                table: "AspNetUsers",
                column: "NormalizedUserName",
                unique: true,
                filter: "[NormalizedUserName] IS NOT NULL");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AspNetRoleClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserLogins");

            migrationBuilder.DropTable(
                name: "AspNetUserRoles");

            migrationBuilder.DropTable(
                name: "AspNetUserTokens");

            migrationBuilder.DropTable(
                name: "Carilers");

            migrationBuilder.DropTable(
                name: "Faturas");

            migrationBuilder.DropTable(
                name: "FaturaSatirs");

            migrationBuilder.DropTable(
                name: "Firmalars");

            migrationBuilder.DropTable(
                name: "OlcuBirimleris");

            migrationBuilder.DropTable(
                name: "ParaBirimleris");

            migrationBuilder.DropTable(
                name: "SeriNumaralars");

            migrationBuilder.DropTable(
                name: "AspNetRoles");

            migrationBuilder.DropTable(
                name: "AspNetUsers");
        }
    }
}
