using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class updateiskontotutar2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "IstisnaAciklama",
                table: "FaturaSatirs",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "IstisnaKodu",
                table: "FaturaSatirs",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TevkifatAdi",
                table: "FaturaSatirs",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TevkifatKodu",
                table: "FaturaSatirs",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TevkifatOran",
                table: "FaturaSatirs",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<float>(
                name: "TevkifatTutar",
                table: "FaturaSatirs",
                type: "real",
                nullable: false,
                defaultValue: 0f);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IstisnaAciklama",
                table: "FaturaSatirs");

            migrationBuilder.DropColumn(
                name: "IstisnaKodu",
                table: "FaturaSatirs");

            migrationBuilder.DropColumn(
                name: "TevkifatAdi",
                table: "FaturaSatirs");

            migrationBuilder.DropColumn(
                name: "TevkifatKodu",
                table: "FaturaSatirs");

            migrationBuilder.DropColumn(
                name: "TevkifatOran",
                table: "FaturaSatirs");

            migrationBuilder.DropColumn(
                name: "TevkifatTutar",
                table: "FaturaSatirs");
        }
    }
}
