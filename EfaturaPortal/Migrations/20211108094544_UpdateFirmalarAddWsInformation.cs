using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class UpdateFirmalarAddWsInformation : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "WsGbKodu",
                table: "Firmalars",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "WsKullaniciAdi",
                table: "Firmalars",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "WsPkKodu",
                table: "Firmalars",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "WsSifre",
                table: "Firmalars",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "WsGbKodu",
                table: "Firmalars");

            migrationBuilder.DropColumn(
                name: "WsKullaniciAdi",
                table: "Firmalars");

            migrationBuilder.DropColumn(
                name: "WsPkKodu",
                table: "Firmalars");

            migrationBuilder.DropColumn(
                name: "WsSifre",
                table: "Firmalars");
        }
    }
}
