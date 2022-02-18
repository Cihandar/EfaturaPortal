using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class AddFirmaturutoUserApp2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<float>(
                name: "StopajOran",
                table: "FaturaSatirs",
                type: "real",
                nullable: false,
                defaultValue: 0f);

            migrationBuilder.AddColumn<float>(
                name: "StopajTutar",
                table: "FaturaSatirs",
                type: "real",
                nullable: false,
                defaultValue: 0f);

            migrationBuilder.AddColumn<float>(
                name: "Stopaj",
                table: "Faturas",
                type: "real",
                nullable: false,
                defaultValue: 0f);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "StopajOran",
                table: "FaturaSatirs");

            migrationBuilder.DropColumn(
                name: "StopajTutar",
                table: "FaturaSatirs");

            migrationBuilder.DropColumn(
                name: "Stopaj",
                table: "Faturas");
        }
    }
}
