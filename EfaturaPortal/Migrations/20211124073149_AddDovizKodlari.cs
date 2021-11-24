using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class AddDovizKodlari : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Doviz",
                table: "Faturas",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "DovizKodlaris",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    DovizKodu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DovizAdi = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    FirmaId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Silindi = table.Column<bool>(type: "bit", nullable: false),
                    SilmeTarihi = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DovizKodlaris", x => x.Id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DovizKodlaris");

            migrationBuilder.DropColumn(
                name: "Doviz",
                table: "Faturas");
        }
    }
}
